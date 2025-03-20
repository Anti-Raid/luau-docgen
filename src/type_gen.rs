//#![feature(non_exhaustive_omitted_patterns_lint)]
//#![deny(non_exhaustive_omitted_patterns)]

use full_moon::{
    ast::{
        Call, Expression, FunctionArgs, FunctionBody, LocalFunction, Parameter, Prefix, Suffix,
        luau::{
            ExportedTypeDeclaration, GenericDeclaration, GenericParameterInfo, IndexedTypeInfo,
            TypeDeclaration, TypeField as LuauTypeField, TypeFieldKey as LuauTypeFieldKey,
            TypeInfo,
        },
        punctuated::Pair,
    },
    tokenizer::{TokenReference, TokenType},
    visitors::Visitor,
};
use std::rc::Rc;

pub fn extract_name_from_tokenref(token_ref: &TokenReference) -> String {
    // SAFETY: We can discard all the trivia and just get the name
    token_ref.token().to_string()
}

pub fn get_comments_from_token_ref(token_ref: &TokenReference) -> Vec<String> {
    let mut comments = Vec::new();

    for token in token_ref
        .leading_trivia()
        .chain(token_ref.trailing_trivia())
    {
        //#[allow(non_exhaustive_omitted_patterns)]
        match token.token_type() {
            TokenType::MultiLineComment { comment, .. } => {
                comments.push(comment.to_string());
            }
            TokenType::SingleLineComment { comment } => {
                comments.push(comment.to_string());
            }
            _ => {}
        }
    }

    comments
}

/// A typed argument with an optional name and typ
#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct TypedArgument {
    pub name: Option<String>,
    pub typ: Option<Rc<TypeFieldType>>,
    pub punctuation: Option<String>, // Only for completeness
}

/// Inner data of a Generic TypeFieldType
///
/// A type using generics, such as map<number, string>.
#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct TypeFieldTypeGeneric {
    pub base: String,
    pub generics: Vec<Rc<TypeFieldType>>,
}

/// A type coming from a module, such as module.Foo
#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct TypeFieldTypeModule {
    pub module: String,
    pub base: String,
    pub generics: Option<Vec<Rc<TypeFieldType>>>,
}

/// Inner data of a Function TypeFieldType
#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct TypeFieldTypeFunction {
    /// The generics of the function
    pub generics: Vec<TypedArgument>,
    /// The arguments of the function
    pub args: Vec<TypedArgument>,
    /// The return type of the function
    pub ret: Rc<TypeFieldType>,
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct TypeFieldTypeTypeofSetMetatable {
    /// The fields of the type
    pub fields: Vec<Rc<TypeField>>,
    /// The fields of the types metatable
    pub metatable_fields: Vec<Rc<TypeField>>,
}

/// Compact type information (Any type, such as string, boolean?, number | boolean, etc)
#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
#[serde(tag = "type", content = "data")]
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

    /// A typeof setmetatable statement
    TypeOfSetMetatable(TypeFieldTypeTypeofSetMetatable),
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
            TypeInfo::Typeof { inner, .. } => {
                // Handle setmetatable
                #[allow(clippy::single_match)]
                match &**inner {
                    Expression::FunctionCall(fc) => {
                        //println!("{:?}", fc.prefix());

                        let Prefix::Name(s) = fc.prefix() else {
                            // Fallback to normal typeof
                            return TypeFieldType::TypeOf(inner.to_string()).into();
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
                                            _ => {
                                                tbv.warn_unsupported(
                                                    "Only simple typeof setmetatable cases [FunctionArgs::Parentheses] are supported!",
                                                );
                                                continue;
                                            }
                                        };

                                        let mut typ_field = (None, None);
                                        for type_assertion in type_assertions {
                                            let type_info = TypeFieldType::from_luau_typeinfo(
                                                tbv,
                                                type_assertion.cast_to(),
                                            );

                                            let type_fields = match *type_info {
                                                TypeFieldType::Table(ref fields) => fields.to_vec(),
                                                _ => {
                                                    tbv.warn_unsupported(
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
                                            typ = Some(TypeFieldTypeTypeofSetMetatable {
                                                fields,
                                                metatable_fields: metatable,
                                            });
                                        }
                                    }
                                    Suffix::Index(_) => {
                                        tbv.warn_unsupported("Only simple typeof setmetatable cases [Suffix::Index unsupported] are supported!");
                                        continue;
                                    }
                                    _ => {
                                        tbv.warn_unsupported("Only simple typeof setmetatable cases [Suffix unsupported] are supported!");
                                        continue;
                                    }
                                }
                            }

                            if let Some(typ) = typ {
                                return TypeFieldType::TypeOfSetMetatable(typ).into();
                            }
                        }
                    }
                    _ => {}
                }

                TypeFieldType::TypeOf(inner.to_string()).into()
            }
            _ => {
                panic!("Unsupported feature: {:?}", typ_info);
            }
        }
    }
}

/// Originates from a LuauTypeField: A type field used within table types. The foo: number in { foo: number }.
#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
#[serde(tag = "type")]
pub enum TypeFieldKey {
    Name {
        name: String,
    },
    IndexSignature {
        start_tok: String,
        inner: Rc<TypeFieldType>,
        end_tok: String,
    },
}

