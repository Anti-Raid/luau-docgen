mod lua_api;
mod token_ref_extractor;
mod type_gen;

use include_dir::{Dir, include_dir};
use lua_api::Globals;
use mlua::prelude::*;
use std::{cell::RefCell, path::PathBuf, rc::Rc};

pub static BUILTINS: Dir = include_dir!("$CARGO_MANIFEST_DIR/documentor_core");

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

    // Setup Luau
    let lua =
        Lua::new_with(LuaStdLib::ALL_SAFE, LuaOptions::default()).expect("Failed to create Lua");

    let compiler = mlua::Compiler::new()
        .set_mutable_globals(vec!["_G".to_string()])
        .set_optimization_level(2);

    lua.set_compiler(compiler);

    let require_builtins: Rc<RefCell<bool>> = Rc::new(RefCell::new(true));
    let lua_api_require_builtins = require_builtins.clone();

    let current_path: Rc<RefCell<std::path::PathBuf>> = Rc::new(RefCell::new(PathBuf::from("/")));
    let requires_cache: Rc<RefCell<std::collections::HashMap<String, LuaMultiValue>>> =
        Rc::new(RefCell::new(std::collections::HashMap::new()));
    lua.globals()
        .set(
            "require",
            lua.create_function(move |lua, pat: String| {
                let require_builtins = *require_builtins.borrow();
                lua_api::require(lua, &current_path, pat, require_builtins, &requires_cache)
            })
            .expect("Failed to create require function"),
        )
        .expect("Failed to set require global");

    lua.sandbox(true).expect("Sandboxed VM"); // Sandbox VM

    let args_mv = (Globals {
        documentor_args: args,
        require_builtins: lua_api_require_builtins,
    })
    .into_lua_multi(&lua)
    .expect("Failed to convert TypeSet to LuaMultiValue");

    let init_func = match lua
        .load(documentor)
        .set_name("documentor")
        .call::<LuaFunction>(())
    {
        Ok(func) => func,
        Err(err) => {
            eprintln!("{}", err);
            std::process::exit(1);
        }
    };

    if let Err(err) = init_func.call::<()>(args_mv) {
        eprintln!("{}", err);
        std::process::exit(1);
    }
}
