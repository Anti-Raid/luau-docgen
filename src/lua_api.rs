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

            let result_table = lua.create_table()?;
            result_table.set("unsupported_count", type_visitor.unsupported_count)?;
            result_table.set("typeset", TypeSet::new(type_visitor.found_types))?;

            Ok(result_table)
        });

        // TODO: Think of a better way
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

        methods.add_function("fs_mkdirall", |_lua, path: String| {
            std::fs::create_dir_all(&path)
                .map_err(|e| LuaError::external(format!("Failed to create directory: {}", e)))?;
            Ok(())
        });

        methods.add_function("fs_rmdirall", |_lua, path: String| {
            std::fs::remove_dir_all(path)
                .map_err(|e| LuaError::external(format!("Failed to remove directory: {}", e)))?;
            Ok(())
        });

        methods.add_function("fs_exists", |_lua, path: String| {
            let exists = std::fs::exists(&path).unwrap_or_default();
            Ok(exists)
        });

        methods.add_function("fs_remove", |_lua, path: String| {
            std::fs::remove_file(path)
                .map_err(|e| LuaError::external(format!("Failed to remove file: {}", e)))?;
            Ok(())
        });

        methods.add_function("fs_stat", |lua, path: String| {
            let metadata = std::fs::metadata(&path)
                .map_err(|e| LuaError::external(format!("Failed to stat file: {}", e)))?;
            let result_table = lua.create_table()?;
            result_table.set("is_dir", metadata.is_dir())?;
            result_table.set("is_file", metadata.is_file())?;
            result_table.set("size", metadata.len())?;
            if let Ok(modified) = metadata.modified() {
                if let Ok(elapsed) = modified.elapsed() {
                    result_table.set("modified", elapsed.as_secs())?;
                }
            }
            if let Ok(created) = metadata.created() {
                if let Ok(elapsed) = created.elapsed() {
                    result_table.set("created", elapsed.as_secs())?;
                }
            }
            result_table.set("permissions_readonly", metadata.permissions().readonly())?;
            Ok(result_table)
        });
    }
}

pub struct TypeSet {
    types: Vec<Type>,
    cached_data: RefCell<Option<LuaValue>>,
}

impl TypeSet {
    pub fn new(types: Vec<crate::type_gen::Type>) -> Self {
        Self {
            types: types.into_iter().map(|t| Type { inner_typ: t }).collect(),
            cached_data: RefCell::new(None),
        }
    }
}

impl LuaUserData for TypeSet {
    fn add_fields<F: LuaUserDataFields<Self>>(fields: &mut F) {
        // Returns the full internal representation of the type set as a table
        fields.add_field_method_get("dbg__raw_types_table", |lua, this| {
            // Check for cached serialized data
            let mut cached_data = this
                .cached_data
                .try_borrow_mut()
                .map_err(|e| LuaError::external(e.to_string()))?;

            if let Some(v) = cached_data.as_ref() {
                return Ok(v.clone());
            }

            let v = lua.to_value_with(
                &this.types,
                LuaSerializeOptions::new().serialize_none_to_null(false),
            )?;

            *cached_data = Some(v.clone());

            Ok(v)
        });

        // Returns the types in the set as userdata
        fields.add_field_method_get("raw_types", |_lua, this| {
            let types = this.types.clone();

            Ok(types)
        });
    }

    fn add_methods<M: LuaUserDataMethods<Self>>(methods: &mut M) {
        // Creates an iterator over the typedefs in the set
        methods.add_method("iter_typedefs", |_, this, ()| {
            let iter = TypeIterator::new(
                this.types
                    .iter()
                    .filter(|t| matches!(t.inner_typ, crate::type_gen::Type::TypeDef { .. }))
                    .cloned()
                    .collect(),
            );

            Ok(iter)
        });

        methods.add_method("iter_functions", |_, this, ()| {
            let iter = TypeIterator::new(
                this.types
                    .iter()
                    .filter(|t| matches!(t.inner_typ, crate::type_gen::Type::Function { .. }))
                    .cloned()
                    .collect(),
            );

            Ok(iter)
        });

        // Creates an iterator over all types in the set
        methods.add_method("iter_all", |_, this, ()| {
            let iter = TypeIterator::new(this.types.clone());

            Ok(iter)
        });
    }
}

