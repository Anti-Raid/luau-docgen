//#![feature(non_exhaustive_omitted_patterns_lint)]
//#![deny(non_exhaustive_omitted_patterns)]

#[allow(unused_imports)]
use full_moon::{
    ast::{
        Assignment, Block, Call, Do, Expression, Field, FunctionArgs, FunctionBody, FunctionCall,
        FunctionDeclaration, FunctionName, GenericFor, Index, LastStmt, MethodCall, Parameter,
        Prefix, Return, Stmt, Suffix, TableConstructor, Var, VarExpression,
        luau::{
            ExportedTypeDeclaration, GenericDeclaration, GenericDeclarationParameter,
            GenericParameterInfo, IndexedTypeInfo, TypeArgument, TypeField as LuauTypeField,
            TypeFieldKey, TypeInfo, TypeIntersection, TypeSpecifier, TypeUnion,
        },
        punctuated::{Pair, Punctuated},
        span::ContainedSpan,
    },
    node::Node,
    parse_fallible,
    tokenizer::{TokenReference, TokenType},
    visitors::Visitor,
};
use full_moon::{
    ast::{
        BinOp, UnOp,
        luau::{
            ElseIfExpression, IfExpression, InterpolatedString, InterpolatedStringSegment,
            TypeAssertion,
        },
    },
    tokenizer::Token,
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

        pub struct TypeFieldCommentVisitor {
            pub comments: Vec<String>,
        }

        impl Visitor for TypeFieldCommentVisitor {
            fn visit_single_line_comment(&mut self, token: &full_moon::tokenizer::Token) {
                println!("Single line comment: {}", token);
                self.comments.push(token.to_string());
            }

            fn visit_multi_line_comment(&mut self, token: &full_moon::tokenizer::Token) {
                println!("Multi line comment: {}", token);
                self.comments.push(token.to_string());
            }
        }

        // Get the comments from the field
        let mut comment_visitor = TypeFieldCommentVisitor {
            comments: Vec::new(),
        };

        // Visit the field to get the comments
        comment_visitor.visit_type_field(typ_field);

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
}

impl TypeBlockVisitor {
    // Not safe to use in most cases, avoid using
    pub fn extract_comments_from_trivia(
        leading_trivia: Vec<&Token>,
        trailing_trivia: Vec<&Token>,
    ) -> Vec<String> {
        let mut comments = Vec::new();

        for token in leading_trivia.iter().chain(trailing_trivia.iter()) {
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

    #[allow(dead_code)]
    /// Hack to work around full moon AST issues
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

        self.found_types.push(typ);
    }
}

pub enum TaggedTokenReference {
    Ref { token_ref: TokenReference },
    Vec,
    Punctuated,
    PairPunctuated,
    PairEnd,
    ContainedSpan,
    BinOp,
    UnOp,
    Tag { tag: String },
}

impl From<TokenReference> for TaggedTokenReference {
    fn from(token_ref: TokenReference) -> Self {
        Self::Ref { token_ref }
    }
}

impl From<&TokenReference> for TaggedTokenReference {
    fn from(token_ref: &TokenReference) -> Self {
        Self::Ref {
            token_ref: token_ref.clone(),
        }
    }
}

impl From<&str> for TaggedTokenReference {
    fn from(tag: &str) -> Self {
        Self::Tag {
            tag: tag.to_string(),
        }
    }
}

/// Abstraction to extract token references from compatible types
trait TokenReferenceExtractor {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference>;
}

/// All tokenreferences are token references
impl TokenReferenceExtractor for TokenReference {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        vec![self.into()]
    }
}

/// Vec impl
impl<T: TokenReferenceExtractor> TokenReferenceExtractor for Vec<T> {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec![TaggedTokenReference::Vec];
        for item in self {
            token_refs.extend(item.extract_token_refs());
        }
        token_refs
    }
}

/// Pair impl
impl<T: TokenReferenceExtractor> TokenReferenceExtractor for Pair<T> {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = Vec::new();
        match self {
            Pair::Punctuated(item, token_ref) => {
                token_refs.push(TaggedTokenReference::PairPunctuated);
                token_refs.extend(item.extract_token_refs());
                token_refs.push(token_ref.into());
            }
            Pair::End(item) => {
                token_refs.push(TaggedTokenReference::PairEnd);
                token_refs.extend(item.extract_token_refs());
            }
        }
        token_refs
    }
}

/// Punctuated impl
impl<T: TokenReferenceExtractor> TokenReferenceExtractor for Punctuated<T> {
    // #[display("{}", util::join_vec(pairs))]
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec![TaggedTokenReference::Punctuated];
        for pair in self.into_pairs() {
            token_refs.extend(pair.extract_token_refs());
        }
        token_refs
    }
}

// A really common type
impl TokenReferenceExtractor for ContainedSpan {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let (start, end) = self.tokens();
        vec![
            TaggedTokenReference::ContainedSpan,
            start.into(),
            end.into(),
        ]
    }
}

