//! The luau documentation API

use full_moon::visitors::Visitor;
use mlua::prelude::*;
use std::{
    cell::RefCell,
    path::{Component, Path, PathBuf},
    rc::Rc,
};

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

pub fn require(
    lua: &Lua,
    current_path: &RefCell<std::path::PathBuf>,
    pat: String,
    req_builtins: bool,
    requires_cache: &RefCell<std::collections::HashMap<String, LuaMultiValue>>,
) -> LuaResult<LuaMultiValue> {
    // require path must start with a valid prefix: ./, ../ or @ for rbs
    if !pat.starts_with("./") && !pat.starts_with("../") && !pat.starts_with("@") {
        return Err(LuaError::external(format!(
            "Invalid require path: {}. Must start with ./, ../ or @ to comply with luau require-by-string semantics",
            pat
        )));
    }

    let curr_path = {
        let p = current_path.borrow();
        p.clone()
    };

    log::debug!("Current path: {:?} when requiring {}", curr_path, pat);
    let mut pat = {
        let mut path = current_path.borrow_mut();
        *path = normalize_path(&path.join(&pat));

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

    log::debug!(
        "Resolved: Current path: {:?} when requiring {}",
        curr_path,
        pat
    );

    if pat.ends_with(".luau") {
        return Err(LuaError::external(format!(
            "Failed to require file {}. .luau extension must be removed to comply with luau require-by-string semantics",
            pat
        )));
    }

    pat = format!("{}.luau", pat);

    pat = pat
        .trim_start_matches("/")
        .trim_start_matches("./")
        .to_string();

    let file_contents = if req_builtins {
        // Get required file from builtins
        if let Some(file) = crate::BUILTINS.get_file(&pat) {
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

            file_contents.to_string()
        } else {
            // Restore the current path
            let mut path = current_path.borrow_mut();
            *path = curr_path;
            drop(path);

            return Err(LuaError::external(format!(
                "Failed to get file {} from builtins",
                pat
            )));
        }
    } else {
        // Check if the file is cached
        if let Some(cached) = requires_cache.borrow().get(&pat) {
            log::debug!("[Require] Cached: {:?}", cached);
            // Restore the current path
            let mut path = current_path.borrow_mut();
            *path = curr_path;
            drop(path);

            return Ok(cached.clone());
        }

        // Get required file from current path
        let file_contents = match std::fs::read_to_string(&pat) {
            Ok(str) => str,
            Err(_) => {
                // Restore the current path
                let mut path = current_path.borrow_mut();
                *path = curr_path;
                drop(path);

                return Err(LuaError::external(format!("Failed to read file {}", pat)));
            }
        };

        file_contents
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
}

#[derive(serde::Serialize, serde::Deserialize)]
pub struct ParseToTypeSetArgs {
    /// The contents of the Luau file to parse
    contents: String,

    /// Whether to visit non-exported types
    ///
    /// Defaults to false
    include_nonexported_types: Option<bool>,
}

pub struct Globals {
    pub documentor_args: Vec<String>,
    pub require_builtins: Rc<RefCell<bool>>,
}

impl LuaUserData for Globals {
    fn add_fields<F: LuaUserDataFields<Self>>(fields: &mut F) {
        fields.add_field_method_get("documentor_args", |lua, this| {
            lua.to_value_with(
                &this.documentor_args,
                LuaSerializeOptions::new().serialize_none_to_null(false),
            )
        });

        fields.add_field_method_get("require_builtins", |_, this| {
            Ok(*this.require_builtins.borrow())
        });

        fields.add_field_method_set("require_builtins", |_, this, value: bool| {
            *this.require_builtins.borrow_mut() = value;
            Ok(())
        });
    }

    fn add_methods<M: LuaUserDataMethods<Self>>(methods: &mut M) {
        methods.add_function("parsetotypeset", |lua, data: LuaValue| {
            let args: ParseToTypeSetArgs = lua.from_value(data)?;

            let result = full_moon::parse_fallible(&args.contents, full_moon::LuaVersion::luau());
            if !result.errors().is_empty() {
                let mut error = "ParseScriptFileError\n".to_string();
                for err in result.errors() {
                    error.push_str(&format!("{}\n", err));
                }
                return Err(LuaError::external(error));
            }

            let mut type_visitor = crate::type_gen::TypeBlockVisitor {
                include_nonexported_types: args.include_nonexported_types.unwrap_or(false),
                ..Default::default()
            };

            let ast = result.into_ast();

            type_visitor.visit_ast(&ast);

            #[derive(serde::Serialize)]
            struct TypeSet {
                types: Vec<crate::type_gen::Type>,
            }

            let typeset = lua.to_value_with(
                &TypeSet {
                    types: type_visitor.found_types,
                },
                LuaSerializeOptions::new().serialize_none_to_null(false),
            )?;

            let result_table = lua.create_table()?;
            result_table.set("unsupported_count", type_visitor.unsupported_count)?;
            result_table.set("typeset", typeset)?;

            Ok(result_table)
        });

        methods.add_function("fs_readfile", |_lua, path: String| {
            let contents = std::fs::read_to_string(&path)
                .map_err(|e| LuaError::external(format!("Failed to read file: {}", e)))?;
            Ok(contents)
        });

        methods.add_function(
            "fs_writefile",
            |_lua, (path, contents): (String, String)| {
                std::fs::write(&path, &contents)
                    .map_err(|e| LuaError::external(format!("Failed to write file: {}", e)))?;
                Ok(())
            },
        );
    }
}
