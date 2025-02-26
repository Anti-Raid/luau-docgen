use full_moon::{
    ast::{
        Call, Expression, FunctionArgs, Prefix, Suffix,
        luau::{
            ExportedTypeDeclaration, IndexedTypeInfo, TypeField as LuauTypeField, TypeFieldKey,
            TypeInfo,
        },
        punctuated::Pair,
    },
    node::Node,
    parse_fallible,
    tokenizer::{Token, TokenReference, TokenType},
    visitors::Visitor,
};
use std::path::PathBuf;

#[derive(Debug, clap::Parser)]
struct CliArgs {
    #[arg(name = "path")]
    /// The path to the script to run
    script: PathBuf,
}

#[derive(Debug, Clone)]
pub enum TypeFieldType {
    /// A basic primitive type (`string`, `number`, etc)
    Basic(String),
    /// A string singleton ("hello")
    String(String),
    /// A boolean singleton (`true`, `false`)
    Boolean(bool),
    /// An array of a type
    Array(Box<TypeFieldType>),
    /// A variadic type, similar to Array
    /// ...number
    Variadic(Box<TypeFieldType>),
    /// A variadic type pack: ...T in Function<...T>    
    VariadicPack(Box<TypeFieldType>),
    /// A function type
    Function {
        /// The arguments of the function
        args: Vec<(Option<String>, TypeFieldType)>,
        /// The return type of the function
        ret: Box<TypeFieldType>,
    },
    Table {
        fields: Vec<TypeField>,
    },
    Generic {
        base: String,
        generics: Vec<TypeFieldType>,
    },

    /// T...
    GenericPack(String),

    /// A union type (e.g. `string | number`)
    Union(Vec<TypeFieldType>),

    /// A type intersection (e.g. `string & number`)
    Intersection(Vec<TypeFieldType>),

    /// A module
    Module {
        module: String,
        base: String,
        generics: Option<Vec<TypeFieldType>>,
    },

    /// Unknown module
    UnknownModule {
        /// The module name, may be empty
        name: String,
    },

    /// An optional type
    Optional(Box<TypeFieldType>),

    /// Tuple type
    Tuple(Vec<TypeFieldType>),

    /// A typeof statement
    TypeOf {
        /// The contents of the typeof
        contents: String,
    },
}

impl TypeFieldType {
    /// Tries to merge two types together
    ///
    /// Works on Tables and Tuples only
    pub fn merge(self, other: Self) -> Self {
        match (self, other) {
            (
                TypeFieldType::Table { fields },
                TypeFieldType::Table {
                    fields: other_fields,
                },
            ) => {
                let mut merged_fields = fields;
                merged_fields.extend(other_fields);
                TypeFieldType::Table {
                    fields: merged_fields,
                }
            }
            (TypeFieldType::Tuple(types), TypeFieldType::Tuple(other_types)) => {
                let mut merged_types = types;
                merged_types.extend(other_types);
                TypeFieldType::Tuple(merged_types)
            }
            _ => panic!("Cannot merge types"),
        }
    }

    /// Converts a Table type to a TypeField
    ///
    /// Only works on Table types
    pub fn to_type_field(self) -> Vec<TypeField> {
        match self {
            TypeFieldType::Table { fields } => fields,
            _ => panic!("Cannot convert non-table type to TypeField"),
        }
    }

    /// Recursively find the inner set of types that compose/make up a TypeFieldType
    pub fn unwind(&self) -> Vec<&TypeFieldType> {
        match self {
            TypeFieldType::Array(inner) => inner.unwind(),
            TypeFieldType::Variadic(inner) => inner.unwind(),
            TypeFieldType::Optional(inner) => inner.unwind(),
            TypeFieldType::Union(types) => types.iter().flat_map(|t| t.unwind()).collect(),
            TypeFieldType::Intersection(types) => types.iter().flat_map(|t| t.unwind()).collect(),
            TypeFieldType::Tuple(types) => types.iter().flat_map(|t| t.unwind()).collect(),
            _ => vec![self],
        }
    }