/*
   /// A name, such as `foo`.
   #[display("{_0}")]
   Name(TokenReference),

   /// A variadic type pack: `T...`.
   #[display("{name}{ellipsis}")]
   Variadic {
       /// The name of the type that is variadic: `T`.
       name: TokenReference,
       /// The ellipsis: `...`.
       ellipsis: TokenReference,
   },
*/
impl TokenReferenceExtractor for GenericParameterInfo {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        match self {
            GenericParameterInfo::Name(name) => {
                vec!["GenericParameterInfo".into(), name.into()]
            }
            GenericParameterInfo::Variadic { name, ellipsis } => {
                vec!["GenericParameterInfo".into(), name.into(), ellipsis.into()]
            }
            _ => todo!(),
        }
    }
}

/*
#[display(
    "{}{}{}",
    parameter,
    display_option(self.equals()),
    display_option(self.default_type())
)]
*/
impl TokenReferenceExtractor for GenericDeclarationParameter {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["GenericDeclarationParameter".into()];
        token_refs.extend(self.parameter().clone().extract_token_refs());
        if let Some(equals) = self.equals() {
            token_refs.push(equals.into());
        }
        if let Some(default_type) = self.default_type() {
            token_refs.extend(default_type.clone().extract_token_refs());
        }
        token_refs
    }
}

impl TokenReferenceExtractor for GenericDeclaration {
    //#[display("{}{}{}", arrows.tokens().0, generics, arrows.tokens().1)]
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["GenericDeclaration".into()];
        let (start, end) = self.arrows().tokens();
        token_refs.push(start.into());
        token_refs.extend(self.generics().clone().extract_token_refs());
        token_refs.push(end.into());

        token_refs
    }
}

impl TokenReferenceExtractor for TypeIntersection {
    /*
    #[display("{}{types}", display_option(leading))]
    pub struct TypeIntersection {
        pub(crate) leading: Option<TokenReference>,
        pub(crate) types: Punctuated<TypeInfo>,
    }
    */
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["TypeIntersection".into()];
        if let Some(leading) = self.leading() {
            token_refs.push(leading.into());
        }

        token_refs.extend(self.types().clone().extract_token_refs());
        token_refs
    }
}

impl TokenReferenceExtractor for TypeUnion {
    /*
    #[display("{}{types}", display_option(leading))]
    pub struct TypeIntersection {
        pub(crate) leading: Option<TokenReference>,
        pub(crate) types: Punctuated<TypeInfo>,
    }
    */
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["TypeUnion".into()];
        if let Some(leading) = self.leading() {
            token_refs.push(leading.into());
        }

        token_refs.extend(self.types().clone().extract_token_refs());
        token_refs
    }
}

impl TokenReferenceExtractor for IndexedTypeInfo {
    /*
        /// A standalone type, such as `string` or `Foo`.
    #[display("{_0}")]
    Basic(TokenReference),

    /// A type using generics, such as `map<number, string>`.
    #[display("{base}{}{generics}{}", arrows.tokens().0, arrows.tokens().1)]
    Generic {
        /// The type that has generics: `map`.
        base: TokenReference,
        /// The arrows (`<>`) containing the type parameters.
        arrows: ContainedSpan,
        /// The type parameters: `number, string`.
        generics: Punctuated<TypeInfo>,
    },
     */
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["IndexedTypeInfo".into()];
        match self {
            IndexedTypeInfo::Basic(basic_type) => {
                token_refs.push(basic_type.into());
            }
            IndexedTypeInfo::Generic {
                base,
                arrows,
                generics,
            } => {
                let (start, end) = arrows.tokens();
                token_refs.push(base.into());
                token_refs.push(start.into());
                token_refs.extend(generics.extract_token_refs());
                token_refs.push(end.into());
            }
            _ => todo!(),
        }
        token_refs
    }
}

impl TokenReferenceExtractor for TypeArgument {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        /*
                if let Some((identifier, punctuation)) = self.name() {
            write!(formatter, "{}{}{}", identifier, punctuation, self.type_info)
        } else {
            write!(formatter, "{}", self.type_info)
        }
         */
        let mut token_refs = vec!["TypeArgument".into()];
        if let Some((identifier, punctuation)) = self.name() {
            token_refs.push(identifier.into());
            token_refs.push(punctuation.into());
            token_refs.extend(self.type_info().clone().extract_token_refs());
        } else {
            token_refs.extend(self.type_info().clone().extract_token_refs());
        }

        token_refs
    }
}

impl TokenReferenceExtractor for Parameter {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        match self {
            Parameter::Name(tr) | Parameter::Ellipsis(tr) => vec!["Parameter".into(), tr.into()],
            _ => todo!(),
        }
    }
}

impl TokenReferenceExtractor for TypeSpecifier {
    /*
    #[display("{punctuation}{type_info}")]
    pub struct TypeSpecifier {
         */
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["TypeSpecifier".into()];
        token_refs.push(self.punctuation().into());
        token_refs.extend(self.type_info().clone().extract_token_refs());
        token_refs
    }
}

