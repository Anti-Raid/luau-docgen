mod comments;
mod lua_api;
mod token_ref_extractor;
mod token_ref_extractor_v2;
mod type_gen;

use full_moon::{parse_fallible, visitors::Visitor};
use lua_api::{Globals, TypeSet};
use mlua::prelude::*;
use mlua_scheduler::XRc;
use std::{path::PathBuf, time::Duration};
use type_gen::TypeBlockVisitor;

pub static DEFAULT_DOCUMENTOR: &str = include_str!("documentor.luau");

#[derive(Debug, clap::Parser)]
struct CliArgs {
    #[arg(name = "path")]
    /// The path to the script to document
    script: PathBuf,

    #[arg(long = "documentor")]
    /// The path to the documentor script
    documentor: Option<PathBuf>,

    #[arg(long = "error-on-unsupported", default_value_t = true)]
    /// Whether to error on unsupported types
    ///
    /// Defaults to true
    error_on_unsupported: bool,

    #[arg(long = "include-nonexported-types", default_value_t = false)]
    /// Whether to visit non-exported types
    ///
    /// Defaults to false
    include_nonexported_types: bool,
}

fn main() {
    let args = <CliArgs as clap::Parser>::parse();

    if !args.script.exists() {
        eprintln!("Error: Script file does not exist: {:?}", args.script);
        std::process::exit(1);
    }

    let source = std::fs::read_to_string(&args.script).unwrap_or_else(|_| {
        eprintln!("Error: Failed to read script file: {:?}", args.script);
        std::process::exit(1);
    });

    let mut type_visitor = TypeBlockVisitor {
        found_types: Vec::new(),
        unsupported_count: 0,
        include_nonexported_types: args.include_nonexported_types,
    };

    let result = parse_fallible(&source, full_moon::LuaVersion::luau());
    if !result.errors().is_empty() {
        eprintln!("Error: Failed to parse script file: {:?}", args.script);
        for error in result.errors() {
            eprintln!("Error: {:?}", error);
        }
        std::process::exit(1);
    }

    let ast = result.into_ast();

    type_visitor.visit_ast(&ast);

    if type_visitor.unsupported_count > 0 {
        eprintln!(
            "Error: Found {} unsupported types",
            type_visitor.unsupported_count
        );
        if args.error_on_unsupported {
            std::process::exit(1);
        }
    }

    let documentor = if let Some(documentor_path) = args.documentor {
        std::fs::read_to_string(documentor_path).unwrap_or_else(|_| {
            eprintln!("Error: Failed to read documentor file");
            std::process::exit(1);
        })
    } else {
        DEFAULT_DOCUMENTOR.to_string()
    };

    // Create tokio runtime and use spawn_local
    let rt = tokio::runtime::Builder::new_current_thread()
        .enable_all()
        .worker_threads(10)
        .build()
        .unwrap();

    let local = tokio::task::LocalSet::new();

    let values = local
        .block_on(&rt, async {
            // Setup Luau
            let lua = Lua::new_with(LuaStdLib::ALL_SAFE, LuaOptions::default())
                .expect("Failed to create Lua");

            let compiler = mlua::Compiler::new().set_optimization_level(2);

            lua.set_compiler(compiler);

            let thread_tracker = mlua_scheduler_ext::feedbacks::ThreadTracker::new();

            lua.set_app_data(thread_tracker.clone());

            let task_mgr = mlua_scheduler::taskmgr::TaskManager::new(
                lua.clone(),
                XRc::new(thread_tracker),
                Duration::from_millis(1),
            );

            let scheduler = mlua_scheduler_ext::Scheduler::new(task_mgr.clone());

            scheduler.attach();

            let scheduler_lib = mlua_scheduler::userdata::scheduler_lib(&lua)
                .expect("Failed to create scheduler lib");

            lua.globals()
                .set("scheduler", scheduler_lib.clone())
                .expect("Failed to set scheduler global");

            lua.globals()
                .set(
                    "task",
                    mlua_scheduler::userdata::task_lib(&lua, scheduler_lib)
                        .expect("Failed to create table"),
                )
                .expect("Failed to set task global");

            mlua_scheduler::userdata::patch_coroutine_lib(&lua)
                .expect("Failed to patch coroutine lib");

            lua.sandbox(true).expect("Sandboxed VM"); // Sandbox VM

            let f = lua
                .load(documentor)
                .set_name("documentor")
                .into_function()?;

            let th = lua.create_thread(f)?;

            let args = (TypeSet::new(type_visitor.found_types), Globals {})
                .into_lua_multi(&lua)
                .expect("Failed to convert TypeSet to LuaMultiValue");

            let scheduler = mlua_scheduler_ext::Scheduler::get(&lua);
            let output = scheduler
                .spawn_thread_and_wait("SpawnScript", th, args)
                .await?;

            match output {
                Some(result) => result,
                None => Ok(LuaMultiValue::new()),
            }
        })
        .expect("Error: Creation of documentation failed");

    if !values.is_empty() {
        println!(
            "{}",
            values
                .iter()
                .map(|value| format!("{:#?}", value))
                .collect::<Vec<_>>()
                .join("\t")
        );
    }
}