struct TypeIterator {
    types: Rc<Vec<Type>>,
}

impl TypeIterator {
    fn new(types: Vec<Type>) -> Self {
        Self {
            types: Rc::new(types),
        }
    }
}

impl LuaUserData for TypeIterator {
    fn add_methods<M: LuaUserDataMethods<Self>>(methods: &mut M) {
        methods.add_meta_method(LuaMetaMethod::Iter, |lua, this, ()| {
            let types = this.types.clone();
            let i = RefCell::new(0);
            lua.create_function(move |_, _: ()| {
                let mut i = i.borrow_mut();
                if *i >= types.len() {
                    return Ok(None);
                }

                let typ = types[*i].clone();
                *i += 1;

                Ok(Some(typ))
            })
        });
    }
}

/// A container class for a documentable type
#[derive(Clone, serde::Serialize, serde::Deserialize)]
#[serde(transparent)]
struct Type {
    inner_typ: crate::type_gen::Type,
}

impl LuaUserData for Type {
    fn add_fields<F: LuaUserDataFields<Self>>(fields: &mut F) {
        fields.add_field_method_get("dbg__inner", |lua, this| {
            let typ = this.inner_typ.clone();
            let data = lua.to_value_with(
                &typ,
                LuaSerializeOptions::new().serialize_none_to_null(false),
            )?;

            Ok(data)
        });
    }

    fn add_methods<M: LuaUserDataMethods<Self>>(methods: &mut M) {
        methods.add_method("extract", |lua, this, _: ()| {
            let tab = lua.create_table()?;
            tab.set(
                "type",
                match &this.inner_typ {
                    crate::type_gen::Type::TypeDef { .. } => "TypeDef",
                    crate::type_gen::Type::Function { .. } => "Function",
                },
            )?;

            tab.set(
                "data",
                match &this.inner_typ {
                    crate::type_gen::Type::TypeDef { inner } => TypeDef {
                        inner: inner.clone(),
                    }
                    .into_lua(lua)?,
                    crate::type_gen::Type::Function { inner } => TypeFunction {
                        inner: inner.clone(),
                    }
                    .into_lua(lua)?,
                },
            )?;

            Ok(tab)
        });

        methods.add_method("name", |lua, this, _: ()| {
            let name = this.inner_typ.name();
            let v = lua.to_value_with(
                name,
                LuaSerializeOptions::new().serialize_none_to_null(false),
            )?;
            Ok(v)
        });

        methods.add_method("type_comments", |_, this, _: ()| {
            let type_comments = this.inner_typ.type_comments();
            Ok(type_comments)
        });

        // Returns the *constructed* type representation which may differ from the raw input
        methods.add_method("string_repr", |_, this, _: ()| {
            let name = this.inner_typ.string_repr();
            Ok(name)
        });

        methods.add_method("string_repr_with_pats", |_, this, (fields_join_pat, args_join_pat, generics_join_pat): (String, String, String)| {
            let name = this.inner_typ.string_repr_with_pats(&fields_join_pat, &args_join_pat, &generics_join_pat);
            Ok(name)
        });

        // Returns the string representation of the type
        methods.add_method("raw_repr", |_, this, _: ()| {
            let name = this.inner_typ.raw_repr();
            Ok(name)
        });
    }
}

#[derive(Clone, serde::Serialize, serde::Deserialize)]
#[serde(transparent)]
struct TypeDef {
    inner: Rc<crate::type_gen::TypeDef>,
}