impl TokenReferenceExtractor for Return {
    /*
        #[display("{token}{returns}")]
        pub struct Return {
    */
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["Return".into()];
        token_refs.push(self.token().into());
        token_refs.extend(self.returns().clone().extract_token_refs());
        token_refs
    }
}

/*
    #[display("{_0}")]
    /// A complicated expression, such as `("foo")`
    Expression(Box<Expression>),
    #[display("{_0}")]
    /// Just a name, such as `foo`
    Name(TokenReference),
*/
impl TokenReferenceExtractor for Prefix {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        match self {
            Prefix::Name(tr) => vec!["Prefix".into(), tr.into()],
            Prefix::Expression(expr) => {
                let mut token_refs = vec!["Prefix".into()];
                token_refs.extend(expr.extract_token_refs());
                token_refs
            }
            _ => todo!(),
        }
    }
}

/*
   /// A key in the format of `[expression] = value`
   #[display(
       "{}{}{}{}{}",
       brackets.tokens().0,
       key,
       brackets.tokens().1,
       equal,
       value
   )]
   ExpressionKey {
       /// The `[...]` part of `[expression] = value`
       brackets: ContainedSpan,
       /// The `expression` part of `[expression] = value`
       key: Expression,
       /// The `=` part of `[expression] = value`
       equal: TokenReference,
       /// The `value` part of `[expression] = value`
       value: Expression,
   },

   /// A key in the format of `name = value`
   #[display("{key}{equal}{value}")]
   NameKey {
       /// The `name` part of `name = value`
       key: TokenReference,
       /// The `=` part of `name = value`
       equal: TokenReference,
       /// The `value` part of `name = value`
       value: Expression,
   },

   /// A field with no key, just a value (such as `"a"` in `{ "a" }`)
   #[display("{_0}")]
   NoKey(Expression),
*/
impl TokenReferenceExtractor for Field {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["Field".into()];
        match self {
            Self::ExpressionKey {
                brackets,
                key,
                equal,
                value,
            } => {
                let (start, end) = brackets.tokens();
                token_refs.push(start.into());
                token_refs.extend(key.extract_token_refs());
                token_refs.push(end.into());
                token_refs.push(equal.into());
                token_refs.extend(value.extract_token_refs());
            }
            Self::NameKey { key, equal, value } => {
                token_refs.push(key.into());
                token_refs.push(equal.into());
                token_refs.extend(value.extract_token_refs());
            }
            Self::NoKey(expr) => {
                token_refs.extend(expr.extract_token_refs());
            }
            _ => todo!(),
        };
        token_refs
    }
}

/*
#[display("{}{}{}", braces.tokens().0, fields, braces.tokens().1)]
pub struct TableConstructor {
 */
impl TokenReferenceExtractor for TableConstructor {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["TableConstructor".into()];
        let (start, end) = self.braces().tokens();
        token_refs.push(start.into());
        token_refs.extend(self.fields().clone().extract_token_refs());
        token_refs.push(end.into());
        token_refs
    }
}

/*
    /// Used when a function is called in the form of `call(1, 2, 3)`
    #[display(
        "{}{}{}",
        parentheses.tokens().0,
        arguments,
        parentheses.tokens().1
    )]
    Parentheses {
        /// The `(...) part of (1, 2, 3)`
        #[node(full_range)]
        parentheses: ContainedSpan,
        /// The `1, 2, 3` part of `1, 2, 3`
        arguments: Punctuated<Expression>,
    },
    /// Used when a function is called in the form of `call "foobar"`
    #[display("{_0}")]
    String(TokenReference),
    /// Used when a function is called in the form of `call { 1, 2, 3 }`
    #[display("{_0}")]
    TableConstructor(TableConstructor),
*/
impl TokenReferenceExtractor for FunctionArgs {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["FunctionArgs".into()];
        match self {
            Self::Parentheses {
                parentheses,
                arguments,
            } => {
                let (start, end) = parentheses.tokens();
                token_refs.push(start.into());
                token_refs.extend(arguments.extract_token_refs());
                token_refs.push(end.into());
            }
            Self::String(tr) => {
                token_refs.push(tr.into());
            }
            Self::TableConstructor(tc) => {
                token_refs.extend(tc.extract_token_refs());
            }
            _ => todo!(),
        };
        token_refs
    }
}

/*
#[display("{}{}", prefix, join_vec(suffixes))]
pub struct FunctionCall {
    prefix: Prefix,
    suffixes: Vec<Suffix>,
}
*/
impl TokenReferenceExtractor for FunctionCall {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = Vec::new();
        token_refs.extend(self.prefix().clone().extract_token_refs());
        for suffix in self.suffixes() {
            token_refs.extend(suffix.clone().extract_token_refs());
        }
        token_refs
    }
}

/*
/// A method call, such as `x:y()`
#[derive(Clone, Debug, Display, PartialEq, Node, Visit)]
#[cfg_attr(feature = "serde", derive(Deserialize, Serialize))]
#[display("{colon_token}{name}{args}")]
pub struct MethodCall {
 */
impl TokenReferenceExtractor for MethodCall {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["MethodCall".into()];
        token_refs.push(self.colon_token().into());
        token_refs.push(self.name().into());
        token_refs.extend(self.args().clone().extract_token_refs());
        token_refs
    }
}

