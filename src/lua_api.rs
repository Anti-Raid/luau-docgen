//! The luau documentation API

use mlua::prelude::*;
use std::{cell::RefCell, rc::Rc};

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
        fields.add_field_method_get("raw_types_table", |lua, this| {
            // Check for cached serialized data
            let mut cached_data = this
                .cached_data
                .try_borrow_mut()
                .map_err(|e| LuaError::external(e.to_string()))?;

            if let Some(v) = cached_data.as_ref() {
                return Ok(v.clone());
            }

            let v = lua.to_value(&this.types)?;

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
        fields.add_field_method_get("inner_data", |lua, this| {
            let typ = this.inner_typ.clone();
            let data = lua.to_value(&typ)?;

            Ok(data)
        });
    }

    fn add_methods<M: LuaUserDataMethods<Self>>(methods: &mut M) {
        methods.add_method("type", |_, this, _: ()| match this.inner_typ {
            crate::type_gen::Type::TypeDef { .. } => Ok("typedef".to_string()),
            crate::type_gen::Type::Function { .. } => Ok("function".to_string()),
        });

        methods.add_method("name", |_, this, _: ()| {
            let name = this.inner_typ.name();
            Ok(name)
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

        // Returns the string representation of the type
        methods.add_method("raw_repr", |_, this, _: ()| {
            let name = this.inner_typ.raw_repr();
            Ok(name)
        });
    }
}
