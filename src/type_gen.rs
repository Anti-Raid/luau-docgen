//#![feature(non_exhaustive_omitted_patterns_lint)]
//#![deny(non_exhaustive_omitted_patterns)]

use crate::token_ref_extractor::TokenReferenceExtractor;
use full_moon::{
    ast::{
        Call, Expression, FunctionArgs, FunctionBody, LocalFunction, Parameter, Prefix, Suffix,
        luau::{
            ExportedTypeDeclaration, GenericDeclaration, GenericParameterInfo, IndexedTypeInfo,
            TypeDeclaration, TypeField as LuauTypeField, TypeFieldKey, TypeInfo,
        },
        punctuated::Pair,
    },
    tokenizer::TokenReference,
    visitors::Visitor,
};
use std::path::PathBuf;
use std::{fmt::Write, rc::Rc};

pub fn extract_name_from_tokenref(token_ref: &TokenReference) -> String {
    // SAFETY: We can discard all the trivia and just get the name
    token_ref.token().to_string()
}

#[derive(Debug, clap::Parser)]
struct CliArgs {
    #[arg(name = "path")]
    /// The path to the script to run
    script: PathBuf,
}

/// A typed argument with an optional name and typ
#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct TypedArgument {
    pub name: Option<String>,
    pub typ: Option<Rc<TypeFieldType>>,
    pub punctuation: Option<String>, // Only for completeness
}

impl TypedArgument {
    /// Returns the string representation of a typed argument
    pub fn string_repr(&self, with_punctuation: bool, is_generic: bool) -> String {
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

        v
    }
}

impl From<(String, Rc<TypeFieldType>)> for TypedArgument {
    fn from(value: (String, Rc<TypeFieldType>)) -> Self {
        TypedArgument {
            name: Some(value.0),
            typ: Some(value.1),
            punctuation: None,
        }
    }
}

impl From<(String, Rc<TypeFieldType>, Option<String>)> for TypedArgument {
    fn from(value: (String, Rc<TypeFieldType>, Option<String>)) -> Self {
        TypedArgument {
            name: Some(value.0),
            typ: Some(value.1),
            punctuation: value.2,
        }
    }
}

impl From<(String, Rc<TypeFieldType>, String)> for TypedArgument {
    fn from(value: (String, Rc<TypeFieldType>, String)) -> Self {
        TypedArgument {
            name: Some(value.0),
            typ: Some(value.1),
            punctuation: Some(value.2),
        }
    }
}

impl From<(Option<String>, Rc<TypeFieldType>)> for TypedArgument {
    fn from(value: (Option<String>, Rc<TypeFieldType>)) -> Self {
        TypedArgument {
            name: value.0,
            typ: Some(value.1),
            punctuation: None,
        }
    }
}

impl From<(Option<String>, Rc<TypeFieldType>, Option<String>)> for TypedArgument {
    fn from(value: (Option<String>, Rc<TypeFieldType>, Option<String>)) -> Self {
        TypedArgument {
            name: value.0,
            typ: Some(value.1),
            punctuation: value.2,
        }
    }
}

impl From<(Option<String>, Rc<TypeFieldType>, String)> for TypedArgument {
    fn from(value: (Option<String>, Rc<TypeFieldType>, String)) -> Self {
        TypedArgument {
            name: value.0,
            typ: Some(value.1),
            punctuation: Some(value.2),
        }
    }
}

impl From<(String, Option<Rc<TypeFieldType>>)> for TypedArgument {
    fn from(value: (String, Option<Rc<TypeFieldType>>)) -> Self {
        TypedArgument {
            name: Some(value.0),
            typ: value.1,
            punctuation: None,
        }
    }
}

impl From<(String, Option<Rc<TypeFieldType>>, Option<String>)> for TypedArgument {
    fn from(value: (String, Option<Rc<TypeFieldType>>, Option<String>)) -> Self {
        TypedArgument {
            name: Some(value.0),
            typ: value.1,
            punctuation: value.2,
        }
    }
}

impl From<(String, Option<Rc<TypeFieldType>>, String)> for TypedArgument {
    fn from(value: (String, Option<Rc<TypeFieldType>>, String)) -> Self {
        TypedArgument {
            name: Some(value.0),
            typ: value.1,
            punctuation: Some(value.2),
        }
    }
}