/*
   #[display("{_0}")]
   /// A function being called directly, such as `x(1)`
   AnonymousCall(FunctionArgs),
   #[display("{_0}")]
   /// A method call, such as `x:y()`
   MethodCall(MethodCall),
*/
impl TokenReferenceExtractor for Call {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = Vec::new();
        match self {
            Self::AnonymousCall(args) => {
                token_refs.extend(args.extract_token_refs());
            }
            Self::MethodCall(mc) => {
                token_refs.extend(mc.extract_token_refs());
            }
            _ => todo!(),
        };
        token_refs
    }
}

/*
   /// Indexing in the form of `x["y"]`
   #[display("{}{}{}", brackets.tokens().0, expression, brackets.tokens().1)]
   Brackets {
       /// The `[...]` part of `["y"]`
       brackets: ContainedSpan,
       /// The `"y"` part of `["y"]`
       expression: Expression,
   },

   /// Indexing in the form of `x.y`
   #[display("{dot}{name}")]
   Dot {
       /// The `.` part of `.y`
       dot: TokenReference,
       /// The `y` part of `.y`
       name: TokenReference,
   },
*/
impl TokenReferenceExtractor for Index {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["Index".into()];

        match self {
            Self::Brackets {
                brackets,
                expression,
            } => {
                let (start, end) = brackets.tokens();
                token_refs.push(start.into());
                token_refs.extend(expression.extract_token_refs());
                token_refs.push(end.into());
            }
            Self::Dot { dot, name } => {
                token_refs.push(dot.into());
                token_refs.push(name.into());
            }
            _ => todo!(),
        };

        token_refs
    }
}

/*
pub enum Suffix {
    #[display("{_0}")]
    /// A call, including method calls and direct calls
    Call(Call),
    #[display("{_0}")]
    /// An index, such as `x.y`
    Index(Index),
}
 */
impl TokenReferenceExtractor for Suffix {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["Suffix".into()];
        match self {
            Self::Call(call) => {
                token_refs.extend(call.extract_token_refs());
            }
            Self::Index(index) => {
                token_refs.extend(index.extract_token_refs());
            }
            _ => todo!(),
        };
        token_refs
    }
}

/*
#[display("{}{}", prefix, join_vec(suffixes))]
pub struct VarExpression {
    prefix: Prefix,
    suffixes: Vec<Suffix>,
}
*/
impl TokenReferenceExtractor for VarExpression {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = Vec::new();
        token_refs.extend(self.prefix().clone().extract_token_refs());
        for suffix in self.suffixes() {
            token_refs.extend(suffix.clone().extract_token_refs());
        }
        token_refs
    }
}

impl TokenReferenceExtractor for Var {
    /*
    /// An expression, such as `x.y.z` or `x()`
    #[display("{_0}")]
    Expression(Box<VarExpression>),
    /// A literal identifier, such as `x`
    #[display("{_0}")]
    Name(TokenReference),
     */
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["Var".into()];
        match self {
            Self::Expression(expr) => {
                token_refs.extend(expr.extract_token_refs());
            }
            Self::Name(tr) => {
                token_refs.push(tr.into());
            }
            _ => todo!(),
        };
        token_refs
    }
}

impl TokenReferenceExtractor for Assignment {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        // #[display("{var_list}{equal_token}{expr_list}")]
        let mut token_refs = vec!["Assignment".into()];
        token_refs.extend(self.variables().clone().extract_token_refs());
        token_refs.push(self.equal_token().into());
        token_refs.extend(self.expressions().clone().extract_token_refs());
        token_refs
    }
}

/*
   /// A `break` statement
   Break(TokenReference),
   /// A continue statement
   /// Only available when the "luau" feature flag is enabled.
   #[cfg(feature = "luau")]
   Continue(TokenReference),
   /// A `return` statement
   Return(Return),
*/
impl TokenReferenceExtractor for LastStmt {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        match self {
            Self::Break(tr) => vec!["LastStmt".into(), tr.into()],
            Self::Continue(tr) => vec!["LastStmt".into(), tr.into()],
            Self::Return(ret) => ret.extract_token_refs(),
            _ => todo!(),
        }
    }
}

/*
#[display(
    "{}{}",
    display_optional_punctuated_vec(stmts),
    display_option(last_stmt.as_ref().map(display_optional_punctuated))
)]
pub struct Block {
*/
impl TokenReferenceExtractor for Block {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["Block".into()];
        for (stmt, token_ref) in self.stmts_with_semicolon().cloned() {
            // First push stmt
            token_refs.extend(stmt.extract_token_refs());
            // Then push the semicolon
            if let Some(token_ref) = token_ref {
                token_refs.push(token_ref.into());
            }
        }

        if let Some((last_stmt, last_token_ref)) = self.last_stmt_with_semicolon().cloned() {
            // First push last_stmt
            token_refs.extend(last_stmt.extract_token_refs());
            // Then push the semicolon
            if let Some(token_ref) = last_token_ref {
                token_refs.push(token_ref.into());
            }
        }

