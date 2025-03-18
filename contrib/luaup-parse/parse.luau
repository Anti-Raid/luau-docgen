--!strict
local visit = require("./luaup/lossless/visit")

local pp = require("../../documentor_core/pp")
local parser = require("./luaup/lossless/parse")
local cst = require("./luaup/lossless/cst")
local types = require("../../documentor_core/types")
local util = require("./luaup/lossless/util")

local TypeSetImpl = {}
TypeSetImpl.__index = TypeSetImpl

function TypeSetImpl.new(): types.TypeSet
    return setmetatable({
        typedefs = {},
        functions = {},
    }, TypeSetImpl) :: types.TypeSet
end

function TypeSetImpl:iter_typedefs()
    return ipairs(self.typedefs)
end

function TypeSetImpl:iter_functions()
    return ipairs(self.functions)
end

local TypeFieldTypeImpl = {}
TypeFieldTypeImpl.__index = TypeFieldTypeImpl

function TypeFieldTypeImpl.new(
    data: types.TypeFieldType_Inner
): types.TypeFieldType
    return setmetatable(data, TypeFieldTypeImpl) :: types.TypeFieldType
end

function TypeFieldTypeImpl.extract(self: types.TypeFieldType): types.TypeFieldType_Inner
    return (self :: any).inner :: types.TypeFieldType_Inner
end

local TypeFieldTypeModuleImpl = {}
TypeFieldTypeModuleImpl.__index = TypeFieldTypeModuleImpl

function TypeFieldTypeModuleImpl.new(
    --- The module name of the type
    module: string,
    --- The base type name of the module
    base: string,
    --- The generic arguments of the module (if the type is generic e.g. promise.Promise<T>)
    generics: {types.TypeFieldType}?  
): types.TypeFieldTypeModule 
    return setmetatable({
        module = module,
        base = base,
        generics = generics,
    }, TypeFieldTypeModuleImpl) :: types.TypeFieldTypeModule
end

local TypeFieldTypeGenericImpl = {}
TypeFieldTypeGenericImpl.__index = TypeFieldTypeGenericImpl

function TypeFieldTypeGenericImpl.new(
    --- The base type name of the generic
    base: string,
    --- The generic arguments of the generic (e.g. map<number, string>)
    generics: {types.TypeFieldType}
): types.TypeFieldTypeGeneric
    return setmetatable({
        base = base,
        generics = generics,
    }, TypeFieldTypeGenericImpl) :: types.TypeFieldTypeGeneric
end

local TypeFieldImpl = {}
TypeFieldImpl.__index = TypeFieldImpl

function TypeFieldImpl.new(
    --- The comments associated with the type field
    comments: {string},
    --- The name of the field
    field_name: types.TypeFieldKey,
    --- The type of the field
    field_type: types.TypeFieldType
): types.TypeField
    return setmetatable({
        comments = comments,
        field_name = field_name,
        field_type = field_type,
    }, TypeFieldImpl) :: types.TypeField
end

local TypeFieldKeyImpl = {}
TypeFieldKeyImpl.__index = TypeFieldKeyImpl

function TypeFieldKeyImpl.new(
    data: types.TypeFieldKey_Inner
): types.TypeFieldKey
    return setmetatable(data, TypeFieldKeyImpl) :: types.TypeFieldKey
end

local TypeFieldTypeFunctionImpl = {}
TypeFieldTypeFunctionImpl.__index = TypeFieldTypeFunctionImpl

function TypeFieldTypeFunctionImpl.new(
    --- The generic arguments of the function
    generics: {types.TypedArgument},
    --- The arguments of the function
    args: {types.TypedArgument},
    --- The return type of the function
    ret: types.TypeFieldType
): types.TypeFieldTypeFunction
    return setmetatable({
        generics = generics,
        args = args,
        ret = ret,
    }, TypeFieldTypeFunctionImpl) :: types.TypeFieldTypeFunction
end

-- A hack to convert a statement to a string
local function stmtToString(node: cst.Stat) 
    local cst: cst.Cst = {
        block = {
            stats = {{node = node}}
        },
        eof = {
            kind = "eof",
            trivia = {},
            text = "",
            span = {
                x = 0,
                y = 0,
                z = 0,
            }
        }
    }

    return util.tostring(cst)
