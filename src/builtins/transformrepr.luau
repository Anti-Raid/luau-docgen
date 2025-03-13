--!strict

--- Pure luau version of typefieldtypes transformRepr

local tableext = require("table.luau")
local types = require("types.luau")

--- Returns the string representation of a type field type
--- @public_api
local function transformRepr(s: types.TypeFieldType, depth: number, transformStr: (typ: string, string) -> string)
    local self = s:extract()
    if self.type == "Basic" then
        return transformStr("Basic", self.data)
    elseif self.type == "String" then
        return transformStr("String", self.data)
    elseif self.type == "Boolean" then
        return transformStr("Boolean", tostring(self.data))
    elseif self.type == "Array" then
        return string.format("{%s}", transformRepr(self.data, depth, transformStr))
    elseif self.type == "Variadic" then
        return string.format("...%s", transformRepr(self.data, depth, transformStr))
    elseif self.type == "Generic" then
        return transformGenericRepr(self.data, transformStr)
    elseif self.type == "GenericPack" then
        return self.data
    elseif self.type == "Module" then
        return transformModuleRepr(self.data, transformStr)
    elseif self.type == "UnknownModule" then
        return self.data
    elseif self.type == "TypeOf" then
        return self.data
    elseif self.type == "Optional" then
        return string.format("%s?", transformRepr(self.data, depth, transformStr))
    elseif self.type == "Function" then
        return transformFunctionRepr(self.data, transformStr)
    elseif self.type == "Table" then
        --[[
                if fields.is_empty() {
                    return "{}".to_string();
                }

                let fields_str = fields
                    .iter()
                    .map(|f| {
                        f.string_repr_with_pats(
                            format!("\n{}", "\t".repeat(depth + 1)).as_str(),
                            depth + 1,
                        )
                    })
                    .collect::<Vec<_>>()
                    .join(&format!(",\n\n{}", "\t".repeat(depth + 1)));

                format!(
                    "{{\n{}{}\n{}}}",
                    "\t".repeat(depth + 1),
                    fields_str,
                    "\t".repeat(depth)
                )
        ]]

        if #self.data == 0 then
            return "{}"
        end


        local fieldsStr = table.concat(
            tableext.arraymap(
                self.data, 
                function(a: types.TypeField) : string
                    return transformTypeFieldReprWithPat(a, depth+1, string.format("\n%s", string.rep("\t", depth+1)), transformStr)
                end
            ), 
            string.format(",\n\n%s", string.rep("\t", depth+1))
        )

        return string.format(
            "{\n%s%s\n%s}",
            string.rep("\t", depth+1),
            fieldsStr,
            string.rep("\t", depth)
        )
    elseif self.type == "Tuple" then
        local types_str_list = {}
        for i, t in ipairs(self.data) do
            table.insert(types_str_list, t:string_repr(depth))
        end
        local types_str = table.concat(types_str_list, ", ")
        return string.format("(%s)", types_str)
    elseif self.type == "VariadicPack" then
        return string.format("...%s", self.data)
    elseif self.type == "Union" then
        local types_str_list = {}
        for i, t in ipairs(self.data) do
            table.insert(types_str_list, t:string_repr(depth))
        end
        local types_str = table.concat(types_str_list, " | ")
        return types_str
    elseif self.type == "Intersection" then
        local types_str_list = {}
        for i, t in ipairs(self.data) do
            table.insert(types_str_list, t:string_repr(depth))
        end
        local types_str = table.concat(types_str_list, " & ")
        return types_str
    else
        error("ICE: transformRepr failed")
    end
end

function transformTypeFieldReprWithPat(s: types.TypeField, depth: number, commentWritePat: string, transformStr: (typ: string, string) -> string) 
    --[[
        let mut repr = String::new();

        for comment in &self.comments {
            write!(repr, "--{}{}", comment, comment_write_pat)
                .expect("Failed to write comment to string");
        }

        write!(
            repr,
            "{}: {}",
            self.field_name,
            self.field_type.string_repr(depth)
        )
        .unwrap();
        repr
    ]]

    local repr = ""

    for _, comment in s.comments do
        repr ..= string.format("--%s%s", comment, commentWritePat)
    end

    repr ..= string.format("%s: %s", s.field_name, transformRepr(s.field_type, depth, transformStr))

    return repr