        token_refs
    }
}

/*
#[display(
    "{}{}{}",
    names,
    display_option(self.method_colon()),
    display_option(self.method_name())
)]
pub struct FunctionName {
*/
impl TokenReferenceExtractor for FunctionName {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["FunctionName".into()];
        token_refs.extend(self.names().clone().extract_token_refs());
        if let Some(method_colon) = self.method_colon() {
            token_refs.push(method_colon.into());
        }
        if let Some(method_name) = self.method_name() {
            token_refs.push(method_name.into());
        }
        token_refs
    }
}

/*
       write!(
           formatter,
           "{}{}{}{}{}{}{}",
           self.for_token,
           join_type_specifiers(&self.names, self.type_specifiers()),
           self.in_token,
           self.expr_list,
           self.do_token,
           self.block,
           self.end_token
       )
*/
impl TokenReferenceExtractor for GenericFor {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["GenericFor".into()];
        // For token
        token_refs.push(self.for_token().into());
        // Type specifiers (join_type_specifiers)
        for (parameter, type_specifier) in self.names().pairs().zip(
            self.type_specifiers()
                .chain(std::iter::repeat_with(|| None)),
        ) {
            token_refs.push(parameter.value().into());
            if let Some(type_specifier) = type_specifier {
                token_refs.extend(type_specifier.clone().extract_token_refs());
            }
            if let Some(punctuation) = parameter.punctuation() {
                token_refs.push(punctuation.into());
            }
        }

        // In token
        token_refs.push(self.in_token().into());

        // Expression list
        token_refs.extend(self.expressions().clone().extract_token_refs());

        // Do token
        token_refs.push(self.do_token().into());

        // Block
        token_refs.extend(self.block().clone().extract_token_refs());

        // End token
        token_refs.push(self.end_token().into());

        token_refs
    }
}

/*#[display("{do_token}{block}{end_token}")]
pub struct Do {
*/
impl TokenReferenceExtractor for Do {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["Do".into()];
        token_refs.push(self.do_token().into());
        token_refs.extend(self.block().clone().extract_token_refs());
        token_refs.push(self.end_token().into());
        token_refs
    }
}

/*
#[cfg_attr(feature = "luau", display("{function_token}{name}{body}"))]
pub struct FunctionDeclaration {
 */
impl TokenReferenceExtractor for FunctionDeclaration {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["FunctionDeclaration".into()];
        token_refs.push(self.function_token().into());
        token_refs.extend(self.name().clone().extract_token_refs());
        token_refs.extend(self.body().clone().extract_token_refs());
        token_refs
    }
}

/*
    /// An assignment, such as `x = 1`
    #[display("{_0}")]
    Assignment(Assignment),
    /// A do block, `do end`
    #[display("{_0}")]
    Do(Do),
    /// A function call on its own, such as `call()`
    #[display("{_0}")]
    FunctionCall(FunctionCall),
    /// A function declaration, such as `function x() end`
    #[display("{_0}")]
    FunctionDeclaration(FunctionDeclaration),
    /// A generic for loop, such as `for index, value in pairs(list) do end`
    #[display("{_0}")]
    GenericFor(GenericFor),
    /// An if statement
    #[display("{_0}")]
    If(If),
    /// A local assignment, such as `local x = 1`
    #[display("{_0}")]
    LocalAssignment(LocalAssignment),
    /// A local function declaration, such as `local function x() end`
    #[display("{_0}")]
    LocalFunction(LocalFunction),
    /// A numeric for loop, such as `for index = 1, 10 do end`
    #[display("{_0}")]
    NumericFor(NumericFor),
    /// A repeat loop
    #[display("{_0}")]
    Repeat(Repeat),
    /// A while loop
    #[display("{_0}")]
    While(While),

    /// A compound assignment, such as `+=`
    /// Only available when the "luau" feature flag is enabled
    #[cfg(feature = "luau")]
    #[display("{_0}")]
    CompoundAssignment(CompoundAssignment),
    /// An exported type declaration, such as `export type Meters = number`
    /// Only available when the "luau" feature flag is enabled.
    #[cfg(feature = "luau")]
    ExportedTypeDeclaration(ExportedTypeDeclaration),
    /// A type declaration, such as `type Meters = number`
    /// Only available when the "luau" feature flag is enabled.
    #[cfg(feature = "luau")]
    TypeDeclaration(TypeDeclaration),
    /// An exported type function, such as `export type function Pairs(...) end`
    /// Only available when the "luau" feature flag is enabled.
    #[cfg(feature = "luau")]
    ExportedTypeFunction(ExportedTypeFunction),
    /// A type function, such as `type function Pairs(...) end`
    /// Only available when the "luau" feature flag is enabled.
    #[cfg(feature = "luau")]
    TypeFunction(TypeFunction),

    /// A goto statement, such as `goto label`
    /// Only available when the "lua52" or "luajit" feature flag is enabled.
    #[cfg(any(feature = "lua52", feature = "luajit"))]
    Goto(Goto),
    /// A label, such as `::label::`
    /// Only available when the "lua52" or "luajit" feature flag is enabled.
    #[cfg(any(feature = "lua52", feature = "luajit"))]
    Label(Label),
*/
impl TokenReferenceExtractor for Stmt {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        vec![] // TODO
    }
}

