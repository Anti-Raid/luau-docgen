--!strict

local types = require("../../documentor_core/types")
local cst = require("./luaup/lossless/cst")
local stringify = require("./stringify")

local function extractcommentsfromtrivia(comments: {string}, trivia: {cst.Trivia}): {string}
    for _, t in trivia do
        if t.kind == "comment" then
            -- A comment may have either 2 or 3 minuses, remove them here
            local text = t.text

            if text:sub(1, 2) == "--" then
                text = text:sub(3)
            elseif text:sub(1, 3) == "---" then
                text = text:sub(4)
            end

            table.insert(comments, text)
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
        return {
            type = "Basic",
            data = "nil",
        }
    elseif typ.kind == "boolean" then
        return {
            type = "Basic",
            data = typ.tok.text,
        }
    elseif typ.kind == "string" then
        return {
            type = "String",
            data = typ.tok.text,
        }
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

            return {
                type = "Module",
                data = data,
            }
        elseif typ.generics and #typ.generics.types > 0 then
            -- This is a TypeFieldTypeGeneric
            local generics: {types.TypeFieldType} = {}

            for _, generic in typ.generics.types do
                local n = from_luau_typeinfo_to_typefieldtype(generic.node)
                table.insert(generics, n)
            end

            return {
                type = "Generic",
                data = {
                    base = typ.name.text,
                    generics = generics
                } :: types.TypeFieldTypeGeneric,
            }
        else
            return {
                type = "Basic",
                data = typ.name.text,
            }
        end
    elseif typ.kind == "typeof" then
        typ = typ :: cst.Type_Typeof

        -- Create typeof specializations if we can
        if typ.expr.kind == "var" then 
            local var = typ.expr.var
            if var.root.kind == "name" then 
                local name = var.root.tok.text
                -- Case: typeof setmetatable
                if name == "setmetatable" then 
                    if #var.suffixes == 1 and var.suffixes[1].kind == "call" and not var.suffixes[1].method then 
                        local suffixes: cst.VarSuffix_Call = var.suffixes[1] :: cst.VarSuffix_Call
                        if suffixes.arg.kind == "pack" then -- 2 args case 
                            local funcargs = suffixes.arg
                            if #funcargs.exprs == 2 and funcargs.exprs[1].node.kind == "assertion" and funcargs.exprs[2].node.kind == "assertion" then 
                                local node1 = funcargs.exprs[1].node :: any
                                local node2 = funcargs.exprs[2].node :: any
                                local fields = from_luau_typeinfo_to_typefieldtype(node1.type :: any)
                                local metatablefields = from_luau_typeinfo_to_typefieldtype(node2.type :: any)
                                if fields.type == "Table" and metatablefields.type == "Table" then 
                                    return {
                                        type = "TypeOfSetMetatable",
                                        data = {
                                            fields = fields.data,
                                            metatable_fields = metatablefields.data,
                                        } :: types.TypeFieldTypeTypeofSetMetatable,
                                    }
                                end
                            end
                        end
                    end
                end
            end
        end

        return {
            type = "TypeOf",
            data = stringify.exprToString(typ.expr),
        } :: types.TypeFieldType
    elseif typ.kind == "array" then
        -- Code is too complex to typecheck
        local typefieldtype: any = from_luau_typeinfo_to_typefieldtype(typ.type :: any)
        return {
            type = "Array",
            data = typefieldtype :: types.TypeFieldType,
        }
    elseif typ.kind == "table" then
        typ = typ :: cst.Type_Table
        local fields = {}
        for _, field in typ.fields do
            table.insert(fields, from_tabletypefield_to_typefield(field.node))
        end

        return {
            type = "Table",
            data = fields,
        }
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

        return {
            type = "Function",
            data = {
                generics = generics,
                args = args,
                ret = from_luau_typeinfo_to_typefieldtype(typ.ret)
            } :: types.TypeFieldTypeFunction,
        }
    elseif typ.kind == "paren" then 
        local innerTyp = from_luau_typeinfo_to_typefieldtype(typ.type)
        return {
            type = "Tuple",
            data = {innerTyp},
        } :: types.TypeFieldType
    elseif typ.kind == "optional" then
        typ = typ :: cst.Type_Optional
        return {
            type = "Optional",
            data = from_luau_typeinfo_to_typefieldtype(typ.type),
        }
    elseif typ.kind == "union" then
        typ = typ :: cst.Type_Union
        local types: {types.TypeFieldType} = {}
        for _, t in typ.types do
            table.insert(types, from_luau_typeinfo_to_typefieldtype(t.node))
        end

        return {
            type = "Union",
            data = types,
        }
    elseif typ.kind == "intersection" then
        typ = typ :: cst.Type_Intersection
        local types: {types.TypeFieldType} = {}
        for _, t in typ.types do
            table.insert(types, from_luau_typeinfo_to_typefieldtype(t.node))
        end

        return {
            type = "Intersection",
            data = types,
        }
    elseif typ.kind == "variadic" then
        typ = typ :: cst.VariadicTypePack
        return {
            type = "Variadic",
            data = from_luau_typeinfo_to_typefieldtype(typ.type),
        }
    elseif typ.kind == "generic" then 
        typ = typ :: cst.GenericTypePack
        return {
            type = "GenericPack",
            data = typ.name.text,
        }
    elseif typ.kind == "list" then -- Tuple, basically
        typ = typ :: cst.TypeList
        local types: {types.TypeFieldType} = {}
        for _, t in typ.types do
            table.insert(types, from_luau_typeinfo_to_typefieldtype(t.node))
        end

        if typ.tail then
            table.insert(types, from_luau_typeinfo_to_typefieldtype(typ.tail))
        end
        return {
            type = "Tuple",
            data = types,
        }
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
        key = {
            type = "Name",
            name = typ.name.text,
        }
        comments = extractcommentsfromtrivia(comments, typ.name.trivia)
        itype = from_luau_typeinfo_to_typefieldtype(typ.type)
    elseif typ.kind == "stringprop" then
        key = {
            type = "Name",
            name = `{typ.bracks.open.text}{typ.key.text}{typ.bracks.close.text}`,
        }
        comments = extractcommentsfromtrivia(comments, typ.bracks.open.trivia)
        comments = extractcommentsfromtrivia(comments, typ.key.trivia)
        comments = extractcommentsfromtrivia(comments, typ.bracks.close.trivia)
        itype = from_luau_typeinfo_to_typefieldtype(typ.type)
    elseif typ.kind == "indexer" then 
        key = {
            type = "IndexSignature",
            start_tok = typ.bracks.open.kind,
            inner = from_luau_typeinfo_to_typefieldtype(typ.key),
            end_tok = typ.bracks.close.kind,
        } :: types.TypeFieldKey
        comments = extractcommentsfromtrivia(comments, typ.bracks.open.trivia)
        comments = extractcommentsfromtrivia(comments, typ.bracks.close.trivia)
        itype = from_luau_typeinfo_to_typefieldtype(typ.type)
    else
        error("Unsupported feature: " .. typ.kind)
    end

    return {comments = comments, field_name = key, field_type = itype} :: types.TypeField
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
            typ = from_luau_typeinfo_to_typefieldtype(body.varargs.type.type)
        end
        table.insert(args, {
            name = "...",
            typ = typ,
            punctuation = nil,
        })
    end

    local ret: types.TypeFieldType? = nil
    if body.ret then 
        ret = from_luau_typeinfo_to_typefieldtype(body.ret.type)
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