    pub fn string_repr(&self) -> String {
        match self {
            TypeFieldType::Basic(name) => name.clone(),
            TypeFieldType::String(name) => name.clone(),
            TypeFieldType::Boolean(name) => name.to_string(),
            TypeFieldType::Array(inner) => format!("{{{}}}", inner.string_repr()),
            TypeFieldType::Variadic(inner) => format!("...{}", inner.string_repr()),
            TypeFieldType::Generic { base, generics } => {
                let generics_str = generics
                    .iter()
                    .map(|g| g.string_repr())
                    .collect::<Vec<_>>()
                    .join(", ");
                format!("{}<{}>", base, generics_str)
            }
            TypeFieldType::GenericPack(name) => name.clone(),
            TypeFieldType::Module {
                module,
                base,
                generics,
            } => {
                if let Some(generics) = generics {
                    if generics.is_empty() {
                        format!("{}.{}", module, base)
                    } else {
                        let generics_str = generics
                            .iter()
                            .map(|g| g.string_repr())
                            .collect::<Vec<_>>()
                            .join(", ");
                        format!("{}.{}<{}>", module, base, generics_str)
                    }
                } else {
                    // If there are no generics, we can just return the module name
                    format!("{}.{}", module, base)
                }
            }
            TypeFieldType::UnknownModule { name } => name.clone(),
            TypeFieldType::TypeOf { contents } => contents.clone(),
            TypeFieldType::Optional(inner) => format!("{}?", inner.string_repr()),
            TypeFieldType::Function { args, ret } => {
                let args_str = args
                    .iter()
                    .map(|(name, typ)| {
                        if let Some(name) = name {
                            format!("{}: {}", name, typ.string_repr())
                        } else {
                            typ.string_repr()
                        }
                    })
                    .collect::<Vec<_>>()
                    .join(", ");
                format!("({}) -> {}", args_str, ret.string_repr())
            }
            TypeFieldType::Table { fields } => {
                let fields_str = fields
                    .iter()
                    .map(|f| f.field_type.string_repr())
                    .collect::<Vec<_>>()
                    .join(", ");
                format!("{{ {} }}", fields_str)
            }
            TypeFieldType::Tuple(types) => {
                let types_str = types
                    .iter()
                    .map(|t| t.string_repr())
                    .collect::<Vec<_>>()
                    .join(", ");
                format!("({})", types_str)
            }
            TypeFieldType::VariadicPack(inner) => format!("...{}", inner.string_repr()),
            TypeFieldType::Union(types) => {
                let types_str = types
                    .iter()
                    .map(|t| t.string_repr())
                    .collect::<Vec<_>>()
                    .join(" | ");
                types_str
            }
            TypeFieldType::Intersection(types) => {
                let types_str = types
                    .iter()
                    .map(|t| t.string_repr())
                    .collect::<Vec<_>>()
                    .join(" & ");
                types_str
            }
        }
    }