impl LuaUserData for TypeDef {
    fn add_fields<F: LuaUserDataFields<Self>>(fields: &mut F) {
        fields.add_field_method_get("dbg__inner", |lua, this| {
            let typ = this.inner.clone();
            let data = lua.to_value_with(
                &typ,
                LuaSerializeOptions::new().serialize_none_to_null(false),
            )?;

            Ok(data)
        });

        fields.add_field_method_get("name", |_lua, this| Ok(this.inner.name.clone()));
        fields.add_field_method_get("generics", |_lua, this| {
            Ok(this
                .inner
                .generics
                .iter()
                .map(|arg| TypedArgument { inner: arg.clone() })
                .collect::<Vec<_>>())
        });

        fields.add_field_method_get("type_comments", |_lua, this| {
            Ok(this.inner.type_comments.clone())
        });

        fields.add_field_method_get("type_def_type", |_lua, this| {
            Ok(TypeDefType {
                inner: this.inner.type_def_type.clone().into(),
            })
        });

        fields.add_field_method_get("repr", |_lua, this| Ok(this.inner.repr.clone()));
    }

    fn add_methods<M: LuaUserDataMethods<Self>>(methods: &mut M) {
        // Returns the *constructed* type representation which may differ from the raw input
        methods.add_method("string_repr", |_, this, _: ()| {
            let name = this.inner.string_repr();
            Ok(name)
        });

        methods.add_method(
            "string_repr_with_pats",
            |_, this, (fields_join_pat, generics_join_pat): (String, String)| {
                let name = this
                    .inner
                    .string_repr_with_pats(&fields_join_pat, &generics_join_pat);
                Ok(name)
            },
        );
    }
}

/*
    /// The name of the function
    name: String,
    /// String representation of the function declaration
    declaration_repr: String,
    /// The comments associated with the type
    type_comments: Vec<String>,
    /// Generics
    ///
    /// Vec of (name, default type if present)
    generics: Vec<(String, Option<Rc<TypeFieldType>>)>,
    /// The arguments of the function
    args: Vec<(String, Option<Rc<TypeFieldType>>)>,
    /// The return type of the function, if present
    ret: Option<Rc<TypeFieldType>>,
    /// Type of function
    function_type: FunctionType,
*/
#[derive(Clone, serde::Serialize, serde::Deserialize)]
#[serde(transparent)]
struct TypeFunction {
    inner: Rc<crate::type_gen::TypeFunction>,
}

impl LuaUserData for TypeFunction {
    fn add_fields<F: LuaUserDataFields<Self>>(fields: &mut F) {
        fields.add_field_method_get("dbg__inner", |lua, this| {
            let typ = this.inner.clone();
            let data = lua.to_value_with(
                &typ,
                LuaSerializeOptions::new().serialize_none_to_null(false),
            )?;

            Ok(data)
        });

        fields.add_field_method_get("name", |lua, this| {
            lua.to_value_with(
                &this.inner.name,
                LuaSerializeOptions::new().serialize_none_to_null(false),
            )
        });
        fields.add_field_method_get("repr", |lua, this| {
            lua.to_value_with(
                &this.inner.repr,
                LuaSerializeOptions::new().serialize_none_to_null(false),
            )
        });
        fields.add_field_method_get("type_comments", |lua, this| {
            lua.to_value(&this.inner.type_comments)
        });
        fields.add_field_method_get("generics", |_lua, this| {
            Ok(this
                .inner
                .generics
                .iter()
                .map(|arg| TypedArgument { inner: arg.clone() })
                .collect::<Vec<_>>())
        });
        fields.add_field_method_get("args", |_lua, this| {
            Ok(this
                .inner
                .args
                .iter()
                .map(|arg| TypedArgument { inner: arg.clone() })
                .collect::<Vec<_>>())
        });
        fields.add_field_method_get("ret", |_lua, this| {
            Ok(this
                .inner
                .ret
                .as_ref()
                .map(|ret| TypeFieldType { inner: ret.clone() }))
        });
        fields.add_field_method_get("function_type", |_lua, this| {
            match this.inner.function_type {
                crate::type_gen::FunctionType::Normal => Ok("Normal"),
                crate::type_gen::FunctionType::Local => Ok("Local"),
            }
        });
    }

    fn add_methods<M: LuaUserDataMethods<Self>>(methods: &mut M) {
        // Returns the *constructed* type representation which may differ from the raw input
        methods.add_method("string_repr", |_, this, _: ()| {
            let name = this.inner.string_repr();
            Ok(name)
        });

        methods.add_method(
            "string_repr_with_pats",
            |_, this, (args_join_pat, generics_join_pat): (String, String)| {
                let name = this
                    .inner
                    .string_repr_with_pats(&args_join_pat, &generics_join_pat);
                Ok(name)
            },
        );
    }
}

