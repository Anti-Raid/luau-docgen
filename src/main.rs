mod comments;
mod lua_api;
mod token_ref_extractor;
mod type_gen;

use include_dir::{Dir, include_dir};
use lua_api::Globals;
use mlua::prelude::*;
use mlua_scheduler::XRc;
use std::{cell::RefCell, path::PathBuf, rc::Rc, time::Duration};

pub static BUILTINS: Dir = include_dir!("$CARGO_MANIFEST_DIR/src/builtins");

fn main() {
    env_logger::init();

    // Parse command line arguments skipping the first one
    // which is the program name
    let args = std::env::args().skip(1).collect::<Vec<_>>();

    // We always have to use the builtin documentor initially (which can then shell out and load other documentors if desired)
    let documentor = BUILTINS
        .get_file("documentor.luau")
        .expect("Failed to get documentor.luau")
        .contents_utf8()
        .expect("Failed to get documentor.luau contents as UTF-8")
        .to_string();

    // Create tokio runtime and use spawn_local
    let rt = tokio::runtime::Builder::new_current_thread()
        .enable_all()
        .worker_threads(10)
        .build()
        .unwrap();

    let local = tokio::task::LocalSet::new();

    let values = local.block_on(&rt, async {
        // Setup Luau
        let lua = Lua::new_with(LuaStdLib::ALL_SAFE, LuaOptions::default())
            .expect("Failed to create Lua");

        let compiler = mlua::Compiler::new()
            .set_mutable_globals(vec!["_G".to_string()])
            .set_optimization_level(2);

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

        let scheduler_lib =
            mlua_scheduler::userdata::scheduler_lib(&lua).expect("Failed to create scheduler lib");

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

        mlua_scheduler::userdata::patch_coroutine_lib(&lua).expect("Failed to patch coroutine lib");

        let require_builtins: Rc<RefCell<bool>> = Rc::new(RefCell::new(true));
        let lua_api_require_builtins = require_builtins.clone();

        let current_path: Rc<RefCell<std::path::PathBuf>> =
            Rc::new(RefCell::new(PathBuf::from("/")));
        let requires_cache: Rc<RefCell<std::collections::HashMap<String, LuaMultiValue>>> =
            Rc::new(RefCell::new(std::collections::HashMap::new()));
        lua.globals()
            .set(
                "require",
                lua.create_function(move |lua, pat: String| {
                    let require_builtins = *require_builtins.borrow();
                    lua_api::require(lua, &current_path, pat, require_builtins, &requires_cache)
                })?,
            )
            .expect("Failed to set require global");

        lua.sandbox(true).expect("Sandboxed VM"); // Sandbox VM

        let f = lua
            .load(documentor)
            .set_name("documentor")
            .into_function()?;

        let th = lua.create_thread(f)?;

        let args = (Globals {
            documentor_args: args,
            require_builtins: lua_api_require_builtins,
        })
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
    });

    let values = match values {
        Ok(v) => v,
        Err(e) => {
            eprintln!("Error while creating documentation: {}", e);
            std::process::exit(1);
        }
    };

    if !values.is_empty() {
        let output = values
            .iter()
            .map(|value| match value {
                LuaValue::String(s) => s.to_string_lossy(),
                _ => format!("{:#?}", value),
            })
            .collect::<Vec<_>>()
            .join("\t");

        println!("{}", output);
    }
}
