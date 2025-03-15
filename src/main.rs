mod args;
mod comments;
mod lua_api;
mod token_ref_extractor;
mod type_gen;

use include_dir::{Dir, include_dir};
use lua_api::Globals;
use mlua::prelude::*;
use mlua_scheduler::XRc;
use std::{
    cell::RefCell,
    path::{Component, Path, PathBuf},
    rc::Rc,
    time::Duration,
};

pub static BUILTINS: Dir = include_dir!("$CARGO_MANIFEST_DIR/src/builtins");

#[derive(Debug, clap::Parser)]
struct CliArgs {
    #[arg(long = "documentor")]
    /// The path to the documentor script
    documentor: Option<PathBuf>,

    /// Root paths are paths that are used to know when something is a builtin require or not
    ///
    /// For example, for a plugin that is in the root of the luau-docgen repo, the root path would be "src/builtins"
    #[arg(long = "root-paths")]
    root_paths: Vec<String>,

    #[arg(trailing_var_arg = true, allow_hyphen_values = true, hide = true)]
    args: Vec<String>,
}

fn main() {
    env_logger::init();

    let args = <CliArgs as clap::Parser>::parse();

    let root_paths = if !args.root_paths.is_empty() {
        args.root_paths
    } else if let Ok(root_path) = std::env::var("ROOT_PATHS") {
        root_path.split(',').map(|s| s.to_string()).collect()
    } else {
        vec!["src/builtins".to_string()]
    };

    let documentor = if let Some(documentor_path) = args.documentor {
        std::fs::read_to_string(documentor_path).unwrap_or_else(|_| {
            eprintln!("Error: Failed to read documentor file");
            std::process::exit(1);
        })
    } else {
        BUILTINS
            .get_file("documentor.luau")
            .expect("Failed to get documentor.luau")
            .contents_utf8()
            .expect("Failed to get documentor.luau contents as UTF-8")
            .to_string()
    };

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

        let old_require = lua
            .globals()
            .get::<mlua::Function>("require")
            .expect("Failed to get require global");

        let current_path: RefCell<std::path::PathBuf> = RefCell::new(PathBuf::from("/"));
        let requires_cache: RefCell<std::collections::HashMap<String, LuaMultiValue>> =
            RefCell::new(std::collections::HashMap::new());
        lua.globals()
            .set(
                "require",
                lua.create_function(move |lua, pat: String| {
                    let mut req_builtins = *require_builtins.borrow();

                    for path in root_paths.iter() {
                        if pat.starts_with(path) {
                            req_builtins = true;
                            break;
                        }
                    }

                    let mut pat = pat;

                    if req_builtins {
                        let pat = {
                            for path in root_paths.iter() {
                                if pat.starts_with(path) {
                                    pat.replace_range(..path.len(), "");
                                }
                            }
                            pat
                        };
                        let curr_path = {
                            let p = current_path.borrow();
                            p.clone()
                        };
                        log::debug!("Current path: {:?} when requiring {}", curr_path, pat);
                        let mut pat = {
                            let mut path = current_path.borrow_mut();

                            path.push(&pat);

                            *path = normalize_path(&path);

                            let end_file = match path.file_name() {
                                Some(c) => c.to_string_lossy().to_string(),
                                None => {
                                    // Restore the current path
                                    *path = curr_path;

                                    return Err(LuaError::external(format!(
                                        "Failed to get file name from path: {:?}",
                                        path
                                    )));
                                }
                            };

                            path.pop();

                            let path_joined = path.join(end_file).to_string_lossy().to_string();

                            drop(path);

                            path_joined
                        };

                        if !pat.ends_with(".luau") {
                            pat = format!("{}.luau", pat);
                        }

                        pat = pat
                            .trim_start_matches("/")
                            .trim_start_matches("./")
                            .to_string();

                        // Get required file from builtins
                        if let Some(file) = BUILTINS.get_file(&pat) {
                            if let Some(cached) = requires_cache.borrow().get(&pat) {
                                log::debug!("[Require] Cached: {:?}", cached);
                                // Restore the current path
                                let mut path = current_path.borrow_mut();
                                *path = curr_path;
                                drop(path);

                                return Ok(cached.clone());
                            }

                            let file_contents = match file.contents_utf8() {
                                Some(str) => str,
                                None => {
                                    // Restore the current path
                                    let mut path = current_path.borrow_mut();
                                    *path = curr_path;
                                    drop(path);

                                    return Err(LuaError::external(format!(
                                        "Failed to get {} contents as UTF-8",
                                        pat
                                    )));
                                }
                            };

                            // Execute the file
                            let ret = lua
                                .load(file_contents)
                                .set_name(&pat)
                                .eval::<LuaMultiValue>();

                            // Restore the current path
                            let mut path = current_path.borrow_mut();
                            *path = curr_path;
                            drop(path);

                            if let Ok(ret) = ret {
                                // Cache the result
                                requires_cache.borrow_mut().insert(pat.clone(), ret.clone());

                                return Ok(ret);
                            }

                            ret
                        } else {
                            // Restore the current path
                            let mut path = current_path.borrow_mut();
                            *path = curr_path;
                            drop(path);

                            Err(LuaError::external(format!("Failed to get {}", pat)))
                        }
                    } else {
                        old_require.call::<LuaMultiValue>(pat)
                    }
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
            documentor_args: args.args,
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

// From Cargo
pub fn normalize_path(path: &Path) -> PathBuf {
    let mut components = path.components().peekable();
    let mut ret = if let Some(c @ Component::Prefix(..)) = components.peek().cloned() {
        components.next();
        PathBuf::from(c.as_os_str())
    } else {
        PathBuf::new()
    };

    for component in components {
        match component {
            Component::Prefix(..) => unreachable!(),
            Component::RootDir => {
                ret.push(component.as_os_str());
            }
            Component::CurDir => {}
            Component::ParentDir => {
                ret.pop();
            }
            Component::Normal(c) => {
                ret.push(c);
            }
        }
    }
    ret
}