pub struct TypeDefType {
    inner: Rc<crate::type_gen::TypeDefType>,
}

impl LuaUserData for TypeDefType {
    fn add_methods<M: LuaUserDataMethods<Self>>(methods: &mut M) {
        methods.add_method("extract", |lua, this, _g: ()| {
            let (variant_typ, variant_data) = match *this.inner {
                crate::type_gen::TypeDefType::Table { ref fields } => {
                    let fields = fields
                        .iter()
                        .map(|t| TypeField { inner: t.clone() })
                        .collect::<Vec<_>>();

                    ("Table", fields.into_lua(lua)?)
                }
                crate::type_gen::TypeDefType::TypeOfSetMetatable { ref type_info } => (
                    "TypeOfSetMetatable",
                    TypeDefTypeTypeofSetMetatable {
                        inner: type_info.clone(),
                    }
                    .into_lua(lua)?,
                ),
                crate::type_gen::TypeDefType::Uncategorized { ref type_info } => (
                    "Uncategorized",
                    TypeFieldType {
                        inner: type_info.clone(),
                    }
                    .into_lua(lua)?,
                ),
            };

            let tab = lua.create_table()?;
            tab.set("type", variant_typ)?;
            tab.set("data", variant_data)?;

            Ok(tab)
        });
    }
}

pub struct TypeDefTypeTypeofSetMetatable {
    pub inner: crate::type_gen::TypeDefTypeTypeofSetMetatable,
}

impl LuaUserData for TypeDefTypeTypeofSetMetatable {
    fn add_fields<F: LuaUserDataFields<Self>>(fields: &mut F) {
        fields.add_field_method_get("fields", |_lua, this| {
            let fields = this
                .inner
                .fields
                .iter()
                .map(|t| TypeField { inner: t.clone() })
                .collect::<Vec<_>>();
            Ok(fields)
        });

        fields.add_field_method_get("metatable_fields", |_lua, this| {
            let fields = this
                .inner
                .metatable_fields
                .iter()
                .map(|t| TypeField { inner: t.clone() })
                .collect::<Vec<_>>();
            Ok(fields)
        });
    }
}

pub struct TypeField {
    inner: Rc<crate::type_gen::TypeField>,
}

impl LuaUserData for TypeField {
    fn add_fields<F: LuaUserDataFields<Self>>(fields: &mut F) {
        fields.add_field_method_get("repr", |lua, this| {
            lua.to_value_with(
                &this.inner.repr,
                LuaSerializeOptions::new().serialize_none_to_null(false),
            )
        });
        fields.add_field_method_get("comments", |lua, this| {
            lua.to_value_with(
                &this.inner.comments,
                LuaSerializeOptions::new().serialize_none_to_null(false),
            )
        });
        fields.add_field_method_get("field_name", |lua, this| {
            lua.to_value_with(
                &this.inner.field_name,
                LuaSerializeOptions::new().serialize_none_to_null(false),
            )
        });
        fields.add_field_method_get("field_type", |_lua, this| {
            Ok(TypeFieldType {
                inner: this.inner.field_type.clone(),
            })
        });
    }

    fn add_methods<M: LuaUserDataMethods<Self>>(methods: &mut M) {
        methods.add_method("string_repr", |_, this, depth: Option<usize>| {
            Ok(this.inner.string_repr(depth.unwrap_or_default()))
        });

        methods.add_method(
            "string_repr_with_pats",
            |_, this, (comment_write_pat, depth): (String, Option<usize>)| {
                let name = this
                    .inner
                    .string_repr_with_pats(&comment_write_pat, depth.unwrap_or_default());
                Ok(name)
            },
        );
    }
}

pub struct TypeFieldType {
    inner: Rc<crate::type_gen::TypeFieldType>,
}