end

-- A hack to convert an expression to a string
local function exprToString(node: cst.Expr) 
    -- Create a wrapper statement
    local wrapperStmt: cst.LastStat_Return = {
        kind = "return",
        return_tok = {
            kind = "return",
            text = "return",
            span = {
                x = 0,
                y = 0,
                z = 0,
            },
            trivia = {},
        },
        exprs = {
            {
                node :: cst.Expr, 
                sep = {
                    kind = ",",
                    trivia = {},
                    text = ",",
                    span = {
                        x = 0,
                        y = 0,
                        z = 0,
                    }
                } :: cst.TokenKind<",">
            } :: cst.Pair<cst.Expr, cst.TokenKind<",">>     
        },
        sep = nil
    }

    local cst: cst.Cst = {
        block = {
            stats = {},
            last_stat = {
                stat = wrapperStmt,
            }
        },
        eof = {
            kind = "eof",
            trivia = {},
            text = "",
            span = {
                x = 0,
                y = 0,
                z = 0,
            }
        }
    }

    return util.tostring(cst):gsub("return ", "")
end

local function extractcommentsfromtrivia(comments: {string}, trivia: {cst.Trivia}): {string}
    for _, t in trivia do
        if t.kind == "comment" then
            table.insert(comments, t.text:gsub("-- ", "") :: string)
        end
    end
    return comments
end

--[[
pub fn create_typed_arguments_from_generic_declaration(
    &mut self,
    generic: &GenericDeclaration,
) -> Vec<TypedArgument> {
    let mut generics = Vec::with_capacity(generic.generics().len());
    for generic_decl_param in generic.generics() {
        let default_type = generic_decl_param
            .default_type()
            .map(|t| TypeFieldType::from_luau_typeinfo(self, t));

        let name = match generic_decl_param.parameter() {
            GenericParameterInfo::Name(name) => extract_name_from_tokenref(name),
            GenericParameterInfo::Variadic { name, .. } => {
                format!("...{}", extract_name_from_tokenref(name))
            }
            _ => {
                self.warn_unsupported("Only simple function generics are supported!");
                continue;
            }
        };

        generics.push(TypedArgument {
            name: Some(name),
            typ: default_type,
            punctuation: None,
        })
    }

    generics
}
]]
local function create_typed_arguments_from_generic_declaration_with_default(generic_decl: cst.GenericDeclarationWithDefaults): {types.TypedArgument}
    local generics = {}

    for _, generic_decl_param in generic_decl.names do
        local typ: types.TypeFieldType? = nil

        if generic_decl_param.node.default then 
            typ = from_luau_typeinfo_to_typefieldtype(generic_decl_param.node.default.type)
        end

        local generic: types.TypedArgument = {
            name = generic_decl_param.node.name.text,
            typ = typ,
            punctuation = nil,
        }
        table.insert(generics, generic)
    end

    for _, generic_decl_pack in generic_decl.packs do
        local typ: types.TypeFieldType? = nil
        if generic_decl_pack.node.default then 
            typ = from_luau_typeinfo_to_typefieldtype(generic_decl_pack.node.default.pack)
        end
        local generic: types.TypedArgument = {
            name = generic_decl_pack.node.name.text,
            typ = typ,
            punctuation = nil,
        }
        table.insert(generics, generic)
    end

    return generics
end

local function create_typed_arguments_from_generic_declaration(generic_decl: cst.GenericDeclaration): {types.TypedArgument}
    local generics = {}

    for _, generic_decl_param in generic_decl.names do
        local generic: types.TypedArgument = {
            name = generic_decl_param.node.text,
            typ = nil,
            punctuation = nil,
        }
        table.insert(generics, generic)
    end

    for _, generic_decl_pack in generic_decl.packs do
        local generic: types.TypedArgument = {
            name = generic_decl_pack.node.name.text,
            typ = nil,
            punctuation = nil,
        }
        table.insert(generics, generic)
    end

    return generics
end

