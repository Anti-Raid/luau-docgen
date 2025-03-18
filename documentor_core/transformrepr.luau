--!strict

--- Pure luau version of typefieldtypes transformRepr

local tableext = require("./table")
local types = require("./types")

--- Returns the string representation of a type field type
--- @public_api
local function transformTypeFieldTypeRepr(s: types.TypeFieldType, optdepth: number?, opttransformStr: ((typ: string, string) -> string)?)
    local depth: number = optdepth or 0
    local transformStr = opttransformStr or function(_: string, s: string) return s end
    local self = s:extract()
    if self.type == "Basic" then
        return transformStr("Basic", self.data)
    elseif self.type == "String" then
        return transformStr("String", self.data)
    elseif self.type == "Boolean" then
        return transformStr("Boolean", tostring(self.data))
    elseif self.type == "Array" then
        return string.format("{%s}", transformTypeFieldTypeRepr(self.data, depth, transformStr))
    elseif self.type == "Variadic" then
        return string.format("...%s", transformTypeFieldTypeRepr(self.data, depth, transformStr))
    elseif self.type == "Generic" then
        return transformGenericRepr(self.data, depth, transformStr)
    elseif self.type == "GenericPack" then
        return self.data
    elseif self.type == "Module" then
        return transformTypeFieldTypeModuleRepr(self.data, transformStr)
    elseif self.type == "UnknownModule" then
        return self.data
    elseif self.type == "TypeOf" then
        return self.data
    elseif self.type == "Optional" then
        return string.format("%s?", transformTypeFieldTypeRepr(self.data, depth, transformStr))
    elseif self.type == "Function" then
        return transformTypeFieldTypeFunctionRepr(self.data, transformStr)
    elseif self.type == "Table" then
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
            table.insert(types_str_list, transformTypeFieldTypeRepr(t, depth, transformStr))
        end
        local types_str = table.concat(types_str_list, ", ")
        return string.format("(%s)", types_str)
    elseif self.type == "VariadicPack" then
        return string.format("...%s", self.data)
    elseif self.type == "Union" then
        local types_str_list = {}
        for i, t in ipairs(self.data) do
            table.insert(types_str_list, transformTypeFieldTypeRepr(t, depth, transformStr))
        end
        local types_str = table.concat(types_str_list, " | ")
        return types_str
    elseif self.type == "Intersection" then
        local types_str_list = {}
        for i, t in ipairs(self.data) do
            table.insert(types_str_list, transformTypeFieldTypeRepr(t, depth, transformStr))
        end
        local types_str = table.concat(types_str_list, " & ")
        return types_str
    else
        error("ICE: transformRepr failed")
    end
end

function transformTypeFieldReprWithPat(s: types.TypeField, optdepth: number?, commentWritePat: string, opttransformStr: ((typ: string, string) -> string)?) 
    local depth = optdepth or 0
    local transformStr = opttransformStr or function(_: string, c: string) return c end

    local repr = ""

    for _, comment in s.comments do
        local ncomment = transformStr("Comment", comment)
        if ncomment ~= "" then
            repr ..= string.format("--%s%s", comment, commentWritePat)
        end
    end

    repr ..= string.format("%s: %s", transformTypeFieldKey(s.field_name, transformStr), transformTypeFieldTypeRepr(s.field_type, depth, transformStr))

    return repr
end

function transformTypeFieldKey(s: types.TypeFieldKey, opttransformStr: ((typ: string, string) -> string)?)
    local transformStr = opttransformStr or function(_: string, c: string) return c end
    local extracted = s:extract()
    if extracted.type == "Name" then
        return extracted.name
    elseif extracted.type == "IndexSignature" then
        return string.format("%s%s%s", extracted.start_tok, transformTypeFieldTypeRepr(extracted.inner, 0, transformStr), extracted.end_tok)
    else
        error("ICE: transformRepr failed")
    end
end