impl LuaUserData for TypeFieldType {
    fn add_methods<M: LuaUserDataMethods<Self>>(methods: &mut M) {
        methods.add_method("extract", |lua, this, _g: ()| {
            let (variant_typ, variant_data) = match *this.inner {
                crate::type_gen::TypeFieldType::Basic(ref t) => ("Basic", lua.to_value(t)?),
                crate::type_gen::TypeFieldType::String(ref t) => ("String", lua.to_value(t)?),
                crate::type_gen::TypeFieldType::Boolean(t) => ("Boolean", t.into_lua(lua)?),
                crate::type_gen::TypeFieldType::Array(ref tft) => {
                    ("Array", TypeFieldType { inner: tft.clone() }.into_lua(lua)?)
                }
                crate::type_gen::TypeFieldType::Variadic(ref tft) => (
                    "Variadic",
                    TypeFieldType { inner: tft.clone() }.into_lua(lua)?,
                ),
                crate::type_gen::TypeFieldType::VariadicPack(ref t) => {
                    ("VariadicPack", lua.to_value(t)?)
                }
                crate::type_gen::TypeFieldType::Function(ref func) => (
                    "Function",
                    TypeFieldTypeFunction {
                        inner: func.clone(),
                    }
                    .into_lua(lua)?,
                ),
                crate::type_gen::TypeFieldType::Table(ref tft) => {
                    let tft = tft
                        .iter()
                        .map(|tft| TypeField { inner: tft.clone() })
                        .collect::<Vec<_>>();
                    ("Table", tft.into_lua(lua)?)
                }
                crate::type_gen::TypeFieldType::Generic(ref tftg) => (
                    "Generic",
                    TypeFieldTypeGeneric {
                        inner: tftg.clone(),
                    }
                    .into_lua(lua)?,
                ),
                crate::type_gen::TypeFieldType::GenericPack(ref t) => {
                    ("GenericPack", lua.to_value(t)?)
                }
                crate::type_gen::TypeFieldType::Union(ref tft) => {
                    let tft = tft
                        .iter()
                        .map(|tft| TypeFieldType { inner: tft.clone() })
                        .collect::<Vec<_>>();
                    ("Union", tft.into_lua(lua)?)
                }
                crate::type_gen::TypeFieldType::Intersection(ref tft) => {
                    let tft = tft
                        .iter()
                        .map(|tft| TypeFieldType { inner: tft.clone() })
                        .collect::<Vec<_>>();
                    ("Intersection", tft.into_lua(lua)?)
                }
                crate::type_gen::TypeFieldType::Module(ref tftm) => (
                    "Module",
                    TypeFieldTypeModule {
                        inner: tftm.clone(),
                    }
                    .into_lua(lua)?,
                ),
                crate::type_gen::TypeFieldType::UnknownModule(ref t) => {
                    ("UnknownModule", lua.to_value(t)?)
                }
                crate::type_gen::TypeFieldType::Optional(ref tft) => (
                    "Optional",
                    TypeFieldType { inner: tft.clone() }.into_lua(lua)?,
                ),
                crate::type_gen::TypeFieldType::Tuple(ref tft) => {
                    let tft = tft
                        .iter()
                        .map(|tft| TypeFieldType { inner: tft.clone() })
                        .collect::<Vec<_>>();
                    ("Tuple", tft.into_lua(lua)?)
                }
                crate::type_gen::TypeFieldType::TypeOf(ref t) => ("TypeOf", lua.to_value(t)?),
            };

            let tab = lua.create_table()?;
            tab.set("type", variant_typ)?;
            tab.set("data", variant_data)?;

            Ok(tab)
        });

        // Recursively find the inner set of types that compose/make up a TypeFieldType
        methods.add_method("unwind", |_, this, _g: ()| {
            let unwinded = this.inner.unwind();

            let unwinded = unwinded
                .into_iter()
                .map(|tft| TypeFieldType { inner: tft })
                .collect::<Vec<_>>();

            Ok(unwinded)
        });

        methods.add_method("string_repr", |_, this, depth: Option<usize>| {
            Ok(this.inner.string_repr(depth.unwrap_or_default()))
        });
    }
}

pub struct TypedArgument {
    pub inner: crate::type_gen::TypedArgument,
}