/// Originates from a LuauTypeField: A type field used within table types. The foo: number in { foo: number }.
///
/// TODO: Support read-only/write-only properties here
#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct TypeField {
    /// The comments associated with the type field
    pub comments: Vec<String>,
    /// The name of the field
    pub field_name: Rc<TypeFieldKey>,
    /// The type of the field
    pub field_type: Rc<TypeFieldType>,
}

impl TypeField {
    /// Given a LuauTypeField, convert it to a TypeField
    pub fn from_luau_type_field(tbv: &mut TypeBlockVisitor, typ_field: &LuauTypeField) -> Rc<Self> {
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
        .into()
    }
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub enum FunctionType {
    Local,
    Normal,
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct TypeDef {
    /// The name of the type
    pub name: String,
    /// The generics associated with the typedef
    pub generics: Vec<TypedArgument>,
    /// The comments associated with the type
    pub type_comments: Vec<String>,
    /// The type of the type
    pub typ: Rc<TypeFieldType>,
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct TypeFunction {
    /// The name of the function
    pub name: String,
    /// The comments associated with the type
    pub type_comments: Vec<String>,
    /// The generics of the function
    pub generics: Vec<TypedArgument>,
    /// The arguments of the function
    pub args: Vec<TypedArgument>,
    /// The return type of the function, if present
    pub ret: Option<Rc<TypeFieldType>>,
    /// Type of function
    pub function_type: FunctionType,
}

/// A type container
///
/// This is an Rc to make it cheap to clone
#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
#[serde(tag = "type")]
pub enum Type {
    TypeDef {
        #[serde(rename = "data")]
        /// The inner type definition
        inner: Rc<TypeDef>,
    },
    Function {
        #[serde(rename = "data")]
        /// The inner function type
        inner: Rc<TypeFunction>,
    },
}

#[derive(Default, Debug, Clone)]
pub struct TypeBlockVisitor {
    pub found_types: Vec<Type>,
    pub include_nonexported_types: bool,
    pub unsupported_count: usize,
    pub function_depth: usize, // Book keeping to avoid documenting inner function

    /// Book keeping to avoid typedef duplication
    ///
    /// This works because two typedefs cannot have the same name
    pub last_typedef: Option<String>,
}

impl TypeBlockVisitor {
    pub fn warn_unsupported(&mut self, msg: &str) {
        eprintln!("Warning [unsupported feature]: {}", msg);
        self.unsupported_count += 1;
    }

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

    pub fn create_type_from_type_decl(
        &mut self,
        comments: Vec<String>,
        node: &TypeDeclaration,
    ) -> Type {
        // Get node type name
        let name = extract_name_from_tokenref(node.type_name());

        // Get generics
        let generics = if let Some(generic) = node.generics() {
            self.create_typed_arguments_from_generic_declaration(generic)
        } else {
            Vec::with_capacity(0)
        };

        let typ = TypeFieldType::from_luau_typeinfo(self, node.type_definition());

        Type::TypeDef {
            inner: TypeDef {
                name,
                generics,
                type_comments: comments,
                typ,
            }
            .into(),
        }
    }
}

impl Visitor for TypeBlockVisitor {
    fn visit_function_declaration(&mut self, node: &full_moon::ast::FunctionDeclaration) {
        if self.function_depth > 0 {
            self.function_depth += 1;
            return;
        }

        self.function_depth += 1;
        let comments = get_comments_from_token_ref(node.function_token());
        let node_names = node.name().to_string();
        let typ =
            self.create_type_from_function(comments, node_names, node.body(), FunctionType::Normal);
        self.found_types.push(typ);
    }

    fn visit_function_declaration_end(&mut self, _node: &full_moon::ast::FunctionDeclaration) {
        self.function_depth -= 1;
    }

    fn visit_local_function(&mut self, node: &LocalFunction) {
        if self.function_depth > 0 {
            self.function_depth += 1;
            return;
        }

        self.function_depth += 1;
        let comments = get_comments_from_token_ref(node.local_token());
        let node_name = extract_name_from_tokenref(node.name());
        let typ =
            self.create_type_from_function(comments, node_name, node.body(), FunctionType::Local);
        self.found_types.push(typ);
    }

    fn visit_local_function_end(&mut self, _node: &LocalFunction) {
        self.function_depth -= 1;
    }

    fn visit_exported_type_declaration(&mut self, node: &ExportedTypeDeclaration) {
        if self.function_depth > 0 {
            return; // Don't document inner exported types
        }

        let typ = self.create_type_from_type_decl(
            get_comments_from_token_ref(node.export_token()),
            node.type_declaration(),
        );
        self.last_typedef = Some(extract_name_from_tokenref(
            node.type_declaration().type_name(),
        )); // Mark the last typedef. Duplication can't happen in the exported type declaration case sooo
        self.found_types.push(typ);
    }

    fn visit_type_declaration(&mut self, node: &TypeDeclaration) {
        if self.function_depth > 0 {
            return; // Don't document inner types
        }

        if self.include_nonexported_types {
            let type_name = extract_name_from_tokenref(node.type_name());

            // Ensure we don't duplicate typedefs
            if let Some(last_typedef) = &self.last_typedef {
                if *last_typedef == type_name {
                    return;
                }
            }

            self.last_typedef = Some(type_name);
            let typ = self
                .create_type_from_type_decl(get_comments_from_token_ref(node.type_token()), node);

            self.found_types.push(typ);
        }
    }
}