impl TokenReferenceExtractor for FunctionBody {
    /*
       write!(
           formatter,
           "{}{}{}{}{}{}{}",
           display_option(self.generics.as_ref()),
           self.parameters_parentheses.tokens().0,
           join_type_specifiers(&self.parameters, self.type_specifiers()),
           self.parameters_parentheses.tokens().1,
           display_option(self.return_type.as_ref()),
           self.block,
           self.end_token
       )
    */

    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["FunctionBody".into()];
        if let Some(generics) = self.generics() {
            token_refs.extend(generics.clone().extract_token_refs());
        }
        let (start, end) = self.parameters_parentheses().tokens();
        token_refs.push(start.into());
        token_refs.extend(self.parameters().clone().extract_token_refs());
        token_refs.push(end.into());
        if let Some(return_type) = self.return_type() {
            token_refs.extend(return_type.clone().extract_token_refs());
        }
        token_refs.extend(self.block().clone().extract_token_refs());
        token_refs.push(self.end_token().into());

        token_refs
    }
}

impl TokenReferenceExtractor for TypeAssertion {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["TypeAssertion".into()];
        token_refs.push(self.assertion_op().into());
        token_refs.extend(self.cast_to().clone().extract_token_refs());
        token_refs
    }
}

impl TokenReferenceExtractor for BinOp {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        vec![TaggedTokenReference::BinOp, self.token().into()]
    }
}

impl TokenReferenceExtractor for UnOp {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        vec![TaggedTokenReference::UnOp, self.token().into()]
    }
}

/*
#[display(
    "{}{}{}{}{}{}{}",
    if_token,
    condition,
    then_token,
    if_expression,
    display_option(else_if_expressions.as_ref().map(join_vec)),
    else_token,
    else_expression
)]
pub struct IfExpression {
*/
impl TokenReferenceExtractor for IfExpression {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["IfExpression".into()];
        token_refs.push(self.if_token().into());
        token_refs.extend(self.condition().clone().extract_token_refs());
        token_refs.push(self.then_token().into());
        token_refs.extend(self.if_expression().clone().extract_token_refs());
        if let Some(else_if_expressions) = self.else_if_expressions() {
            token_refs.extend(else_if_expressions.clone().extract_token_refs());
        }
        token_refs.push(self.else_token().into());
        token_refs.extend(self.else_expression().clone().extract_token_refs());

        token_refs
    }
}

/*
#[display("{else_if_token}{condition}{then_token}{expression}")]
pub struct ElseIfExpression {
 */
impl TokenReferenceExtractor for ElseIfExpression {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["ElseIfExpression".into()];
        token_refs.push(self.else_if_token().into());
        token_refs.extend(self.condition().clone().extract_token_refs());
        token_refs.push(self.then_token().into());
        token_refs.extend(self.expression().clone().extract_token_refs());

        token_refs
    }
}

/*
#[display("{literal}{expression}")]
pub struct InterpolatedStringSegment {
 */
impl TokenReferenceExtractor for InterpolatedStringSegment {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["InterpolatedStringSegment".into()];
        token_refs.push(self.literal.into());
        token_refs.extend(self.expression.extract_token_refs());
        token_refs
    }
}

/*
#[display("{}{}", join_vec(segments), last_string)]
pub struct InterpolatedString {
    pub(crate) segments: Vec<InterpolatedStringSegment>,
*/
impl TokenReferenceExtractor for InterpolatedString {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["InterpolatedString".into()];
        for segment in self.segments() {
            token_refs.extend(segment.clone().extract_token_refs());
        }
        token_refs.push(self.last_string().into());
        token_refs
    }
}

