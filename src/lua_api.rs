use mlua::prelude::*;
use std::cell::RefCell;

pub struct TypeSet {
    pub types: Vec<crate::type_gen::Type>,
    cached_data: RefCell<Option<LuaValue>>,
}

impl TypeSet {
    pub fn new(types: Vec<crate::type_gen::Type>) -> Self {
        Self {
            types,
            cached_data: RefCell::new(None),
        }
    }
}

impl LuaUserData for TypeSet {
    fn add_fields<F: LuaUserDataFields<Self>>(fields: &mut F) {
        fields.add_field_method_get("types", |lua, this| {
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
    }
}

impl LuaUserData for crate::type_gen::Type {}