impl From<(Option<String>, Option<Rc<TypeFieldType>>)> for TypedArgument {
    fn from(value: (Option<String>, Option<Rc<TypeFieldType>>)) -> Self {
        TypedArgument {
            name: value.0,
            typ: value.1,
            punctuation: None,
        }
    }
}

impl From<(Option<String>, Option<Rc<TypeFieldType>>, Option<String>)> for TypedArgument {
    fn from(value: (Option<String>, Option<Rc<TypeFieldType>>, Option<String>)) -> Self {
        TypedArgument {
            name: value.0,
            typ: value.1,
            punctuation: value.2,
        }
    }
}

impl From<(Option<String>, Option<Rc<TypeFieldType>>, String)> for TypedArgument {
    fn from(value: (Option<String>, Option<Rc<TypeFieldType>>, String)) -> Self {
        TypedArgument {
            name: value.0,
            typ: value.1,
            punctuation: Some(value.2),
        }
    }
}

/// Inner data of a Generic TypeFieldType
///
/// A type using generics, such as map<number, string>.
#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct TypeFieldTypeGeneric {
    pub base: String,
    pub generics: Vec<Rc<TypeFieldType>>,
}

impl TypeFieldTypeGeneric {
    /// String representation of the generic type
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
    }
}

/// A type coming from a module, such as module.Foo
#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct TypeFieldTypeModule {
    pub module: String,
    pub base: String,
    pub generics: Option<Vec<Rc<TypeFieldType>>>,
}

impl TypeFieldTypeModule {
    /// String representation of the module type
    ///
    /// @public_api
    pub fn string_repr(&self) -> String {
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
    }
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

impl TypeFieldTypeFunction {
    /// String representation of the module type
    ///
    /// @public_api
    pub fn string_repr(&self) -> String {
        let args_str = self
            .args
            .iter()
            .map(|arg| arg.string_repr(false, false))
            .collect::<Vec<_>>()
            .join(", ");

        let generics_str = self
            .generics
            .iter()
            .map(|arg| arg.string_repr(false, true))
            .collect::<Vec<_>>()
            .join(", ");

        let mut repr = String::new();

        if !generics_str.is_empty() {
            write!(repr, "<{}>", generics_str).expect("Failed to write generics to string");
        }

        write!(repr, "({}) -> {}", args_str, self.ret.string_repr(1))
            .expect("Failed to write function to string");

        repr
    }
}

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
    /// Recursively find the inner set of types that compose/make up a TypeFieldType
    ///
    /// @public_api
    pub fn unwind(&self) -> Vec<Rc<TypeFieldType>> {
        match self {
            TypeFieldType::Array(inner) => inner.unwind(),
            TypeFieldType::Variadic(inner) => inner.unwind(),
            TypeFieldType::Optional(inner) => inner.unwind(),
            TypeFieldType::Union(types) => types.iter().flat_map(|t| t.unwind()).collect(),
            TypeFieldType::Intersection(types) => types.iter().flat_map(|t| t.unwind()).collect(),
            TypeFieldType::Tuple(types) => types.iter().flat_map(|t| t.unwind()).collect(),
            _ => vec![self.clone().into()],
        }
    }