impl TokenReferenceExtractor for Expression {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        /*
           #[display("{lhs}{binop}{rhs}")]
           BinaryOperator {

           /// A statement in parentheses, such as `(#list)`
           #[display("{}{}{}", contained.tokens().0, expression, contained.tokens().1)]
           Parentheses {

           /// A unary operation, such as `#list`
           #[display("{unop}{expression}")]
           UnaryOperator {

           /// An anonymous function, such as `function() end`
           #[display("{}{}", _0.0, _0.1)]
           Function(Box<(TokenReference, FunctionBody)>),

           /// A call of a function, such as `call()`
           #[display("{_0}")]
           FunctionCall(FunctionCall),

           #[display("{_0}")]
           IfExpression(IfExpression),

           #[display("{_0}")]
           InterpolatedString(InterpolatedString),

           /// A table constructor, such as `{ 1, 2, 3 }`
           #[display("{_0}")]
           TableConstructor(TableConstructor),

           /// A number token, such as `3.3`
           #[display("{_0}")]
           Number(TokenReference),

           /// A string token, such as `"hello"`
           #[display("{_0}")]
           String(TokenReference),

           /// A symbol, such as `true`
           #[display("{_0}")]
           Symbol(TokenReference),

           #[display("{expression}{type_assertion}")]
           TypeAssertion {
               /// The expression being asserted
               expression: Box<Expression>,

               /// The type assertion
               type_assertion: TypeAssertion,
           },

           /// A more complex value, such as `call().x`
           #[display("{_0}")]
           Var(Var),
        */
        match self {
            Self::BinaryOperator { lhs, binop, rhs } => {
                let mut token_refs = vec!["Expression.BinaryOperator".into()];
                token_refs.extend(lhs.extract_token_refs());
                token_refs.extend(binop.extract_token_refs());
                token_refs.extend(rhs.extract_token_refs());
                token_refs
            }
            Self::Parentheses {
                contained,
                expression,
            } => {
                let mut token_refs = vec!["Expression.Parentheses".into()];
                let (start, end) = contained.tokens();
                token_refs.push(start.into());
                token_refs.extend(expression.extract_token_refs());
                token_refs.push(end.into());
                token_refs
            }
            Self::UnaryOperator { unop, expression } => {
                let mut token_refs = vec!["Expression.UnaryOperator".into()];
                token_refs.extend(unop.extract_token_refs());
                token_refs.extend(expression.extract_token_refs());
                token_refs
            }
            Self::Function(func) => {
                let mut token_refs = vec!["Expression.Function".into()];
                token_refs.push(func.0.into());
                token_refs.extend(func.1.extract_token_refs());
                token_refs
            }
            Self::FunctionCall(call) => call.extract_token_refs(),
            Self::IfExpression(if_expr) => if_expr.extract_token_refs(),
            Self::InterpolatedString(interpolated_string) => {
                interpolated_string.extract_token_refs()
            }
            Self::TableConstructor(tc) => tc.extract_token_refs(),
            Self::Number(tr) => vec![tr.into()],
            Self::String(tr) => vec![tr.into()],
            Self::Symbol(tr) => vec![tr.into()],
            Self::TypeAssertion {
                expression,
                type_assertion,
            } => {
                let mut token_refs = Vec::new();
                token_refs.extend(expression.extract_token_refs());
                token_refs.extend(type_assertion.extract_token_refs());
                token_refs
            }
            Self::Var(var) => var.extract_token_refs(),
            _ => todo!(),
        }
    }
}