function transformGenericRepr(s: types.TypeFieldTypeGeneric, optdepth: number?, transformStr: (typ: string, string) -> string) 
    local depth = optdepth or 0
    local generics_str_list = {}
    for i, g in ipairs(s.generics) do
        table.insert(generics_str_list, transformTypeFieldTypeRepr(g, depth, transformStr))
    end

    local generics_str = table.concat(generics_str_list, ", ")
    return string.format("%s<%s>", s.base, generics_str)
end

function transformTypeFieldTypeModuleRepr(s: types.TypeFieldTypeModule, transformStr: (typ: string, string) -> string): string 
    if s.generics and #s.generics > 0 then
        local genericsStr = table.concat(tableext.arraymap(
            s.generics, 
            function(d: types.TypeFieldType)
                return transformTypeFieldTypeRepr(d, 0, transformStr) 
            end), 
            ", "
        )

        return string.format("%s.%s<%s>", s.module, s.base, genericsStr)
    else
        return string.format("%s.%s", s.module, s.base)
    end
end

function transformTypeFieldTypeFunctionRepr(s: types.TypeFieldTypeFunction, opttransformStr: ((typ: string, string) -> string)?): string
    local transformStr = opttransformStr or function(_, c: string) return c end
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

    str ..= string.format("(%s) -> %s", argsStr, transformTypeFieldTypeRepr(s.ret, 1, transformStr))

    return str
end

function transformTypedArgumentRepr(s: types.TypedArgument, generic: boolean?, punctuation: boolean?, transformStr: ((typ: string, string) -> string)?): string 
    transformStr = transformStr or function(_: string, c: string) return c end
    assert(typeof(s.name) ~= "userdata", "s.name must not be userdata, is " .. tostring(s.name))

    local v: string
    if s.name ~= nil then
        if s.typ ~= nil then
            if generic then 
                v = string.format("%s = %s", s.name, transformTypeFieldTypeRepr(s.typ, 1, transformStr))
            else
                v = string.format("%s: %s", s.name, transformTypeFieldTypeRepr(s.typ, 1, transformStr))
            end
        else
            v = s.name
        end
    elseif s.typ ~= nil then
        v = transformTypeFieldTypeRepr(s.typ, 1, transformStr)
    else 
        v = ""
    end

    if punctuation and s.punctuation then
        v ..= s.punctuation
    end

    return v
end

-- Transform typedef
function transformTypeDefRepr(s: types.TypeDef, fields_join_pat: string, generics_join_pat: string, opttransformStr: ((typ: string, string) -> string)?) 
    local transformStr = opttransformStr or function(_, c: string) return c end
    local repr = ""

    -- Write each type comment with a preceding "--"
    for _, comment in s.type_comments do
        local ncomment = transformStr("Comment", comment)
        if ncomment ~= "" then
            repr ..= string.format("--%s\n", comment)
        end
    end

    repr ..= string.format("type %s", s.name)  -- Equivalent to write!(repr, "type {}", self.name)

    -- Add generics
    if #s.generics > 0 then
        repr ..= "<"
        
        local generic_params = {}
        for i, arg in s.generics do
            table.insert(generic_params, transformTypedArgumentRepr(arg, true, false, transformStr))
        end
        local joined_generic_params = table.concat(generic_params, generics_join_pat)
        
        repr ..= joined_generic_params .. ">"
    end

    repr ..= " = "

    -- Match on self.type_def_type
    local extracted = s.type_def_type:extract()
    if extracted.type == "Table" then
        local fields = extracted.data
        if #fields == 0 then
            repr ..= "{}"
        else
            local fields_list = {}
            for _, f in fields do
                table.insert(fields_list, transformTypeFieldReprWithPat(f, 1, "\n\t", transformStr))
            end
            local fields_str = table.concat(fields_list, fields_join_pat)
            repr ..= string.format("{\n\t%s\n}", fields_str)
        end
    elseif extracted.type == "TypeOfSetMetatable" then
        local type_info = extracted.data
        local fields_list = {}
        for _, f in type_info.fields do
            table.insert(fields_list, transformTypeFieldReprWithPat(f, 1, "\n\t", transformStr))
        end
        local fields_str = table.concat(fields_list, fields_join_pat)
        fields_str = fields_str .. ",\n\n\t-- Metatable\n\t"
        
        local metatable_fields_list = {}
        for _, f in type_info.metatable_fields do
            table.insert(metatable_fields_list, transformTypeFieldReprWithPat(f, 1, "\n\t", transformStr))
        end
        local metatable_fields_str = table.concat(metatable_fields_list, ",\n\t")
        fields_str = fields_str .. metatable_fields_str
        
        repr ..= string.format("{\n\t%s\n}", fields_str)
    elseif extracted.type == "Uncategorized" then
        local type_info = extracted.data
        repr ..= transformTypeFieldTypeRepr(type_info, 1, transformStr)
    end

    return repr