    /// Returns the string representation of a type field type
    ///
    /// @public_api
    pub fn string_repr(&self, depth: usize) -> String {
        match self {
            TypeFieldType::Basic(name) => name.clone(),
            TypeFieldType::String(name) => name.clone(),
            TypeFieldType::Boolean(name) => name.to_string(),
            TypeFieldType::Array(inner) => format!("{{{}}}", inner.string_repr(depth)),
            TypeFieldType::Variadic(inner) => format!("...{}", inner.string_repr(depth)),
            TypeFieldType::Generic(generic_field_type) => generic_field_type.string_repr(),
            TypeFieldType::GenericPack(name) => name.clone(),
            TypeFieldType::Module(tftm) => tftm.string_repr(),
            TypeFieldType::UnknownModule(name) => name.clone(),
            TypeFieldType::TypeOf(contents) => contents.clone(),
            TypeFieldType::Optional(inner) => format!("{}?", inner.string_repr(depth)),
            TypeFieldType::Function(func) => func.string_repr(),
            TypeFieldType::Table(fields) => {
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
            }
            TypeFieldType::Tuple(types) => {
                let types_str = types
                    .iter()
                    .map(|t| t.string_repr(depth))
                    .collect::<Vec<_>>()
                    .join(", ");
                format!("({})", types_str)
            }
            TypeFieldType::VariadicPack(inner) => format!("...{}", inner),
            TypeFieldType::Union(types) => {
                let types_str = types
                    .iter()
                    .map(|t| t.string_repr(depth))
                    .collect::<Vec<_>>()
                    .join(" | ");
                types_str
            }
            TypeFieldType::Intersection(types) => {
                let types_str = types
                    .iter()
                    .map(|t| t.string_repr(depth))
                    .collect::<Vec<_>>()
                    .join(" & ");
                types_str
            }
        }
    }

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
                    let Some((name, punctuation)) = arg.name() else {
                        args.push(
                            (
                                None,
                                TypeFieldType::from_luau_typeinfo(tbv, arg.type_info()),
                                None,
                            )
                                .into(),
                        );
                        continue;
                    };

                    let name = extract_name_from_tokenref(name);
                    let typ = TypeFieldType::from_luau_typeinfo(tbv, arg.type_info());
                    args.push((Some(name), typ, punctuation.to_string()).into());
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

/// Originates from a LuauTypeField: A type field used within table types. The foo: number in { foo: number }.
#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct TypeField {
    /// The string representation of the type field
    pub repr: String,
    /// The comments associated with the type field
    pub comments: Vec<String>,
    /// The name of the field
    pub field_name: String,
    /// The type of the field
    pub field_type: Rc<TypeFieldType>,
}