function from_luau_typeinfo_to_typefieldtype(typ: cst.Type | cst.TypePack): types.TypeFieldType
    if typ.kind == "nil" then
        return TypeFieldTypeImpl.new({
            type = "Basic",
            data = "nil",
        })
    elseif typ.kind == "boolean" then
        return TypeFieldTypeImpl.new({
            type = "Basic",
            data = typ.tok.text,
        })
    elseif typ.kind == "string" then
        return TypeFieldTypeImpl.new({
            type = "String",
            data = typ.tok.text,
        })
    elseif typ.kind == "reference" then
        typ = typ :: cst.Type_Reference -- Luau bug
        if typ.prefix then 
            local data = {
                module = typ.prefix.name.text,
                base = typ.name.text,
                generics = nil :: {types.TypeFieldType}?,
            }

            if typ.generics and #typ.generics.types > 0 then
                local generics = {}
                for _, generic in typ.generics.types do
                    local n = from_luau_typeinfo_to_typefieldtype(generic.node)
                    table.insert(generics, n)
                end

                data.generics = generics
            end            

            return TypeFieldTypeImpl.new({
                type = "Module",
                data = data,
            })
        elseif typ.generics and #typ.generics.types > 0 then
            -- This is a TypeFieldTypeGeneric
            local generics = {}

            for _, generic in typ.generics.types do
                local n = from_luau_typeinfo_to_typefieldtype(generic.node)
                table.insert(generics, n)
            end

            return TypeFieldTypeImpl.new({
                type = "Generic",
                data = TypeFieldTypeGenericImpl.new(
                    typ.name.text,
                    generics
                ),
            })
        else
            return TypeFieldTypeImpl.new({
                type = "Basic",
                data = typ.name.text,
            })
        end
    elseif typ.kind == "typeof" then
        typ = typ :: cst.Type_Typeof
        return TypeFieldTypeImpl.new({
            type = "TypeOf",
            data = exprToString(typ.expr),
        })
    elseif typ.kind == "array" then
        return TypeFieldTypeImpl.new({
            type = "Array",
            data = from_luau_typeinfo_to_typefieldtype(typ.type),
        })  
    elseif typ.kind == "table" then
        typ = typ :: cst.Type_Table
        local fields = {}
        for _, field in typ.fields do
            table.insert(fields, from_tabletypefield_to_typefield(field.node))
        end

        return TypeFieldTypeImpl.new({
            type = "Table",
            data = fields,
        })
    elseif typ.kind == "function" then
        typ = typ :: cst.Type_Function
        local args = {}
        for _, arg in typ.params do
            local n = from_luau_typeinfo_to_typefieldtype(arg.node.type)
            local name: string? = nil
            local punctuation: string? = nil
            if arg.node.name then
                name = arg.node.name.name.text
                punctuation = arg.node.name.colon.text
            end
            table.insert(args, {
                name = name,
                typ = n,
                punctuation = punctuation,
            })
        end

        if typ.varargs then
            local n = from_luau_typeinfo_to_typefieldtype(typ.varargs)
            table.insert(args, {
                name = "...",
                typ = n,
                punctuation = nil,
            })
        end

        local generics: {types.TypedArgument} = {}
        if typ.generics then
            generics = create_typed_arguments_from_generic_declaration(typ.generics)
        end

        return TypeFieldTypeImpl.new({
            type = "Function",
            data = TypeFieldTypeFunctionImpl.new(
                generics,
                args,
                from_luau_typeinfo_to_typefieldtype(typ.ret)
            ),
        })
    elseif typ.kind == "paren" then 
        return from_luau_typeinfo_to_typefieldtype(typ.type)
    elseif typ.kind == "optional" then
        typ = typ :: cst.Type_Optional
        return TypeFieldTypeImpl.new({
            type = "Optional",
            data = from_luau_typeinfo_to_typefieldtype(typ.type),
        })
    elseif typ.kind == "union" then
        typ = typ :: cst.Type_Union
        local types: {types.TypeFieldType} = {}
        for _, t in typ.types do
            table.insert(types, from_luau_typeinfo_to_typefieldtype(t.node))
        end

        return TypeFieldTypeImpl.new({
            type = "Union",
            data = types,
        })
    elseif typ.kind == "intersection" then
        typ = typ :: cst.Type_Intersection
        local types: {types.TypeFieldType} = {}
        for _, t in typ.types do
            table.insert(types, from_luau_typeinfo_to_typefieldtype(t.node))
        end

        return TypeFieldTypeImpl.new({
            type = "Union",
            data = types,
        })
    elseif typ.kind == "variadic" then
        typ = typ :: cst.VariadicTypePack
        return TypeFieldTypeImpl.new({
            type = "Variadic",
            data = from_luau_typeinfo_to_typefieldtype(typ.type),
        })
    elseif typ.kind == "generic" then 
        typ = typ :: cst.GenericTypePack
        return TypeFieldTypeImpl.new({
            type = "GenericPack",
            data = typ.name.text,
        })
    elseif typ.kind == "list" then -- Tuple, basically
        typ = typ :: cst.TypeList
        local types: {types.TypeFieldType} = {}
        for _, t in typ.types do
            table.insert(types, from_luau_typeinfo_to_typefieldtype(t.node))
        end

        if typ.tail then
            table.insert(types, from_luau_typeinfo_to_typefieldtype(typ.tail))
        end
        return TypeFieldTypeImpl.new({
            type = "Tuple",
            data = types,
        })
    else
        error("Unsupported feature: " .. typ.kind)
    end
