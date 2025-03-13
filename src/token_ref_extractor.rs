//! Accurately extract token references from AST nodes

use full_moon::ast::{
    BinOp, LocalFunction, UnOp,
    luau::{
        ElseIfExpression, IfExpression, InterpolatedString, InterpolatedStringSegment,
        TypeAssertion, TypeDeclaration,
    },
};
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
    },
    tokenizer::{TokenReference, TokenType},
};

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

pub enum TaggedTokenReference<'a> {
    Ref {
        token_ref: &'a TokenReference,
    },
    Punctuated,
    PairPunctuated,
    PairEnd,

    #[allow(dead_code)]
    Tag {
        tag: String,
    },
}

impl<'a> From<&'a TokenReference> for TaggedTokenReference<'a> {
    fn from(token_ref: &'a TokenReference) -> Self {
        Self::Ref { token_ref }
    }
}

impl From<&str> for TaggedTokenReference<'_> {
    fn from(tag: &str) -> Self {
        Self::Tag {
            tag: tag.to_string(),
        }
    }
}

/// Abstraction to extract token references from compatible types
pub trait TokenReferenceExtractor {
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference>;

    fn get_surrounding_trivia(&self) -> Vec<String> {
        let token_refs = self.extract_token_refs();

        let mut comments = Vec::new();

        for token_ref in token_refs {
            match token_ref {
                TaggedTokenReference::Ref { token_ref } => {
                    let trivia = get_comments_from_token_ref(token_ref);
                    comments.extend(trivia);
                }
                TaggedTokenReference::Tag { .. } => {}
                _ => break,
            }
        }

        comments
    }

    fn extract_till_tag(&self, tag: &str) -> Vec<&TokenReference> {
        let token_refs = self.extract_token_refs();

        let mut tagged_refs = Vec::new();

        for token_ref in token_refs {
            match token_ref {
                TaggedTokenReference::Tag { tag: t } => {
                    if t == tag {
                        break;
                    }
                }
                TaggedTokenReference::Ref { token_ref } => tagged_refs.push(token_ref),
                _ => continue,
            }
        }

        tagged_refs
    }
}

/// All tokenreferences are token references
impl TokenReferenceExtractor for TokenReference {
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        vec![self.into()]
    }
}

/// Vec impl
impl<T: TokenReferenceExtractor> TokenReferenceExtractor for Vec<T> {
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = Vec::with_capacity(self.len());
        for item in self {
            token_refs.extend(item.extract_token_refs());
        }
        token_refs
    }
}

/// Pair impl
impl<T: TokenReferenceExtractor> TokenReferenceExtractor for Pair<T> {
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec![TaggedTokenReference::Punctuated];
        for pair in self.pairs() {
            token_refs.extend(pair.extract_token_refs());
        }
        token_refs
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["GenericDeclarationParameter".into()];
        token_refs.extend(self.parameter().extract_token_refs());
        if let Some(equals) = self.equals() {
            token_refs.push(equals.into());
        }
        if let Some(default_type) = self.default_type() {
            token_refs.extend(default_type.extract_token_refs());
        }
        token_refs
    }
}

impl TokenReferenceExtractor for GenericDeclaration {
    //#[display("{}{}{}", arrows.tokens().0, generics, arrows.tokens().1)]
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["GenericDeclaration".into()];
        let (start, end) = self.arrows().tokens();
        token_refs.push(start.into());
        token_refs.extend(self.generics().extract_token_refs());
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["TypeIntersection".into()];
        if let Some(leading) = self.leading() {
            token_refs.push(leading.into());
        }

        token_refs.extend(self.types().extract_token_refs());
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["TypeUnion".into()];
        if let Some(leading) = self.leading() {
            token_refs.push(leading.into());
        }

        token_refs.extend(self.types().extract_token_refs());
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
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
            token_refs.extend(self.type_info().extract_token_refs());
        } else {
            token_refs.extend(self.type_info().extract_token_refs());
        }

        token_refs
    }
}

impl TokenReferenceExtractor for Parameter {
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["TypeSpecifier".into()];
        token_refs.push(self.punctuation().into());
        token_refs.extend(self.type_info().extract_token_refs());
        token_refs
    }
}