    /// Given a TypeInfo, convert it to a TypeField
    pub fn from_luau_typeinfo(typ_info: &TypeInfo) -> Self {
        match typ_info {
            TypeInfo::Array { type_info, .. } => {
                TypeFieldType::Array(Box::new(TypeFieldType::from_luau_typeinfo(type_info)))
            }
            TypeInfo::Basic(basic_type) => {
                let type_name = TypeBlockVisitor::extract_name_from_tokenref(basic_type);
                TypeFieldType::Basic(type_name)
            }
            TypeInfo::String(singleton) => {
                let singleton = TypeBlockVisitor::extract_name_from_tokenref(singleton);
                TypeFieldType::String(singleton)
            }
            TypeInfo::Boolean(boolean) => {
                let boolean = TypeBlockVisitor::extract_name_from_tokenref(boolean);
                TypeFieldType::Boolean(boolean == "true")
            }
            TypeInfo::Table { fields, .. } => {
                let mut type_fields = Vec::new();

                for pair in fields.pairs() {
                    match pair {
                        Pair::Punctuated(field, _) | Pair::End(field) => {
                            type_fields.push(TypeField::from_luau_type_field(field));
                        }
                    }
                }

                TypeFieldType::Table {
                    fields: type_fields,
                }
            }
            TypeInfo::Callback {
                arguments,
                return_type,
                ..
            } => {
                let mut args = Vec::new();

                for arg in arguments.iter() {
                    let Some((name, _punctuation)) = arg.name() else {
                        args.push((None, TypeFieldType::from_luau_typeinfo(arg.type_info())));
                        continue;
                    };

                    let name = TypeBlockVisitor::extract_name_from_tokenref(name);
                    let typ = TypeFieldType::from_luau_typeinfo(arg.type_info());
                    args.push((Some(name), typ));
                }

                TypeFieldType::Function {
                    args,
                    ret: Box::new(TypeFieldType::from_luau_typeinfo(return_type)),
                }
            }
            TypeInfo::Generic { base, generics, .. } => {
                let base = TypeBlockVisitor::extract_name_from_tokenref(base);
                let mut generics_arr = Vec::new();

                for generic in generics.iter() {
                    generics_arr.push(TypeFieldType::from_luau_typeinfo(generic));
                }

                TypeFieldType::Generic {
                    base,
                    generics: generics_arr,
                }
            }
            TypeInfo::GenericPack { name, .. } => {
                let name = TypeBlockVisitor::extract_name_from_tokenref(name);
                TypeFieldType::GenericPack(name)
            }
            TypeInfo::Union(types) => {
                let mut union_types = Vec::new();

                for typ in types.types() {
                    union_types.push(TypeFieldType::from_luau_typeinfo(typ));
                }

                TypeFieldType::Union(union_types)
            }
            TypeInfo::Intersection(types) => {
                let mut intersection_types = Vec::new();

                for typ in types.types() {
                    intersection_types.push(TypeFieldType::from_luau_typeinfo(typ));
                }

                TypeFieldType::Intersection(intersection_types)
            }
            TypeInfo::Module {
                module, type_info, ..
            } => {
                let module = TypeBlockVisitor::extract_name_from_tokenref(module);

                match &**type_info {
                    IndexedTypeInfo::Basic(base) => {
                        let base = TypeBlockVisitor::extract_name_from_tokenref(base);
                        TypeFieldType::Module {
                            module,
                            base,
                            generics: None,
                        }
                    }
                    IndexedTypeInfo::Generic { base, generics, .. } => {
                        let base = TypeBlockVisitor::extract_name_from_tokenref(base);
                        let mut generics_arr = Vec::new();

                        for generic in generics.iter() {
                            generics_arr.push(TypeFieldType::from_luau_typeinfo(generic));
                        }

                        TypeFieldType::Module {
                            module,
                            base,
                            generics: Some(generics_arr),
                        }
                    }
                    _ => TypeFieldType::UnknownModule { name: module }, // Can;t do anything with this
                }
            }
            TypeInfo::Optional { base, .. } => {
                TypeFieldType::Optional(Box::new(TypeFieldType::from_luau_typeinfo(base)))
            }
            TypeInfo::Tuple { types, .. } => {
                let mut tuple_types = Vec::new();

                for typ in types {
                    tuple_types.push(TypeFieldType::from_luau_typeinfo(typ));
                }

                TypeFieldType::Tuple(tuple_types)
            }
            TypeInfo::Variadic { type_info, .. } => {
                TypeFieldType::Variadic(Box::new(TypeFieldType::from_luau_typeinfo(type_info)))
            }
            TypeInfo::VariadicPack { name, .. } => {
                let name = TypeBlockVisitor::extract_name_from_tokenref(name);
                TypeFieldType::GenericPack(name)
            }
            TypeInfo::Typeof { inner, .. } => TypeFieldType::TypeOf {
                contents: inner.to_string(),
            },
            _ => {
                panic!("Unsupported feature: {:?}", typ_info);
            }
        }
    }
}