--[[
    pub fn create_type_from_type_decl(
        &mut self,
        comments: Vec<String>,
        node: &TypeDeclaration,
    ) -> Option<Type> {
        // Get node type name
        let name = extract_name_from_tokenref(node.type_name());

        // Get generics
        let generics = if let Some(generic) = node.generics() {
            self.create_typed_arguments_from_generic_declaration(generic)
        } else {
            Vec::with_capacity(0)
        };

        // For now, we only want the actual type declarations (not aliases etc)
        //println!("{:?}", node.type_declaration().type_definition());
        match node.type_definition() {
            TypeInfo::Table {
                fields: tfields, ..
            } => {
                //println!("Table: {:?}", tfields);

                let mut fields = Vec::new();

                // Add in all the fields
                for pair in tfields.pairs() {
                    match pair {
                        Pair::Punctuated(field, _) | Pair::End(field) => {
                            let field = TypeField::from_luau_type_field(self, field);
                            fields.push(field);
                        }
                    }
                }

                return Some(Type::TypeDef {
                    inner: TypeDef {
                        name,
                        generics,
                        type_comments: comments,
                        type_def_type: TypeDefType::Table { fields },
                    }
                    .into(),
                });
            }
            TypeInfo::Typeof { inner, .. } => {
                #[allow(clippy::single_match)]
                // Handle setmetatable
                match &**inner {
                    Expression::FunctionCall(fc) => {
                        //println!("{:?}", fc.prefix());

                        let Prefix::Name(s) = fc.prefix() else {
                            self.warn_unsupported(
                                "Only simple typeof setmetatable cases are supported!",
                            );
                            return None;
                        };

                        if extract_name_from_tokenref(s) == "setmetatable" {
                            // Handle typeof setmetatable case
                            let mut typ = None;
                            for suffix in fc.suffixes() {
                                //println!("Suffix: {}", suffix);

                                match suffix {
                                    Suffix::Call(call) => {
                                        let fargs = match call {
                                            Call::AnonymousCall(fargs) => fargs,
                                            Call::MethodCall(mc) => mc.args(),
                                            _ => {
                                                self.warn_unsupported(
                                                            "Only simple typeof setmetatable cases [Call unsupported] are supported!",
                                                        );
                                                continue;
                                            }
                                        };

                                        let mut type_assertions = Vec::new();
                                        match fargs {
                                            FunctionArgs::Parentheses { arguments, .. } => {
                                                for arg in arguments {
                                                    if let Expression::TypeAssertion {
                                                        type_assertion,
                                                        ..
                                                    } = arg
                                                    {
                                                        type_assertions.push(type_assertion);
                                                    }
                                                }
                                            }
                                            FunctionArgs::String(_) => {
                                                self.warn_unsupported(
                                                            "Only simple typeof setmetatable cases [String unsupported] are supported!",
                                                        );
                                                continue;
                                            }
                                            FunctionArgs::TableConstructor(_) => {
                                                self.warn_unsupported(
                                                            "Only simple typeof setmetatable cases [TableConstructor unsupported] are supported!",
                                                        );
                                            }
                                            _ => {
                                                self.warn_unsupported(
                                                            "Only simple typeof setmetatable cases [FunctionArgs unsupported] are supported!",
                                                        );
                                                continue;
                                            }
                                        };

                                        //println!("Call: {:?}", fargs);
                                        //println!("Type Assertions: {:?}", type_assertions);
                                        let mut typ_field = (None, None);
                                        for type_assertion in type_assertions {
                                            let type_info = TypeFieldType::from_luau_typeinfo(
                                                self,
                                                type_assertion.cast_to(),
                                            );

                                            let type_fields = match *type_info {
                                                TypeFieldType::Table(ref fields) => fields.to_vec(),
                                                _ => {
                                                    self.warn_unsupported(
                                                                "Only simple typeof setmetatable cases [non-table TypeFieldType unsupported] are supported!",
                                                            );
                                                    continue;
                                                }
                                            };

                                            if typ_field.0.is_none() {
                                                typ_field.0 = Some(type_fields); // fields
                                            } else if typ_field.1.is_none() {
                                                typ_field.1 = Some(type_fields); // metatable
                                            } else {
                                                break; // Shouldn't be more than 2 type assertions
                                            }
                                        }

                                        if let (Some(fields), Some(metatable)) = typ_field {
                                            typ = Some(TypeDefTypeTypeofSetMetatable {
                                                fields,
                                                metatable_fields: metatable,
                                            });
                                        }
                                    }
                                    Suffix::Index(_) => {
                                        self.warn_unsupported("Only simple typeof setmetatable cases [Suffix::Index unsupported] are supported!");
                                        continue;
                                    }
                                    _ => {
                                        self.warn_unsupported("Only simple typeof setmetatable cases [Suffix unsupported] are supported!");
                                        continue;
                                    }
                                }
                            }

                            if let Some(typ) = typ {
                                return Some(Type::TypeDef {
                                    inner: TypeDef {
                                        name,
                                        generics,
                                        type_comments: comments,
                                        type_def_type: TypeDefType::TypeOfSetMetatable {
                                            type_info: typ,
                                        },
                                    }
                                    .into(),
                                });
                            }
                        }
                    }
                    _ => {}
                }
            }
            _ => {}
        };

        // Go default on type definition if not specially supported
        Some(Type::TypeDef {
            inner: TypeDef {
                name,
                generics,
                type_comments: comments,
                type_def_type: TypeDefType::Uncategorized {
                    type_info: TypeFieldType::from_luau_typeinfo(self, node.type_definition()),
                },
            }
            .into(),
        })
    }
]]
local function create_type_from_type_declaration(stattype: cst.Stat_Type): types.TypeDef
    local comments: {string} = {}

    if stattype.export_tok then
        comments = extractcommentsfromtrivia(comments, stattype.export_tok.trivia)
    else
        comments = extractcommentsfromtrivia(comments, stattype.type_tok.trivia)
    end

    local name = stattype.name.text

    local generics: {types.TypedArgument} = {}

    if stattype.generics then
        generics = create_typed_arguments_from_generic_declaration_with_default(stattype.generics)
    end

    local typ = stattype.type
    local typefieldtype = from_luau_typeinfo_to_typefieldtype(typ)

    return {
        name = name,
        generics = generics,
        type_comments = comments,
        typ = typefieldtype
    } :: types.TypeDef
end

return {
    stmtToString = stringify.stmtToString,
    exprToString = stringify.exprToString,
    extractcommentsfromtrivia = extractcommentsfromtrivia,

    create_typed_arguments_from_generic_declaration_with_default = create_typed_arguments_from_generic_declaration_with_default,
    from_luau_typeinfo_to_typefieldtype = from_luau_typeinfo_to_typefieldtype,
    from_tabletypefield_to_typefield = from_tabletypefield_to_typefield,
    create_type_from_function = create_type_from_function,
    create_type_from_type_declaration = create_type_from_type_declaration
}