impl TokenReferenceExtractor for Return {
    /*
        #[display("{token}{returns}")]
        pub struct Return {
    */
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["Return".into()];
        token_refs.push(self.token().into());
        token_refs.extend(self.returns().extract_token_refs());
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["TableConstructor".into()];
        let (start, end) = self.braces().tokens();
        token_refs.push(start.into());
        token_refs.extend(self.fields().extract_token_refs());
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs: Vec<TaggedTokenReference<'_>> = Vec::new();
        token_refs.extend(self.prefix().extract_token_refs());
        for suffix in self.suffixes() {
            token_refs.extend(suffix.extract_token_refs());
        }
        token_refs
    }
}

/*
/// A method call, such as `x:y()`
#[cfg_attr(feature = "serde", derive(Deserialize, Serialize))]
#[display("{colon_token}{name}{args}")]
pub struct MethodCall {
 */
impl TokenReferenceExtractor for MethodCall {
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["MethodCall".into()];
        token_refs.push(self.colon_token().into());
        token_refs.push(self.name().into());
        token_refs.extend(self.args().extract_token_refs());
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
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

impl TokenReferenceExtractor for Index {
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = Vec::new();
        token_refs.extend(self.prefix().extract_token_refs());
        for suffix in self.suffixes() {
            token_refs.extend(suffix.extract_token_refs());
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        // #[display("{var_list}{equal_token}{expr_list}")]
        let mut token_refs = vec!["Assignment".into()];
        token_refs.extend(self.variables().extract_token_refs());
        token_refs.push(self.equal_token().into());
        token_refs.extend(self.expressions().extract_token_refs());
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["Block".into()];
        for (stmt, token_ref) in self.stmts_with_semicolon() {
            // First push stmt
            token_refs.extend(stmt.extract_token_refs());
            // Then push the semicolon
            if let Some(token_ref) = token_ref {
                token_refs.push(token_ref.into());
            }
        }

        if let Some((last_stmt, last_token_ref)) = self.last_stmt_with_semicolon() {
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["FunctionName".into()];
        token_refs.extend(self.names().extract_token_refs());
        if let Some(method_colon) = self.method_colon() {
            token_refs.push(method_colon.into());
        }
        if let Some(method_name) = self.method_name() {
            token_refs.push(method_name.into());
        }
        token_refs
    }
}

impl TokenReferenceExtractor for GenericFor {
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
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
                token_refs.extend(type_specifier.extract_token_refs());
            }
            if let Some(punctuation) = parameter.punctuation() {
                token_refs.push(punctuation.into());
            }
        }

        // In token
        token_refs.push(self.in_token().into());

        // Expression list
        token_refs.extend(self.expressions().extract_token_refs());

        // Do token
        token_refs.push(self.do_token().into());

        // Block
        token_refs.extend(self.block().extract_token_refs());

        // End token
        token_refs.push(self.end_token().into());

        token_refs
    }
}

/*#[display("{do_token}{block}{end_token}")]
pub struct Do {
*/
impl TokenReferenceExtractor for Do {
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["Do".into()];
        token_refs.push(self.do_token().into());
        token_refs.extend(self.block().extract_token_refs());
        token_refs.push(self.end_token().into());
        token_refs
    }
}

/*
#[cfg_attr(feature = "luau", display("{function_token}{name}{body}"))]
pub struct FunctionDeclaration {
 */
impl TokenReferenceExtractor for FunctionDeclaration {
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["FunctionDeclaration".into()];
        token_refs.push(self.function_token().into());
        token_refs.extend(self.name().extract_token_refs());
        token_refs.extend(self.body().extract_token_refs());
        token_refs
    }
}

impl TokenReferenceExtractor for Stmt {
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        vec![] // Not needed for now. TODO if needed
    }
}

impl TokenReferenceExtractor for FunctionBody {
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["FunctionBody".into()];
        if let Some(generics) = self.generics() {
            token_refs.extend(generics.extract_token_refs());
        }
        let (start, end) = self.parameters_parentheses().tokens();
        token_refs.push(start.into());