#[derive(Debug, Clone)]
pub struct TypeField {
    pub repr: String,
    pub comments: Vec<String>,
    pub field_name: String,
    pub field_type: Box<TypeFieldType>,
    pub field_type_repr: String,
    pub field_type_inner: Vec<String>,
}

impl TypeField {
    /// Given a TypeFieldType, a repr, comments and field name, create a TypeField
    pub fn new(
        repr: String,
        comments: Vec<String>,
        field_name: String,
        field_type: TypeFieldType,
    ) -> Self {
        let field_type_repr = field_type.string_repr();
        let field_type_inner = field_type
            .unwind()
            .iter()
            .map(|t| t.string_repr())
            .collect::<Vec<_>>();

        Self {
            repr,
            comments,
            field_name,
            field_type_repr,
            field_type_inner,
            field_type: Box::new(field_type),
        }
    }

    /// Given a LuauTypeField, convert it to a TypeField
    pub fn from_luau_type_field(typ_field: &LuauTypeField) -> Self {
        let key = match typ_field.key() {
            TypeFieldKey::Name(name) => TypeBlockVisitor::extract_name_from_tokenref(name),
            TypeFieldKey::IndexSignature { brackets, inner } => {
                let (start_bracket, end_bracket) = brackets.tokens();
                format!(
                    "{}{}{}",
                    TypeBlockVisitor::extract_name_from_tokenref(start_bracket),
                    TypeFieldType::from_luau_typeinfo(inner).string_repr(),
                    TypeBlockVisitor::extract_name_from_tokenref(end_bracket)
                )
            }
            _ => panic!("Unsupported feature: {:?}", typ_field.key()),
        };
        let value = typ_field.value();

        let (leading_trivia, trailing_trivia) = typ_field.surrounding_trivia();
        let comments =
            TypeBlockVisitor::extract_comments_from_trivia(leading_trivia, trailing_trivia); // It should be safe to use this here?

        let type_info = TypeFieldType::from_luau_typeinfo(value);

        Self {
            repr: typ_field.to_string(),
            comments,
            field_name: key,
            field_type_repr: type_info.string_repr(),
            field_type_inner: type_info
                .unwind()
                .iter()
                .map(|t| t.string_repr())
                .collect::<Vec<_>>(),
            field_type: Box::new(type_info),
        }
    }
}

#[derive(Debug, Clone)]
pub enum Type {
    TypeDef {
        /// The name of the type
        name: String,
        /// The comments associated with the type
        type_comments: Vec<String>,
        /// The fields of the type
        fields: Vec<TypeField>,
    },
}

#[derive(Debug, Clone)]
struct TypeBlockVisitor {
    pub found_types: Vec<Type>,
    pub current_type: Option<Type>,
}