impl TokenReferenceExtractor for TypeInfo {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["TypeInfo".into()];
        match self {
            TypeInfo::Array {
                braces,
                access,
                type_info,
            } => {
                let (b0, b1) = braces.tokens();
                token_refs.push(b0.into());
                if let Some(access) = access {
                    token_refs.push(access.into());
                }
                token_refs.extend(type_info.extract_token_refs());
                token_refs.push(b1.into());
            }
            TypeInfo::Basic(tr) | TypeInfo::String(tr) | TypeInfo::Boolean(tr) => {
                token_refs.push(tr.into());
            }
            TypeInfo::Callback {
                generics,
                parentheses,
                arguments,
                arrow,
                return_type,
            } => {
                /*
                 #[display(
                    "{}{}{arguments}{}{arrow}{return_type}",
                    display_option(generics),
                    parentheses.tokens().0,
                    parentheses.tokens().1
                )]
                */
                if let Some(generics) = generics {
                    token_refs.extend(generics.extract_token_refs());
                }
                let (start, end) = parentheses.tokens();
                token_refs.push(start.into());
                token_refs.extend(arguments.extract_token_refs());
                token_refs.push(end.into());
                token_refs.push(arrow.into());
                token_refs.extend(return_type.extract_token_refs());
            }
            TypeInfo::Generic {
                base,
                arrows,
                generics,
            } => {
                /*
                                   /// A type using generics, such as `map<number, string>`.
                   #[display(
                       "{}{}{}{}",
                       base,
                       arrows.tokens().0,
                       generics,
                       arrows.tokens().1
                   )]
                   Generic {
                       /// The type that has generics: `map`.
                       base: TokenReference,
                       /// The arrows (`<>`) containing the type parameters.
                       arrows: ContainedSpan,
                       /// The type parameters: `number, string`.
                       generics: Punctuated<TypeInfo>,
                   },
                */

                token_refs.push(base.into());
                let (start, end) = arrows.tokens();
                token_refs.push(start.into());
                token_refs.extend(generics.extract_token_refs());
                token_refs.push(end.into());
            }
            TypeInfo::GenericPack { name, ellipsis } => {
                /*
                   #[display("{name}{ellipsis}")]
                   GenericPack {
                       /// The name of the type that is generic: `T`.
                       name: TokenReference,
                       /// The ellipsis: `...`.
                       ellipsis: TokenReference,
                   },
                */
                token_refs.push(name.into());
                token_refs.push(ellipsis.into());
            }
            TypeInfo::Intersection(ti) => {
                token_refs.extend(ti.extract_token_refs());
            }
            TypeInfo::Union(tu) => {
                token_refs.extend(tu.extract_token_refs());
            }
            TypeInfo::Module {
                module,
                punctuation,
                type_info,
            } => {
                /*
                   /// A type coming from a module, such as `module.Foo`
                   #[display("{module}{punctuation}{type_info}")]
                   Module {
                       /// The module the type is coming from: `module`.
                       module: TokenReference,
                       /// The punctuation (`.`) to index the module.
                       punctuation: TokenReference,
                       /// The indexed type info: `Foo`.
                       type_info: Box<IndexedTypeInfo>,
                   },
                */

                token_refs.push(module.into());
                token_refs.push(punctuation.into());
                token_refs.extend(type_info.extract_token_refs());
            }
            TypeInfo::Optional {
                base,
                question_mark,
            } => {
                /*
                                   /// An optional type, such as `string?`.
                   #[display("{base}{question_mark}")]
                   Optional {
                       /// The type that is optional: `string`.
                       base: Box<TypeInfo>,
                       /// The question mark: `?`.
                       question_mark: TokenReference,
                   },
                */
                token_refs.extend(base.extract_token_refs());
                token_refs.push(question_mark.into());
            }
            /*
            /// A type annotating the structure of a table: { foo: number, bar: string }
            #[display("{}{}{}", braces.tokens().0, fields, braces.tokens().1)]
            Table {
                /// The braces (`{}`) containing the fields.
                braces: ContainedSpan,
                /// The fields: `foo: number, bar: string`.
                fields: Punctuated<TypeField>,
            },
            */
            TypeInfo::Table { braces, fields } => {
                let (start, end) = braces.tokens();
                token_refs.push(start.into());
                token_refs.extend(fields.extract_token_refs());
                token_refs.push(end.into());
            }

            TypeInfo::Typeof {
                typeof_token,
                parentheses,
                inner,
            } => {
                /*
                                   /// A type in the form of `typeof(foo)`.
                   #[display(
                       "{}{}{}{}",
                       typeof_token,
                       parentheses.tokens().0,
                       inner,
                       parentheses.tokens().1
                   )]
                */
                token_refs.push(typeof_token.into());
                let (start, end) = parentheses.tokens();
                token_refs.push(start.into());
                token_refs.extend(inner.extract_token_refs());
                token_refs.push(end.into());
            }

            /*
                /// A tuple expression: `(string, number)`.
               #[display(
                   "{}{}{}",
                   parentheses.tokens().0,
                   types,
                   parentheses.tokens().1
               )]
               Tuple {
                   /// The parentheses used to contain the types
                   parentheses: ContainedSpan,
                   /// The types: `(string, number)`.
                   types: Punctuated<TypeInfo>,
               },
            */
            TypeInfo::Tuple { parentheses, types } => {
                let (start, end) = parentheses.tokens();
                token_refs.push(start.into());
                token_refs.extend(types.extract_token_refs());
                token_refs.push(end.into());
            }
            /*
                /// A variadic type: `...number`.
                #[display("{ellipsis}{type_info}")]
                Variadic {
                    /// The ellipsis: `...`.
                    ellipsis: TokenReference,
                    /// The type that is variadic: `number`.
                    type_info: Box<TypeInfo>,
                },

                /// A variadic type pack: `...T` in `Function<...T>`
                #[display("{ellipsis}{name}")]
                VariadicPack {
                    /// The ellipsis: `...`
                    ellipsis: TokenReference,
                    /// The name of the type that is variadic: `T`
                    name: TokenReference,
                },
            */
            TypeInfo::Variadic {
                type_info,
                ellipsis,
            } => {
                token_refs.push(ellipsis.into());
                token_refs.extend(type_info.extract_token_refs());
            }
            TypeInfo::VariadicPack { ellipsis, name } => {
                token_refs.push(ellipsis.into());
                token_refs.push(name.into());
            }
            _ => todo!(),
        };

        token_refs
    }
}

/*
    /// A name, such as `foo`.
    #[display("{_0}")]
    Name(TokenReference),

    /// An index signature, such as `[number]`.
    #[display("{}{}{}", brackets.tokens().0, inner, brackets.tokens().1)]
*/
impl TokenReferenceExtractor for TypeFieldKey {
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["TypeFieldKey".into()];
        match self {
            TypeFieldKey::Name(name) => {
                token_refs.push(name.into());
            }
            TypeFieldKey::IndexSignature { brackets, inner } => {
                let (start, end) = brackets.tokens();
                token_refs.push(start.into());
                token_refs.extend(inner.extract_token_refs());
                token_refs.push(end.into());
            }
            _ => {}
        }
        token_refs
    }
}

/// Token reference impl for LuauTypeField
impl TokenReferenceExtractor for LuauTypeField {
    // #[display("{}{key}{colon}{value}", display_option(access))]
    fn extract_token_refs(self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["LuauTypeField".into()];

        // Get the access
        if let Some(access) = self.access() {
            token_refs.push(access.into());
        }

        // Get the key
        token_refs.extend(self.key().clone().extract_token_refs());

        // Colon
        token_refs.push(self.colon_token().into());

        // Value
        token_refs.extend(self.value().clone().extract_token_refs());

        token_refs
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