end

function from_tabletypefield_to_typefield(typ: cst.TableTypeField): types.TypeField 
    local key: types.TypeFieldKey
    local itype: types.TypeFieldType
    local comments: {string} = {}

    if typ.access then
        comments = extractcommentsfromtrivia(comments, typ.access.trivia)
    end

    if typ.kind == "nameprop" then
        key = TypeFieldKeyImpl.new({
            type = "Name",
            name = typ.name.text,
        })
        comments = extractcommentsfromtrivia(comments, typ.name.trivia)
        itype = from_luau_typeinfo_to_typefieldtype(typ.type)
    elseif typ.kind == "stringprop" then
        key = TypeFieldKeyImpl.new({
            type = "Name",
            name = `{typ.bracks.open.text}{typ.key.text}{typ.bracks.close.text}`,
        })
        comments = extractcommentsfromtrivia(comments, typ.bracks.open.trivia)
        comments = extractcommentsfromtrivia(comments, typ.key.trivia)
        comments = extractcommentsfromtrivia(comments, typ.bracks.close.trivia)
        itype = from_luau_typeinfo_to_typefieldtype(typ.type)
    elseif typ.kind == "indexer" then 
        key = TypeFieldKeyImpl.new({
            type = "IndexSignature",
            start_tok = typ.bracks.open.text,
            inner = from_luau_typeinfo_to_typefieldtype(typ.key),
            end_tok = typ.bracks.close.text,
        })
        comments = extractcommentsfromtrivia(comments, typ.bracks.open.trivia)
        comments = extractcommentsfromtrivia(comments, typ.bracks.close.trivia)
        itype = from_luau_typeinfo_to_typefieldtype(typ.type)
    else
        error("Unsupported feature: " .. typ.kind)
    end

    return TypeFieldImpl.new(comments, key, itype)
end