impl TypeBlockVisitor {
    pub fn extract_comments_from_trivia(
        leading_trivia: Vec<&Token>,
        trailing_trivia: Vec<&Token>,
    ) -> Vec<String> {
        let mut comments = Vec::new();

        for token in leading_trivia.iter().chain(trailing_trivia.iter()) {
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

    pub fn extract_name_from_tokenref(token_ref: &TokenReference) -> String {
        // SAFETY: We can discard all the trivia and just get the name
        token_ref.token().to_string()
    }

    pub fn warn_unsupported(&self, msg: &str) {
        eprintln!("Warning [unsupported feature]: {}", msg);
    }
}

impl Visitor for TypeBlockVisitor {
    fn visit_exported_type_declaration(&mut self, node: &ExportedTypeDeclaration) {
        // Just in case...
        if let Some(current_type) = self.current_type.take() {
            self.found_types.push(current_type);
        }

        // Get node type name
        let name = Self::extract_name_from_tokenref(node.type_declaration().type_name());

        // Get node trivia
        let (leading_trivia, trailing_trivia) = node.surrounding_trivia();

        let comments = Self::extract_comments_from_trivia(leading_trivia, trailing_trivia);

        // For now, we only want the actual type declarations (not aliases etc)
        //println!("{:?}", node.type_declaration().type_definition());
        let typ = match node.type_declaration().type_definition() {
            TypeInfo::Table {
                fields: tfields, ..
            } => {
                println!("Table: {:?}", tfields);

                let mut fields = Vec::new();

                // Add in all the fields
                for pair in tfields.pairs() {
                    match pair {
                        Pair::Punctuated(field, _) | Pair::End(field) => {
                            let field = TypeField::from_luau_type_field(field);
                            fields.push(field);
                        }
                    }
                }

                Type::TypeDef {
                    name,
                    type_comments: comments,
                    fields,
                }
            }
            TypeInfo::Typeof { inner, .. } => {
                // Handle setmetatable
                match &**inner {
                    Expression::FunctionCall(fc) => {
                        println!("{:?}", fc.prefix());

                        let Prefix::Name(s) = fc.prefix() else {
                            self.warn_unsupported(
                                "Only simple typeof setmetatable cases are supported!",
                            );
                            return;
                        };

                        if Self::extract_name_from_tokenref(s) == "setmetatable" {
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
                                        let mut typ_field: Option<TypeFieldType> = None;
                                        for type_assertion in type_assertions {
                                            let type_info = TypeFieldType::from_luau_typeinfo(
                                                type_assertion.cast_to(),
                                            );
                                            if let Some(typ_current) = typ_field {
                                                typ_field = Some(typ_current.merge(type_info));
                                            } else {
                                                typ_field = Some(type_info);
                                            }
                                        }

                                        if let Some(typ_val) = typ_field {
                                            typ = Some(typ_val.to_type_field());
                                            break;
                                        } else {
                                            continue;
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
                                Type::TypeDef {
                                    name,
                                    type_comments: comments,
                                    fields: typ,
                                }
                            } else {
                                self.warn_unsupported(
                                    "Only simple typeof setmetatable cases are supported!",
                                );
                                return;
                            }
                        } else {
                            self.warn_unsupported(
                                "Only simple typeof setmetatable cases are supported!",
                            );
                            return;
                        }
                    }
                    _ => {
                        self.warn_unsupported(
                            "Only simple typeof cases involving setmetatable is supported!",
                        );
                        return;
                    }
                }
            }
            _ => {
                self.warn_unsupported("Only table and typeof are supported!");
                return;
            } // TODO: Support other types of type declarations if required in antiraid typings
        };

        self.current_type = Some(typ);
    }

    fn visit_exported_type_declaration_end(&mut self, _node: &ExportedTypeDeclaration) {
        if let Some(current_type) = self.current_type.take() {
            self.found_types.push(current_type);
        }

        self.current_type = None;
    }
}

fn main() {
    let args = <CliArgs as clap::Parser>::parse();

    if !args.script.exists() {
        eprintln!("Error: Script file does not exist: {:?}", args.script);
        std::process::exit(1);
    }

    let source = std::fs::read_to_string(&args.script).unwrap_or_else(|_| {
        eprintln!("Error: Failed to read script file: {:?}", args.script);
        std::process::exit(1);
    });

    let mut type_visitor = TypeBlockVisitor {
        found_types: Vec::new(),
        current_type: None,
    };

    let result = parse_fallible(&source, full_moon::LuaVersion::luau());
    if !result.errors().is_empty() {
        eprintln!("Error: Failed to parse script file: {:?}", args.script);
        for error in result.errors() {
            eprintln!("Error: {:?}", error);
        }
        std::process::exit(1);
    }

    let ast = result.into_ast();

    type_visitor.visit_ast(&ast);

    println!("{:#?}", type_visitor.found_types);
}
