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

--[[
/// Compact type information (Any type, such as string, boolean?, number | boolean, etc)
#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub enum TypeFieldType {
    /// A basic primitive type (`string`, `number`, etc)
    Basic(String),
    /// A string singleton ("hello")
    String(String),
    /// A boolean singleton (`true`, `false`)
    Boolean(bool),
    /// An array of a type
    Array(Rc<TypeFieldType>),
    /// A variadic type, similar to Array
    /// ...number
    Variadic(Rc<TypeFieldType>),
    /// A variadic type pack: ...T in Function<...T>    
    VariadicPack(String),
    /// A function type
    Function(TypeFieldTypeFunction),
    /// Contains the inner table fields
    Table(Vec<Rc<TypeField>>),

    ///  A type using generics, such as map<number, string>.
    Generic(TypeFieldTypeGeneric),

    /// T...
    GenericPack(String),

    /// A union type (e.g. `string | number`)
    Union(Vec<Rc<TypeFieldType>>),

    /// A type intersection (e.g. `string & number`)
    Intersection(Vec<Rc<TypeFieldType>>),

    /// A module
    Module(TypeFieldTypeModule),

    /// Unknown module
    ///
    /// Contains the module name, which may be an empty string
    UnknownModule(String),

    /// An optional type
    Optional(Rc<TypeFieldType>),

    /// Tuple type
    Tuple(Vec<Rc<TypeFieldType>>),

    /// A typeof statement
    ///
    /// Inner is the contents of the statement
    TypeOf(String),
}

impl TypeFieldType {
    /// Given a TypeInfo, convert it to a TypeField
    pub fn from_luau_typeinfo(tbv: &mut TypeBlockVisitor, typ_info: &TypeInfo) -> Rc<Self> {
        match typ_info {
            TypeInfo::Array { type_info, .. } => {
                TypeFieldType::Array(TypeFieldType::from_luau_typeinfo(tbv, type_info)).into()
            }
            TypeInfo::Basic(basic_type) => {
                let type_name = extract_name_from_tokenref(basic_type);
                TypeFieldType::Basic(type_name).into()
            }
            TypeInfo::String(singleton) => {
                let singleton = extract_name_from_tokenref(singleton);
                TypeFieldType::String(singleton).into()
            }
            TypeInfo::Boolean(boolean) => {
                let boolean = extract_name_from_tokenref(boolean);
                TypeFieldType::Boolean(boolean == "true").into()
            }
            TypeInfo::Table { fields, .. } => {
                let mut type_fields: Vec<Rc<TypeField>> = Vec::new();

                for pair in fields.pairs() {
                    match pair {
                        Pair::Punctuated(field, _) | Pair::End(field) => {
                            type_fields.push(TypeField::from_luau_type_field(tbv, field));
                        }
                    }
                }

                TypeFieldType::Table(type_fields).into()
            }
            TypeInfo::Callback {
                arguments,
                return_type,
                generics,
                ..
            } => {
                let mut args = Vec::new();

                for arg in arguments.iter() {
                    let typ = TypeFieldType::from_luau_typeinfo(tbv, arg.type_info());

                    let Some((name, punctuation)) = arg.name() else {
                        args.push(TypedArgument {
                            name: None,
                            typ: Some(typ),
                            punctuation: None,
                        });
                        continue;
                    };

                    let name = extract_name_from_tokenref(name);

                    args.push(TypedArgument {
                        name: Some(name),
                        typ: Some(typ),
                        punctuation: Some(punctuation.to_string()),
                    });
                }

                let generics = if let Some(generic) = generics {
                    tbv.create_typed_arguments_from_generic_declaration(generic)
                } else {
                    Vec::with_capacity(0)
                };
                TypeFieldType::Function(TypeFieldTypeFunction {
                    args,
                    ret: TypeFieldType::from_luau_typeinfo(tbv, return_type),
                    generics,
                })
                .into()
            }
            TypeInfo::Generic { base, generics, .. } => {
                let base = extract_name_from_tokenref(base);
                let mut generics_arr = Vec::new();

                for generic in generics.iter() {
                    generics_arr.push(TypeFieldType::from_luau_typeinfo(tbv, generic));
                }

                TypeFieldType::Generic(TypeFieldTypeGeneric {
                    base,
                    generics: generics_arr,
                })
                .into()
            }
            TypeInfo::GenericPack { name, .. } => {
                let name = extract_name_from_tokenref(name);
                TypeFieldType::GenericPack(name).into()
            }
            TypeInfo::Union(types) => {
                let mut union_types = Vec::new();

                for typ in types.types() {
                    union_types.push(TypeFieldType::from_luau_typeinfo(tbv, typ));
                }

                TypeFieldType::Union(union_types).into()
            }
            TypeInfo::Intersection(types) => {
                let mut intersection_types = Vec::new();

                for typ in types.types() {
                    intersection_types.push(TypeFieldType::from_luau_typeinfo(tbv, typ));
                }

                TypeFieldType::Intersection(intersection_types).into()
            }
            TypeInfo::Module {
                module, type_info, ..
            } => {
                let module = extract_name_from_tokenref(module);

                match &**type_info {
                    IndexedTypeInfo::Basic(base) => {
                        let base = extract_name_from_tokenref(base);
                        TypeFieldType::Module(TypeFieldTypeModule {
                            module,
                            base,
                            generics: None,
                        })
                        .into()
                    }
                    IndexedTypeInfo::Generic { base, generics, .. } => {
                        let base = extract_name_from_tokenref(base);
                        let mut generics_arr = Vec::new();

                        for generic in generics.iter() {
                            generics_arr.push(TypeFieldType::from_luau_typeinfo(tbv, generic));
                        }

                        TypeFieldType::Module(TypeFieldTypeModule {
                            module,
                            base,
                            generics: Some(generics_arr),
                        })
                        .into()
                    }
                    _ => (TypeFieldType::UnknownModule(module)).into(), // Can;t do anything with this
                }
            }
            TypeInfo::Optional { base, .. } => {
                TypeFieldType::Optional(TypeFieldType::from_luau_typeinfo(tbv, base)).into()
            }
            TypeInfo::Tuple { types, .. } => {
                let mut tuple_types = Vec::new();

                for typ in types {
                    tuple_types.push(TypeFieldType::from_luau_typeinfo(tbv, typ));
                }

                TypeFieldType::Tuple(tuple_types).into()
            }
            TypeInfo::Variadic { type_info, .. } => {
                TypeFieldType::Variadic(TypeFieldType::from_luau_typeinfo(tbv, type_info)).into()
            }
            TypeInfo::VariadicPack { name, .. } => {
                let name = extract_name_from_tokenref(name);
                TypeFieldType::VariadicPack(name).into()
            }
            TypeInfo::Typeof { inner, .. } => TypeFieldType::TypeOf(inner.to_string()).into(),
            _ => {
                panic!("Unsupported feature: {:?}", typ_info);
            }
        }
    }
}
]]
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
    end