end

function transformTypeFunction(s: types.TypeFunction, args_join_pat: string, generics_join_pat: string, opttransformStr: ((typ: string, string) -> string)?): string
    --[[
        let mut repr = String::new();
        for comment in self.type_comments.iter() {
            writeln!(repr, "--{}", comment).expect("Failed to write comment to string");
        }

        write!(repr, "function {}", self.name).expect("Failed to write function to string");

        // Add generics
        if !self.generics.is_empty() {
            write!(repr, "<").expect("Failed to write generics to string");

            let generic_params = self
                .generics
                .iter()
                .map(|arg| arg.string_repr(false, true))
                .collect::<Vec<_>>()
                .join(generics_join_pat);

            write!(repr, "{}", generic_params).expect("Failed to write generics to string");
            repr.push('>');
        }

        let func_args = self
            .args
            .iter()
            .map(|arg| arg.string_repr(false, false))
            .collect::<Vec<_>>()
            .join(args_join_pat);

        write!(repr, "({})", func_args).expect("Failed to write arguments to string");

        if let Some(ref ret) = self.ret {
            write!(repr, " -> {}", ret.string_repr(1))
                .expect("Failed to write return type to string");
        }
        repr.push_str(" end");
        repr
    ]]

    local transformStr = (opttransformStr or function(_: string, c: string) return c end) :: (typ: string, string) -> string
    local repr = ""

    -- Write each type comment with a preceding "--"
    for _, comment in s.type_comments do
        local ncomment = transformStr("Comment", comment)
        if ncomment ~= "" then
            repr ..= string.format("--%s\n", comment)
        end
    end

    repr ..= string.format("function %s", s.name)  -- Equivalent to write!(repr, "function {}", self.name)

    -- Add generics
    if #s.generics > 0 then
        repr ..= "<"
        
        local generic_params = {}
        for i, arg in s.generics do
            table.insert(generic_params, transformTypedArgumentRepr(arg, true, false, transformStr))
        end
        local joined_generic_params = table.concat(generic_params, generics_join_pat)
        
        repr ..= joined_generic_params .. ">"
    end

    local func_args = {}
    for _, f in s.args do
        table.insert(func_args, transformTypedArgumentRepr(f, false, false, transformStr))
    end
    local fields_str = table.concat(func_args, args_join_pat)
    repr ..= string.format("(%s)", fields_str)

    if s.ret then 
        repr ..= string.format(" -> %s", transformTypeFieldTypeRepr(s.ret, 1, transformStr))
    end

    repr ..= " end"

    return repr
end

return {
    transformTypeFieldTypeRepr = transformTypeFieldTypeRepr,
    transformTypeFieldReprWithPat = transformTypeFieldReprWithPat,
    transformTypeFieldTypeFunctionRepr = transformTypeFieldTypeFunctionRepr,
    transformTypeFieldTypeModuleRepr = transformTypeFieldTypeModuleRepr,
    transformTypedArgumentRepr = transformTypedArgumentRepr,
    transformGenericRepr = transformGenericRepr,
    transformTypeDefRepr = transformTypeDefRepr,
    transformTypeFunction = transformTypeFunction,
    transformTypeFieldKey = transformTypeFieldKey
}