impl LuaUserData for TypedArgument {
    fn add_fields<F: LuaUserDataFields<Self>>(fields: &mut F) {
        fields.add_field_method_get("name", |lua, this| {
            lua.to_value_with(
                &this.inner.name,
                LuaSerializeOptions::new().serialize_none_to_null(false),
            )
        });
        fields.add_field_method_get("typ", |lua, this| {
            if let Some(ref typ) = this.inner.typ {
                TypeFieldType { inner: typ.clone() }.into_lua(lua)
            } else {
                Ok(LuaValue::Nil)
            }
        });
        fields.add_field_method_get("punctuation", |_lua, this| {
            Ok(this.inner.punctuation.clone())
        });
    }

    fn add_methods<M: LuaUserDataMethods<Self>>(methods: &mut M) {
        methods.add_method(
            "string_repr",
            |_, this, (with_punctuation, is_generic): (Option<bool>, Option<bool>)| {
                Ok(this.inner.string_repr(
                    with_punctuation.unwrap_or(false),
                    is_generic.unwrap_or(false),
                ))
            },
        );
    }
}

pub struct TypeFieldTypeFunction {
    pub inner: crate::type_gen::TypeFieldTypeFunction,
}

impl LuaUserData for TypeFieldTypeFunction {
    fn add_fields<F: LuaUserDataFields<Self>>(fields: &mut F) {
        fields.add_field_method_get("generics", |lua, this| {
            this.inner
                .generics
                .iter()
                .map(|t| TypedArgument { inner: t.clone() })
                .collect::<Vec<_>>()
                .into_lua(lua)
        });

        fields.add_field_method_get("args", |lua, this| {
            this.inner
                .args
                .iter()
                .map(|t| TypedArgument { inner: t.clone() })
                .collect::<Vec<_>>()
                .into_lua(lua)
        });

        fields.add_field_method_get("ret", |_lua, this| {
            Ok(TypeFieldType {
                inner: this.inner.ret.clone(),
            })
        });
    }

    fn add_methods<M: LuaUserDataMethods<Self>>(methods: &mut M) {
        methods.add_method("string_repr", |_, this, _g: ()| {
            Ok(this.inner.string_repr())
        });
    }
}

pub struct TypeFieldTypeGeneric {
    pub inner: crate::type_gen::TypeFieldTypeGeneric,
}

impl LuaUserData for TypeFieldTypeGeneric {
    fn add_fields<F: LuaUserDataFields<Self>>(fields: &mut F) {
        fields.add_field_method_get("base", |lua, this| lua.to_value(&this.inner.base));
        fields.add_field_method_get("generics", |_lua, this| {
            Ok(this
                .inner
                .generics
                .iter()
                .map(|tft| TypeFieldType { inner: tft.clone() })
                .collect::<Vec<_>>())
        });
    }

    fn add_methods<M: LuaUserDataMethods<Self>>(methods: &mut M) {
        methods.add_method("string_repr", |_, this, _g: ()| {
            Ok(this.inner.string_repr())
        });
    }
}

// Module { pub module: String, pub base: String, pub generics: Option<Vec<Rc<TypeFieldType>>>, }
pub struct TypeFieldTypeModule {
    pub inner: crate::type_gen::TypeFieldTypeModule,
}

impl LuaUserData for TypeFieldTypeModule {
    fn add_fields<F: LuaUserDataFields<Self>>(fields: &mut F) {
        fields.add_field_method_get("module", |lua, this| lua.to_value(&this.inner.module));
        fields.add_field_method_get("base", |lua, this| lua.to_value(&this.inner.base));
        fields.add_field_method_get("generics", |lua, this| {
            if let Some(ref generics) = this.inner.generics {
                generics
                    .iter()
                    .map(|tft| TypeFieldType { inner: tft.clone() })
                    .collect::<Vec<_>>()
                    .into_lua(lua)
            } else {
                Ok(LuaValue::Nil)
            }
        });
    }

    fn add_methods<M: LuaUserDataMethods<Self>>(methods: &mut M) {
        methods.add_method("string_repr", |_, this, _g: ()| {
            Ok(this.inner.string_repr())
        });
    }
}