impl TypeField {
    /// Given a LuauTypeField, convert it to a TypeField
    pub fn from_luau_type_field(tbv: &mut TypeBlockVisitor, typ_field: &LuauTypeField) -> Rc<Self> {
        let key = match typ_field.key() {
            TypeFieldKey::Name(name) => extract_name_from_tokenref(name),
            TypeFieldKey::IndexSignature { brackets, inner } => {
                let (start_bracket, end_bracket) = brackets.tokens();
                format!(
                    "{}{}{}",
                    extract_name_from_tokenref(start_bracket),
                    TypeFieldType::from_luau_typeinfo(tbv, inner).string_repr(1),
                    extract_name_from_tokenref(end_bracket)
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

        let comments = tbv.get_surrounding_trivia_for_node(typ_field);

        let type_info = TypeFieldType::from_luau_typeinfo(tbv, value);

        Self {
            repr: typ_field.to_string(),
            comments,
            field_name: key,
            field_type: type_info,
        }
        .into()
    }

    /// Returns the string representation of the type at a given depth with default patterns
    ///
    /// @public_api
    pub fn string_repr(&self, depth: usize) -> String {
        self.string_repr_with_pats("\n\t", depth)
    }

    /// @public_api
    pub fn string_repr_with_pats(&self, comment_write_pat: &str, depth: usize) -> String {
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
    }
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub enum FunctionType {
    Local,
    Normal,
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct TypeDefTypeTypeofSetMetatable {
    /// The fields of the type
    pub fields: Vec<Rc<TypeField>>,
    /// The fields of the types metatable
    pub metatable_fields: Vec<Rc<TypeField>>,
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub enum TypeDefType {
    /// type T = { ... }
    Table { fields: Vec<Rc<TypeField>> },
    /// typeof(setmetatable) is so common, its a special type
    TypeOfSetMetatable {
        type_info: TypeDefTypeTypeofSetMetatable,
    },
    /// Anything else
    Uncategorized { type_info: Rc<TypeFieldType> },
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct TypeDef {
    /// The name of the type
    pub name: String,
    /// The generics of the function
    pub generics: Vec<TypedArgument>,
    /// The comments associated with the type
    pub type_comments: Vec<String>,
    /// The type of the type
    pub type_def_type: TypeDefType,
    /// The string representation of the type
    pub repr: String,
}

impl TypeDef {
    /// Returns the *constructed* string representation of the type. This usually looks better than the raw representation
    /// with a more standardized layout and format
    ///
    /// @public_api
    pub fn string_repr(&self) -> String {
        self.string_repr_with_pats(",\n\t", ", ")
    }

    /// Returns the *constructed* string representation of the type with applied transformations
    ///
    /// @public_api
    pub fn string_repr_with_pats(&self, fields_join_pat: &str, generics_join_pat: &str) -> String {
        let mut repr = String::new();
        for comment in self.type_comments.iter() {
            writeln!(repr, "--{}", comment).expect("Failed to write comment to string");
        }

        write!(repr, "type {}", self.name).expect("Failed to write type name to repr");

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

        repr.push_str(" = ");

        match &self.type_def_type {
            TypeDefType::Table { fields } => {
                if fields.is_empty() {
                    repr.push_str("{}");
                } else {
                    let fields_str = fields
                        .iter()
                        .map(|f| f.string_repr(1))
                        .collect::<Vec<_>>()
                        .join(fields_join_pat);

                    write!(repr, "{{\n\t{}\n}}", fields_str)
                        .expect("Failed to write type to string");
                }
            }
            TypeDefType::TypeOfSetMetatable { type_info } => {
                let mut fields_str = type_info
                    .fields
                    .iter()
                    .map(|f| f.string_repr(1))
                    .collect::<Vec<_>>()
                    .join(fields_join_pat);

                fields_str.push_str(",\n\n\t-- Metatable\n\t");

                let metatable_fields_str = type_info
                    .metatable_fields
                    .iter()
                    .map(|f| f.string_repr(1))
                    .collect::<Vec<_>>()
                    .join(",\n\t");

                fields_str.push_str(&metatable_fields_str);

                write!(repr, "{{\n\t{}\n}}", fields_str).expect("Failed to write type to string");
            }
            TypeDefType::Uncategorized { type_info } => {
                write!(repr, "{}", type_info.string_repr(1),)
                    .expect("Failed to write type to string");
            }
        }

        repr
    }
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct TypeFunction {
    /// The name of the function
    pub name: String,
    /// String representation of the function declaration
    pub repr: String,
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

impl TypeFunction {
    /// Returns the *constructed* string representation of the type. This usually looks better than the raw representation
    /// with a more standardized layout and format
    ///
    /// @public_api
    pub fn string_repr(&self) -> String {
        self.string_repr_with_pats(", ", ", ")
    }

    /// Returns the *constructed* string representation of the type with applied transformations
    ///
    /// @public_api
    pub fn string_repr_with_pats(&self, args_join_pat: &str, generics_join_pat: &str) -> String {
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
    }
}

/// A type container
///
/// This is an Rc to make it cheap to clone
#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub enum Type {
    TypeDef {
        /// The inner type definition
        inner: Rc<TypeDef>,
    },
    Function {
        inner: Rc<TypeFunction>,
    },
}

impl Type {
    /// Returns the name of the type
    pub fn name(&self) -> &str {
        match self {
            Type::TypeDef { inner } => inner.name.as_ref(),
            Type::Function { inner, .. } => inner.name.as_ref(),
        }
    }

    /// Returns the comments associated with the type
    pub fn type_comments(&self) -> Vec<String> {
        match self {
            Type::TypeDef { inner } => inner
                .type_comments
                .iter()
                .map(|s| s.trim().to_string())
                .collect(),
            Type::Function { inner } => inner
                .type_comments
                .iter()
                .map(|s| s.trim().to_string())
                .collect(),
        }
    }

    /// Returns the *constructed* string representation of the type. This usually looks better than the raw representation
    /// with a more standardized layout and format
    ///
    /// @public_api
    pub fn string_repr(&self) -> String {
        self.string_repr_with_pats(",\n\t", ", ", ", ")
    }

    /// Returns the *constructed* string representation of the type with applied transformations
    ///
    /// @public_api
    pub fn string_repr_with_pats(
        &self,
        fields_join_pat: &str,
        args_join_pat: &str,
        generics_join_pat: &str,
    ) -> String {
        match self {
            Type::TypeDef { inner } => {
                inner.string_repr_with_pats(fields_join_pat, generics_join_pat)
            }
            Type::Function { inner } => {
                inner.string_repr_with_pats(args_join_pat, generics_join_pat)
            }
        }
    }

    /// Returns the raw (normally unmodified) string representation of the type
    pub fn raw_repr(&self) -> String {
        match self {
            Type::TypeDef { inner } => inner.repr.clone(),
            Type::Function { inner } => inner.repr.clone(),
        }
    }
}

#[derive(Default, Debug, Clone)]
pub struct TypeBlockVisitor {
    pub found_types: Vec<Type>,
    pub include_nonexported_types: bool,
    pub unsupported_count: usize,

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

            generics.push((name, default_type).into());
        }

        generics
    }

    pub fn create_type_from_function<T: TokenReferenceExtractor>(
        &mut self,
        node: &T,
        name: String,
        body: &FunctionBody,
        function_type: FunctionType,
    ) -> Type {
        // Extract comments
        let comments = self.get_surrounding_trivia_for_node(node);

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
            args.push((Some(param), typ).into());
        }

        // Get the return type
        let ret = body
            .return_type()
            .map(|typ| TypeFieldType::from_luau_typeinfo(self, typ.type_info()));

        // Create the type
        Type::Function {
            inner: TypeFunction {
                name,
                repr: {
                    let tokens = self.extract_till_tag(node, "Block");

                    let mut repr = String::new();
                    for token in tokens {
                        write!(repr, "{}", token).expect("Failed to write to string");
                    }
                    write!(repr, "{}", body.end_token().token())
                        .expect("Failed to write end token to string");
                    repr.trim_start_matches('\n').to_string()
                },
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
    ) -> Option<Type> {
        // Get type repr
        let type_repr = node.to_string();

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
                        repr: type_repr,
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
                                        repr: type_repr,
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
                repr: type_repr,
            }
            .into(),
        })
    }

    // Gets surrounding trivia for nodes using two different implementations
    pub fn get_surrounding_trivia_for_node<T: TokenReferenceExtractor>(
        &self,
        node: &T,
    ) -> Vec<String> {
        let instant_now = std::time::Instant::now();
        let comments = TokenReferenceExtractor::get_surrounding_trivia(node);
        let elapsed_n = instant_now.elapsed();

        log::trace!("Elapsed: {:?}", elapsed_n.as_micros());

        comments
    }

    /// Extract till tag using two different implementations
    pub fn extract_till_tag<'a, T: TokenReferenceExtractor>(
        &self,
        node: &'a T,
        tag: &str,
    ) -> Vec<&'a TokenReference> {
        let instant_now = std::time::Instant::now();
        let tokens = TokenReferenceExtractor::extract_till_tag(node, tag);
        let elapsed_n = instant_now.elapsed();

        log::trace!(
            "Elapsed: {:?} (v1) [extract_till_tag]",
            elapsed_n.as_micros(),
        );

        tokens
    }
}

impl Visitor for TypeBlockVisitor {
    fn visit_function_declaration(&mut self, node: &full_moon::ast::FunctionDeclaration) {
        let node_names = node.name().to_string();
        let typ =
            self.create_type_from_function(node, node_names, node.body(), FunctionType::Normal);
        self.found_types.push(typ);
    }

    fn visit_local_function(&mut self, node: &LocalFunction) {
        let node_name = extract_name_from_tokenref(node.name());
        let typ = self.create_type_from_function(node, node_name, node.body(), FunctionType::Local);
        self.found_types.push(typ);
    }

    fn visit_exported_type_declaration(&mut self, node: &ExportedTypeDeclaration) {
        let Some(typ) = self.create_type_from_type_decl(
            self.get_surrounding_trivia_for_node(node),
            node.type_declaration(),
        ) else {
            return;
        };
        self.last_typedef = Some(extract_name_from_tokenref(
            node.type_declaration().type_name(),
        )); // Mark the last typedef. Duplication can't happen in the exported type declaration case sooo
        self.found_types.push(typ);
    }

    fn visit_type_declaration(&mut self, node: &TypeDeclaration) {
        if self.include_nonexported_types {
            let type_name = extract_name_from_tokenref(node.type_name());

            // Ensure we don't duplicate typedefs
            if let Some(last_typedef) = &self.last_typedef {
                if *last_typedef == type_name {
                    return;
                }
            }

            self.last_typedef = Some(type_name);
            let Some(typ) =
                self.create_type_from_type_decl(self.get_surrounding_trivia_for_node(node), node)
            else {
                return;
            };

            self.found_types.push(typ);
        }
    }
}