end

function from_tabletypefield_to_typefield(typ: cst.TableTypeField): types.TypeField 
    --[[
        let key = match typ_field.key() {
            LuauTypeFieldKey::Name(name) => TypeFieldKey::Name {
                name: extract_name_from_tokenref(name),
            },
            LuauTypeFieldKey::IndexSignature { brackets, inner } => {
                let (start_bracket, end_bracket) = brackets.tokens();

                TypeFieldKey::IndexSignature {
                    start_tok: extract_name_from_tokenref(start_bracket),
                    inner: TypeFieldType::from_luau_typeinfo(tbv, inner),
                    end_tok: extract_name_from_tokenref(end_bracket),
                }
            }
            _ => panic!("Unsupported feature: {:?}", typ_field.key()),
        }
        .into();
        let value = typ_field.value();

        let mut comments = Vec::new();

        // Check access modifier for comments
        if let Some(access_modifier) = typ_field.access() {
            comments.extend(get_comments_from_token_ref(access_modifier));
        }

        // Check key for comments
        match typ_field.key() {
            LuauTypeFieldKey::Name(name) => {
                comments.extend(get_comments_from_token_ref(name));
            }
            LuauTypeFieldKey::IndexSignature { brackets, inner: _ } => {
                let (start_bracket, end_bracket) = brackets.tokens();
                comments.extend(get_comments_from_token_ref(start_bracket));
                comments.extend(get_comments_from_token_ref(end_bracket));
            }
            _ => {}
        }

        let type_info = TypeFieldType::from_luau_typeinfo(tbv, value);

        Self {
            comments,
            field_name: key,
            field_type: type_info,
        }
    ]]

    local key: types.TypeFieldKey
    local itype: types.TypeFieldType
    if typ.kind == "nameprop" then
        key = TypeFieldKeyImpl.new({
            type = "Name",
            name = typ.name.text,
        })
        itype = from_luau_typeinfo_to_typefieldtype(typ.type)
    elseif typ.kind == "stringprop" then
        key = TypeFieldKeyImpl.new({
            type = "Name",
            name = `{typ.bracks.open.text}{typ.key.text}{typ.bracks.close.text}`,
        })
        itype = from_luau_typeinfo_to_typefieldtype(typ.type)
    elseif typ.kind == "indexer" then 
        key = TypeFieldKeyImpl.new({
            type = "IndexSignature",
            start_tok = typ.bracks.open.text,
            inner = from_luau_typeinfo_to_typefieldtype(typ.key),
            end_tok = typ.bracks.close.text,
        })
        itype = from_luau_typeinfo_to_typefieldtype(typ.type)
    else
        error("Unsupported feature: " .. typ.kind)
    end

    -- TODO: comments
    local comments: {string} = {}

    return TypeFieldImpl.new(comments, key, itype)
end

local function parseCst(cst: cst.Cst): {
    unsupported_count: number,
    typeset: types.TypeSet,
}
    local ts = TypeSetImpl.new()
    local unsupported_count = 0
    local function_depth = 0

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
    local function create_typed_arguments_from_generic_declaration(generic_decl: cst.GenericDeclaration): {types.TypedArgument}
        local generics = {}

        for _, generic_decl_param in generic_decl.packs do
            local generic: types.TypedArgument = {
                name = generic_decl_param.node.name.text,
                typ = nil,
                punctuation = nil,
            }
            table.insert(generics, generic)
        end

        return generics
    end

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