end

function transformGenericRepr(s: types.TypeFieldTypeGeneric, transformStr: (typ: string, string) -> string) 
    --[[/// String representation of the generic type
    ///
    /// @public_api
    pub fn string_repr(&self) -> String {
        let generics_str = self
            .generics
            .iter()
            .map(|g| g.string_repr(0))
            .collect::<Vec<_>>()
            .join(", ");
        format!("{}<{}>", self.base, generics_str)
    }]]

    local generics_str_list = {}
    for i, g in ipairs(s.generics) do
        table.insert(generics_str_list, transformRepr(g, 0, transformStr))
    end

    local generics_str = table.concat(generics_str_list, ", ")
    return string.format("%s<%s>", s.base, generics_str)
end

function transformModuleRepr(s: types.TypeFieldTypeModule, transformStr: (typ: string, string) -> string): string 
    --[[
            if let Some(ref generics) = self.generics {
                if generics.is_empty() {
                    format!("{}.{}", self.module, self.base)
                } else {
                    let generics_str = generics
                        .iter()
                        .map(|g| g.string_repr(0))
                        .collect::<Vec<_>>()
                        .join(", ");
                    format!("{}.{}<{}>", self.module, self.base, generics_str)
                }
            } else {
                // If there are no generics, we can just return the module name
                format!("{}.{}", self.module, self.base)
            }
    ]]

    if s.generics and #s.generics > 0 then
        local genericsStr = table.concat(tableext.arraymap(
            s.generics, 
            function(d: types.TypeFieldType)
                return transformRepr(d, 0, transformStr) 
            end), 
            ", "
        )

        return string.format("%s.%s<%s>", s.module, s.base, genericsStr)
    else
        return string.format("%s.%s", s.module, s.base)
    end
end

function transformFunctionRepr(s: types.TypeFieldTypeFunction, transformStr: (typ: string, string) -> string): string
    --[[
        let args_str = self
            .args
            .iter()
            .map(|arg| arg.string_repr(false, false))
            .collect::<Vec<_>>()
            .join(", ");
        format!("({}) -> {}", args_str, self.ret.string_repr(1))
    ]]

    local genericsStr = table.concat(
        tableext.arraymap(s.generics, function(g: types.TypedArgument)
            return transformTypedArgumentRepr(g, true, false, transformStr)
        end), 
        ", "
    )

    local argsStr = table.concat(
        tableext.arraymap(s.args, function(arg: types.TypedArgument)
            return transformTypedArgumentRepr(arg, false, false, transformStr)
        end), 
        ", " 
    )

    local str = ""

    if #genericsStr > 0 then
        str = string.format("<%s>", genericsStr)
    end

    str ..= string.format("(%s) -> %s", argsStr, transformRepr(s.ret, 1, transformStr))

    return str
end

function transformTypedArgumentRepr(s: types.TypedArgument, generic: boolean?, punctuation: boolean?, transformStr: (typ: string, string) -> string) 
    --[[
        let mut v = if let Some(ref name) = self.name {
            if let Some(ref typ) = self.typ {
                if is_generic {
                    format!("{} = {}", name, typ.string_repr(1))
                } else {
                    format!("{}: {}", name, typ.string_repr(1))
                }
            } else {
                name.to_string()
            }
        } else if let Some(ref typ) = self.typ {
            typ.string_repr(1)
        } else {
            "".to_string()
        };

        if with_punctuation {
            if let Some(ref punctuation) = self.punctuation {
                v.push_str(punctuation)
            }
        }
    ]]
    assert(typeof(s.name) ~= "userdata", "s.name must not be userdata, is " .. tostring(s.name))

    local v: string
    if s.name ~= nil then
        if s.typ ~= nil then
            if generic then 
                v = string.format("%s = %s", s.name, transformRepr(s.typ, 1, transformStr))
            else
                v = string.format("%s: %s", s.name, transformRepr(s.typ, 1, transformStr))
            end
        else
            v = s.name
        end
    elseif s.typ ~= nil then
        v = transformRepr(s.typ, 1, transformStr)
    else 
        v = ""
    end

    if punctuation and s.punctuation then
        v ..= s.punctuation
    end

    return v
end

return {
    transformRepr = transformRepr,
    transformTypeFieldReprWithPat = transformTypeFieldReprWithPat,
}