        for (param, typ_info) in self.parameters().pairs().zip(
            self.type_specifiers()
                .chain(std::iter::repeat_with(|| None)),
        ) {
            token_refs.extend(param.value().extract_token_refs());
            if let Some(typ_info) = typ_info {
                token_refs.extend(typ_info.extract_token_refs());
            }
            if let Some(punctuation) = param.punctuation() {
                token_refs.push(punctuation.into());
            }
        }

        token_refs.push(end.into());
        if let Some(return_type) = self.return_type() {
            token_refs.extend(return_type.extract_token_refs());
        }
        token_refs.extend(self.block().extract_token_refs());
        token_refs.push(self.end_token().into());

        token_refs
    }
}

impl TokenReferenceExtractor for LocalFunction {
    // #[cfg_attr(feature = "luau", display("{local_token}{function_token}{name}{body}"))]
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["LocalFunction".into()];
        token_refs.push(self.local_token().into());
        token_refs.push(self.function_token().into());
        token_refs.push(self.name().into());
        token_refs.extend(self.body().extract_token_refs());
        token_refs
    }
}

impl TokenReferenceExtractor for TypeAssertion {
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["TypeAssertion".into()];
        token_refs.push(self.assertion_op().into());
        token_refs.extend(self.cast_to().extract_token_refs());
        token_refs
    }
}

impl TokenReferenceExtractor for BinOp {
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        vec!["BinOp".into(), self.token().into()]
    }
}

impl TokenReferenceExtractor for UnOp {
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        vec!["UnOp".into(), self.token().into()]
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["IfExpression".into()];
        token_refs.push(self.if_token().into());
        token_refs.extend(self.condition().extract_token_refs());
        token_refs.push(self.then_token().into());
        token_refs.extend(self.if_expression().extract_token_refs());
        if let Some(else_if_expressions) = self.else_if_expressions() {
            token_refs.extend(else_if_expressions.extract_token_refs());
        }
        token_refs.push(self.else_token().into());
        token_refs.extend(self.else_expression().extract_token_refs());

        token_refs
    }
}

/*
#[display("{else_if_token}{condition}{then_token}{expression}")]
pub struct ElseIfExpression {
 */
impl TokenReferenceExtractor for ElseIfExpression {
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["ElseIfExpression".into()];
        token_refs.push(self.else_if_token().into());
        token_refs.extend(self.condition().extract_token_refs());
        token_refs.push(self.then_token().into());
        token_refs.extend(self.expression().extract_token_refs());

        token_refs
    }
}

/*
#[display("{literal}{expression}")]
pub struct InterpolatedStringSegment {
 */
impl TokenReferenceExtractor for InterpolatedStringSegment {
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["InterpolatedStringSegment".into()];
        token_refs.push((&self.literal).into());
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["InterpolatedString".into()];
        for segment in self.segments() {
            token_refs.extend(segment.extract_token_refs());
        }
        token_refs.push(self.last_string().into());
        token_refs
    }
}

impl TokenReferenceExtractor for Expression {
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
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
                token_refs.push((&func.0).into());
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
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
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["LuauTypeField".into()];

        // Get the access
        if let Some(access) = self.access() {
            token_refs.push(access.into());
        }

        // Get the key
        token_refs.extend(self.key().extract_token_refs());

        // Colon
        token_refs.push(self.colon_token().into());

        // Value
        token_refs.extend(self.value().extract_token_refs());

        token_refs
    }
}

impl TokenReferenceExtractor for TypeDeclaration {
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        /*
                #[display(
            "{}{}{}{}{}",
            type_token,
            base,
            display_option(generics),
            equal_token,
            declare_as
        )]
        */

        let mut token_refs = vec!["TypeDeclaration".into()];
        token_refs.push(self.type_token().into());
        token_refs.push(self.type_name().into());
        if let Some(generics) = self.generics() {
            token_refs.extend(generics.extract_token_refs());
        }
        token_refs.push(self.equal_token().into());
        token_refs.extend(self.type_definition().extract_token_refs());

        token_refs
    }
}

impl TokenReferenceExtractor for ExportedTypeDeclaration {
    fn extract_token_refs(&self) -> Vec<TaggedTokenReference> {
        let mut token_refs = vec!["ExportedTypeDeclaration".into()];
        token_refs.push(self.export_token().into());
        token_refs.extend(self.type_declaration().extract_token_refs());
        token_refs
    }
}