--[[
    pub fn create_type_from_function(
        &mut self,
        comments: Vec<String>,
        name: String,
        body: &FunctionBody,
        function_type: FunctionType,
    ) -> Type {
        // Get the generics
        let generics = if let Some(generic) = body.generics() {
            self.create_typed_arguments_from_generic_declaration(generic)
        } else {
            Vec::with_capacity(0)
        };

        // Convert the args to Vec<(Option<String>, TypeFieldType)>
        let mut params = Vec::new();
        for param in body.parameters() {
            let tokenref = match param {
                Parameter::Name(name) => name,
                Parameter::Ellipsis(ellipsis) => ellipsis,
                _ => {
                    self.warn_unsupported("Only simple function parameters are supported!");
                    continue;
                }
            };

            params.push(extract_name_from_tokenref(tokenref));
        }

        let mut typs = Vec::new();

        // The type specifiers of the variables, in the order that they were assigned. (foo: number, bar, baz: boolean) returns an iterator containing: Some(TypeSpecifier(number)), None, Some(TypeSpecifier(boolean)).
        for typ_specifier in body.type_specifiers() {
            let Some(typ_specifier) = typ_specifier else {
                typs.push(None);
                continue;
            };

            typs.push(Some(TypeFieldType::from_luau_typeinfo(
                self,
                typ_specifier.type_info(),
            )));
        }

        let mut args = Vec::with_capacity(params.len());
        for (param, typ) in params.into_iter().zip(typs) {
            args.push(TypedArgument {
                name: Some(param),
                typ,
                punctuation: None,
            });
        }

        // Get the return type
        let ret = body
            .return_type()
            .map(|typ| TypeFieldType::from_luau_typeinfo(self, typ.type_info()));

        // Create the type
        Type::Function {
            inner: TypeFunction {
                name,
                type_comments: comments,
                generics,
                args,
                ret,
                function_type,
            }
            .into(),
        }
    }
]]
local function create_type_from_function(
    comments: {string},
    name: string,
    body: cst.FunctionBody,
    function_type: "Normal" | "Local"
): types.TypeFunction 
    local generics: {types.TypedArgument} = {}
    if body.generics then
        generics = create_typed_arguments_from_generic_declaration(body.generics)
    end

    local args: {types.TypedArgument} = {}
    for _, param in body.params do
        local paramname = param.node.name.text
        local typ: types.TypeFieldType? = nil
        local punctuation: string? = nil
        if param.node.type then 
            typ = from_luau_typeinfo_to_typefieldtype(param.node.type.type)
            punctuation = param.node.type.colon.text
        end

        table.insert(args, {
            name = paramname,
            typ = typ,
            punctuation = punctuation,
        })
    end

    if body.varargs then 
        local typ: types.TypeFieldType? = nil
        if body.varargs.type then 
            typ = from_luau_typeinfo_to_typefieldtype(body.varargs.type)
        end
        table.insert(args, {
            name = "...",
            typ = typ,
            punctuation = nil,
        })
    end

    local typs = {}

    for _, typ_specifier in body.type_specifiers do
        if typ_specifier == nil then
            table.insert(typs, nil)
            continue;
        end

        table.insert(typs, from_luau_typeinfo_to_typefieldtype(typ_specifier.type_info))
    end

    local args = {}
    for i, param in params do
        table.insert(args, {
            name = param.name.text,
            typ = typs[i],
            punctuation = nil,
        })
    end

    local ret: types.TypeFieldType? = nil
    if body.return_type then 
        ret = from_luau_typeinfo_to_typefieldtype(body.return_type.type_info)
    end

    return {
        name = name,
        type_comments = comments,
        generics = generics,
        args = args,
        ret = ret,
        function_type = function_type,
    }
end

local function parseCst(cst: cst.Cst): {
    unsupported_count: number,
    typeset: types.TypeSet,
}
    local ts = TypeSetImpl.new()
    local unsupported_count = 0
    local function_depth = 0

    local visitor = visit.visitor()

    function visitor.visit_stat_function(_, node: cst.Stat_Function) 
        if function_depth > 0 then
            function_depth += 1
            return;
        end

        function_depth += 1
        
        --print(node.names)
    end

    function visitor.visit_stat_function_end(_, node: cst.Stat_Function) 
        function_depth -= 1
    end

    function visitor.visit_stat_local_function(_, node: cst.Stat_LocalFunction) 
        if function_depth > 0 then
            function_depth += 1
            return;
        end

        function_depth += 1
        
        print(node.name.text)
    end

    function visitor.visit_stat_local_function_end(_, node: cst.Stat_LocalFunction) 
        function_depth -= 1
    end

    visit.visit(visitor, nil, cst)

    return {
        unsupported_count = unsupported_count,
        typeset = ts,
    }
end

local function parseContentsToTypeset(contents: string): {
    unsupported_count: number,
    typeset: types.TypeSet,
}
    local res = parser(contents)

    if not res.success then
        print("Failed to parse")
        print(res.error.message)
        print(tostring(res.error.span.x) .. ":" .. tostring(res.error.span.y) .. ":" .. tostring(res.error.span.z))
        print(string.sub(contents, res.error.span.x - 10, res.error.span.y + 10))
        error("Parse failed")
    end    

    if #res.cst.block.stats == 0 then
        error("No statements could be parsed from file")
    end

    return parseCst(res.cst)
end

return parseContentsToTypeset