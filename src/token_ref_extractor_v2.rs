use full_moon::{
    ast::{
        Assignment, BinOp, Block, Call, Expression, Field, FunctionArgs, FunctionBody,
        FunctionCall, FunctionDeclaration, FunctionName, Index, LastStmt, LocalFunction,
        MethodCall, Parameter, Prefix, Return, Stmt, Suffix, TableConstructor, UnOp, Var,
        VarExpression,
        luau::{
            ElseIfExpression, ExportedTypeDeclaration, GenericDeclaration,
            GenericDeclarationParameter, GenericParameterInfo, IfExpression, IndexedTypeInfo,
            InterpolatedString, InterpolatedStringSegment, TypeArgument, TypeAssertion,
            TypeDeclaration, TypeField, TypeFieldKey, TypeInfo, TypeIntersection, TypeSpecifier,
            TypeUnion,
        },
        punctuated::{Pair, Punctuated},
    },
    tokenizer::{TokenReference, TokenType},
};

use mlua::prelude::LuaEither as Either;

/// From https://stackoverflow.com/questions/49455885/chain-two-iterators-while-lazily-constructing-the-second-one
///
/// Chains two iterators lazily
trait IteratorExt: Iterator {
    fn chain_with<F, I>(self, f: F) -> ChainWith<Self, F, I::IntoIter>
    where
        Self: Sized,
        F: FnOnce() -> I,
        I: IntoIterator<Item = Self::Item>,
    {
        ChainWith {
            base: self,
            factory: Some(f),
            iterator: None,
        }
    }
}

impl<I: Iterator> IteratorExt for I {}

struct ChainWith<B, F, I> {
    base: B,
    factory: Option<F>,
    iterator: Option<I>,
}

impl<B, F, I> Iterator for ChainWith<B, F, I::IntoIter>
where
    B: Iterator,
    F: FnOnce() -> I,
    I: IntoIterator<Item = B::Item>,
{
    type Item = I::Item;
    fn next(&mut self) -> Option<Self::Item> {
        if let Some(b) = self.base.next() {
            return Some(b);
        }

        // Exhausted the first, generate the second

        if let Some(f) = self.factory.take() {
            self.iterator = Some(f().into_iter());
        }

        self.iterator
            .as_mut()
            .expect("There must be an iterator")
            .next()
    }
}

fn get_comments_from_token_ref(token_ref: &TokenReference) -> Vec<String> {
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

pub enum TriIterator<T, U, V> {
    A(T),
    B(U),
    C(V),
}

impl<T: Iterator, U: Iterator<Item = T::Item>, V: Iterator<Item = T::Item>> Iterator
    for TriIterator<T, U, V>
{
    type Item = T::Item;

    fn next(&mut self) -> Option<T::Item> {
        match self {
            Self::A(t) => t.next(),
            Self::B(t) => t.next(),
            Self::C(t) => t.next(),
        }
    }
}

/// Abstraction to extract token references from compatible types
///
/// This should be (maybe?) faster than v1 of token reference extractor and safer too.
pub trait TokenReferenceExtractor: Clone {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)>;

    fn get_surrounding_trivia(&self) -> Vec<String> {
        let mut comments = Vec::new();

        for (token_ref, tag) in self.extract_token_refs() {
            /*println!(
                "Tag: {}, token: {:?}",
                tag,
                token_ref.map(|t| t.to_string())
            );*/

            if ["Punctuated", "PairPunctuated", "PairEnd"].contains(&tag) {
                break; // Useful heuristic to avoid getting comments from the entire segment, TODO: Replace this with something better
            }

            let Some(token_ref) = token_ref else {
                continue;
            };
            let trivia = get_comments_from_token_ref(token_ref);
            comments.extend(trivia);
        }

        comments
    }

    fn extract_till_tag(&self, tag: &str) -> Vec<&TokenReference> {
        let token_refs = self.extract_token_refs();

        let mut tagged_refs = Vec::new();

        for (token_ref, p_tag) in token_refs {
            let Some(token_ref) = token_ref else {
                continue;
            };

            if p_tag == tag {
                break;
            }

            tagged_refs.push(token_ref);
        }

        tagged_refs
    }
}

impl TokenReferenceExtractor for TokenReference {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        std::iter::once((Some(self), "TokenReference"))
    }
}

impl TokenReferenceExtractor for &TokenReference {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        std::iter::once((Some(*self), "TokenReference"))
    }
}

/// Vec impl
impl<T: TokenReferenceExtractor> TokenReferenceExtractor for Vec<T> {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        self.iter().flat_map(|item| item.extract_token_refs())
    }
}

/// Pair impl
impl<T: TokenReferenceExtractor> TokenReferenceExtractor for Pair<T> {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        /*
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
        */

        match self {
            Pair::Punctuated(item, token_ref) => Either::Left(
                std::iter::once((token_ref.into(), "PairPunctuated"))
                    .chain(item.extract_token_refs()),
            ),
            Pair::End(item) => {
                Either::Right(std::iter::once((None, "PairEnd")).chain(item.extract_token_refs()))
            }
        }
    }
}

/// Punctuated impl
impl<T: TokenReferenceExtractor> TokenReferenceExtractor for Punctuated<T> {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        std::iter::once((None, "Punctuated"))
            .chain_with(|| self.pairs().flat_map(|p| p.extract_token_refs()))
    }
}

/*
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
 */
impl TokenReferenceExtractor for GenericParameterInfo {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        match self {
            GenericParameterInfo::Name(name) => {
                Either::Left(std::iter::once((name.into(), "GenericParameterInfo")))
            }
            GenericParameterInfo::Variadic { name, ellipsis } => Either::Right(
                std::iter::once((name.into(), "GenericParameterInfo"))
                    .chain([(ellipsis.into(), "GenericParameterInfo")]),
            ),
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
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        /*
        let mut token_refs = vec!["GenericDeclarationParameter".into()];
        token_refs.extend(self.parameter().clone().extract_token_refs());
        if let Some(equals) = self.equals() {
            token_refs.push(equals.into());
        }
        if let Some(default_type) = self.default_type() {
            token_refs.extend(default_type.clone().extract_token_refs());
        }
        token_refs
         */

        std::iter::once((None, "GenericDeclarationParameter")).chain_with(|| {
            self.parameter()
                .extract_token_refs()
                .chain_with(|| {
                    self.equals()
                        .into_iter()
                        .flat_map(|t| std::iter::once((Some(t), "GenericDeclarationParameter")))
                })
                .chain_with(|| {
                    self.default_type()
                        .into_iter()
                        .flat_map(|t| t.extract_token_refs())
                })
        })
    }
}

impl TokenReferenceExtractor for GenericDeclaration {
    //#[display("{}{}{}", arrows.tokens().0, generics, arrows.tokens().1)]
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        std::iter::once((None, "GenericDeclaration"))
            .chain_with(|| std::iter::once((Some(self.arrows().tokens().0), "GenericDeclaration")))
            .chain_with(|| self.generics().extract_token_refs())
            .chain_with(|| std::iter::once((Some(self.arrows().tokens().1), "GenericDeclaration")))
    }
}

impl TokenReferenceExtractor for TypeIntersection {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        self.leading()
            .into_iter()
            .flat_map(|t| std::iter::once((Some(t), "TypeIntersection")))
            .chain_with(|| self.types().extract_token_refs())
    }
}

impl TokenReferenceExtractor for TypeUnion {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        self.leading()
            .into_iter()
            .flat_map(|t| std::iter::once((Some(t), "TypeUnion")))
            .chain_with(|| self.types().extract_token_refs())
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
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        match self {
            IndexedTypeInfo::Basic(basic_type) => {
                Either::Left(std::iter::once((Some(basic_type), "IndexedTypeInfo")))
            }
            IndexedTypeInfo::Generic {
                base,
                arrows,
                generics,
            } => Either::Right(
                std::iter::once((Some(arrows.tokens().0), "IndexedTypeInfo"))
                    .chain_with(move || std::iter::once((Some(base), "IndexedTypeInfo")))
                    .chain_with(|| generics.extract_token_refs())
                    .chain_with(|| std::iter::once((Some(arrows.tokens().1), "IndexedTypeInfo")))
                    .chain_with(|| std::iter::once((Some(arrows.tokens().1), "IndexedTypeInfo"))),
            ),
            _ => todo!(),
        }
    }
}

impl TokenReferenceExtractor for TypeArgument {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        /*
        if let Some((identifier, punctuation)) = self.name() {
            write!(formatter, "{}{}{}", identifier, punctuation, self.type_info)
        } else {
            write!(formatter, "{}", self.type_info)
        }
         */
        std::iter::once((None, "TypeArgument")).chain_with(|| {
            self.name()
                .into_iter()
                .flat_map(|(identifier, punctuation)| {
                    std::iter::once((Some(identifier), "TypeArgument"))
                        .chain(std::iter::once((Some(punctuation), "TypeArgument")))
                })
                .chain_with(|| self.type_info().extract_token_refs())
        })
    }
}

impl TokenReferenceExtractor for Parameter {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        match self {
            Parameter::Name(tr) | Parameter::Ellipsis(tr) => {
                std::iter::once((Some(tr), "Parameter"))
            }
            _ => todo!(),
        }
    }
}

/*
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
*/
impl TokenReferenceExtractor for TypeInfo {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        let iter: Box<dyn Iterator<Item = (Option<&TokenReference>, &'static str)>> = match self {
            TypeInfo::Array {
                braces,
                access,
                type_info,
            } => Box::new(
                std::iter::once((Some(braces.tokens().0), "TypeInfo"))
                    .chain_with(|| access.iter().map(|t| (Some(t), "TypeInfo")))
                    .chain_with(|| type_info.extract_token_refs())
                    .chain_with(|| std::iter::once((Some(braces.tokens().1), "TypeInfo"))),
            ),
            TypeInfo::Basic(tr) | TypeInfo::String(tr) | TypeInfo::Boolean(tr) => {
                Box::new(std::iter::once((Some(tr), "TypeInfo")))
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
                Box::new(
                    generics
                        .iter()
                        .flat_map(|t| t.extract_token_refs())
                        .chain_with(|| {
                            let (start, end) = parentheses.tokens();
                            std::iter::once((Some(start), "TypeInfo"))
                                .chain(arguments.extract_token_refs())
                                .chain(std::iter::once((Some(end), "TypeInfo")))
                        })
                        .chain_with(move || std::iter::once((Some(arrow), "TypeInfo")))
                        .chain_with(|| return_type.extract_token_refs()),
                )
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

                Box::new(std::iter::once((Some(base), "TypeInfo")).chain_with(|| {
                    let (start, end) = arrows.tokens();
                    std::iter::once((Some(start), "TypeInfo"))
                        .chain(generics.extract_token_refs())
                        .chain(std::iter::once((Some(end), "TypeInfo")))
                }))
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
                Box::new(
                    std::iter::once((Some(name), "TypeInfo"))
                        .chain(std::iter::once((Some(ellipsis), "TypeInfo"))),
                )
            }
            TypeInfo::Intersection(ti) => {
                Box::new(std::iter::once((None, "TypeInfo")).chain_with(|| ti.extract_token_refs()))
            }
            TypeInfo::Union(tu) => {
                Box::new(std::iter::once((None, "TypeInfo")).chain_with(|| tu.extract_token_refs()))
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

                Box::new(
                    std::iter::once((Some(module), "TypeInfo"))
                        .chain(std::iter::once((Some(punctuation), "TypeInfo")))
                        .chain(type_info.extract_token_refs()),
                )
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
                Box::new(
                    base.extract_token_refs()
                        .chain(std::iter::once((Some(question_mark), "TypeInfo"))),
                )
            }
            TypeInfo::Table { braces, fields } => {
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
                Box::new(
                    std::iter::once((Some(braces.tokens().0), "TypeInfo"))
                        .chain(fields.extract_token_refs())
                        .chain(std::iter::once((Some(braces.tokens().1), "TypeInfo"))),
                )
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
                Box::new(
                    std::iter::once((Some(typeof_token), "TypeInfo"))
                        .chain(std::iter::once((Some(parentheses.tokens().0), "TypeInfo")))
                        .chain(inner.extract_token_refs())
                        .chain(std::iter::once((Some(parentheses.tokens().1), "TypeInfo"))),
                )
            }
            TypeInfo::Tuple { parentheses, types } => Box::new(
                std::iter::once((Some(parentheses.tokens().0), "TypeInfo"))
                    .chain_with(|| types.extract_token_refs())
                    .chain(std::iter::once((Some(parentheses.tokens().1), "TypeInfo"))),
            ),
            TypeInfo::Variadic {
                type_info,
                ellipsis,
            } => Box::new(
                std::iter::once((Some(ellipsis), "TypeInfo")).chain(type_info.extract_token_refs()),
            ),
            TypeInfo::VariadicPack { ellipsis, name } => Box::new(
                std::iter::once((Some(ellipsis), "TypeInfo"))
                    .chain(std::iter::once((Some(name), "TypeInfo"))),
            ),
            _ => todo!("TypeInfo"),
        };

        iter
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
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        match self {
            TypeFieldKey::Name(name) => Either::Left(std::iter::once((Some(name), "TypeFieldKey"))),
            TypeFieldKey::IndexSignature { brackets, inner } => Either::Right(
                std::iter::once((Some(brackets.tokens().0), "TypeFieldKey"))
                    .chain_with(|| inner.extract_token_refs())
                    .chain_with(|| std::iter::once((Some(brackets.tokens().1), "TypeFieldKey"))),
            ),
            _ => todo!("TypeFieldKey"),
        }
    }
}

/// Token reference impl for LuauTypeField
impl TokenReferenceExtractor for TypeField {
    // #[display("{}{key}{colon}{value}", display_option(access))]
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        self.access()
            .into_iter()
            .flat_map(|t| std::iter::once((Some(t), "TypeField")))
            .chain_with(|| self.key().extract_token_refs())
            .chain_with(|| std::iter::once((Some(self.colon_token()), "TypeField")))
            .chain_with(|| self.value().extract_token_refs())
    }
}

impl TokenReferenceExtractor for TypeAssertion {
    /*
        pub(crate) assertion_op: TokenReference,
    pub(crate) cast_to: TypeInfo,
     */

    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        std::iter::once((Some(self.assertion_op()), "TypeAssertion"))
            .chain_with(|| self.cast_to().extract_token_refs())
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
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        let iter: Box<dyn Iterator<Item = (Option<&TokenReference>, &'static str)>> = match self {
            Field::ExpressionKey {
                brackets,
                key,
                equal,
                value,
            } => Box::new(
                std::iter::once((Some(brackets.tokens().0), "Field"))
                    .chain_with(|| key.extract_token_refs())
                    .chain_with(|| std::iter::once((Some(brackets.tokens().1), "Field")))
                    .chain_with(move || std::iter::once((Some(equal), "Field")))
                    .chain_with(|| value.extract_token_refs()),
            ),
            Field::NameKey { key, equal, value } => Box::new(
                std::iter::once((Some(key), "Field"))
                    .chain_with(move || std::iter::once((Some(equal), "Field")))
                    .chain_with(|| value.extract_token_refs()),
            ),
            Field::NoKey(value) => {
                Box::new(std::iter::once((None, "Field")).chain_with(|| value.extract_token_refs()))
            }
            _ => todo!("Field"),
        };

        iter
    }
}

impl TokenReferenceExtractor for Return {
    /*
        #[display("{token}{returns}")]
        pub struct Return {
    */
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        std::iter::once((None, "Return"))
            .chain_with(|| std::iter::once((Some(self.token()), "Return")))
            .chain_with(|| self.returns().extract_token_refs())
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
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        match self {
            Self::Expression(expr) => Either::Left(
                std::iter::once((None, "Prefix")).chain_with(|| expr.extract_token_refs()),
            ),
            Self::Name(t) => Either::Right(std::iter::once((Some(t), "Prefix"))),
            _ => todo!("Prefix"),
        }
    }
}

/*
#[display("{}{}{}", braces.tokens().0, fields, braces.tokens().1)]
pub struct TableConstructor {
 */
impl TokenReferenceExtractor for TableConstructor {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        std::iter::once((Some(self.braces().tokens().0), "TableConstructor"))
            .chain_with(|| self.fields().extract_token_refs())
            .chain_with(|| std::iter::once((Some(self.braces().tokens().1), "TableConstructor")))
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
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        match self {
            Self::Parentheses {
                parentheses,
                arguments,
            } => TriIterator::A(
                std::iter::once((Some(parentheses.tokens().0), "FunctionArgs"))
                    .chain_with(|| arguments.extract_token_refs())
                    .chain_with(|| std::iter::once((Some(parentheses.tokens().1), "FunctionArgs"))),
            ),
            Self::String(t) => TriIterator::B(std::iter::once((Some(t), "FunctionArgs"))),
            Self::TableConstructor(tc) => TriIterator::C(
                std::iter::once((None, "FunctionArgs")).chain_with(|| tc.extract_token_refs()),
            ),
            _ => todo!("FunctionArgs"),
        }
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
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        std::iter::once((Some(self.colon_token()), "MethodCall"))
            .chain_with(|| std::iter::once((Some(self.name()), "MethodCall")))
            .chain_with(|| self.args().extract_token_refs())
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
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        match self {
            Call::AnonymousCall(args) => Either::Left(
                std::iter::once((None, "Call")).chain_with(|| args.extract_token_refs()),
            ),
            Call::MethodCall(mc) => Either::Right(
                std::iter::once((None, "Call")).chain_with(|| mc.extract_token_refs()),
            ),
            _ => todo!("Call"),
        }
    }
}

/*
/// The indexing of something, such as `x.y` or `x["y"]`
/// Values of variants are the keys, such as `"y"`
#[derive(Clone, Debug, Display, PartialEq, Node)]
#[cfg_attr(feature = "serde", derive(Deserialize, Serialize))]
#[non_exhaustive]
pub enum Index {
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
}*/
impl TokenReferenceExtractor for Index {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        match self {
            Index::Brackets {
                brackets,
                expression,
            } => Either::Right(
                std::iter::once((Some(brackets.tokens().0), "Index"))
                    .chain_with(|| expression.extract_token_refs())
                    .chain_with(|| std::iter::once((Some(brackets.tokens().1), "Index"))),
            ),
            Index::Dot { dot, name } => Either::Left(
                std::iter::once((Some(dot), "Index"))
                    .chain_with(move || std::iter::once((Some(name), "Index"))),
            ),
            _ => todo!("Index"),
        }
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
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        match self {
            Suffix::Call(call) => Either::Left(
                std::iter::once((None, "Suffix")).chain_with(|| call.extract_token_refs()),
            ),
            Suffix::Index(index) => Either::Right(
                std::iter::once((None, "Suffix")).chain_with(|| index.extract_token_refs()),
            ),
            _ => todo!("Suffix"),
        }
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
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        std::iter::once((None, "VarExpression"))
            .chain_with(|| self.prefix().extract_token_refs())
            .chain_with(|| self.suffixes().flat_map(|s| s.extract_token_refs()))
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
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        match self {
            Self::Expression(v) => {
                Either::Left(std::iter::once((None, "Var")).chain_with(|| v.extract_token_refs()))
            }
            Self::Name(n) => Either::Right(std::iter::once((Some(n), "Var"))),
            _ => todo!("Var"),
        }
    }
}

impl TokenReferenceExtractor for Assignment {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        // #[display("{var_list}{equal_token}{expr_list}")]
        std::iter::once((None, "Assignment"))
            .chain_with(|| self.variables().extract_token_refs())
            .chain_with(|| std::iter::once((Some(self.equal_token()), "Assignment")))
            .chain_with(|| self.expressions().extract_token_refs())
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
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        match self {
            Self::Break(tr) => TriIterator::A(
                std::iter::once((None, "LastStmt"))
                    .chain_with(move || std::iter::once((Some(tr), "LastStmt"))),
            ),
            Self::Continue(tr) => TriIterator::B(
                std::iter::once((None, "LastStmt"))
                    .chain_with(move || std::iter::once((Some(tr), "LastStmt"))),
            ),
            Self::Return(ret) => TriIterator::C(
                std::iter::once((None, "LastStmt")).chain_with(|| ret.extract_token_refs()),
            ),
            _ => todo!("LastStmt"),
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
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        /*
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
         */

        std::iter::once((None, "Block"))
            .chain_with(|| {
                self.stmts_with_semicolon().flat_map(|(stmt, tr)| {
                    // First statement, then semicolon
                    stmt.extract_token_refs()
                        .chain_with(|| tr.iter().map(|tr| (Some(tr), "Block")))
                })
            })
            .chain_with(|| {
                self.last_stmt_with_semicolon()
                    .into_iter()
                    .flat_map(|(stmt, tr)| {
                        // first laststmt, then semicolon
                        stmt.extract_token_refs()
                            .chain_with(|| tr.iter().map(|tr| (Some(tr), "Block")))
                    })
            })
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
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        /*
                let mut token_refs = vec!["FunctionName".into()];
        token_refs.extend(self.names().clone().extract_token_refs());
        if let Some(method_colon) = self.method_colon() {
            token_refs.push(method_colon.into());
        }
        if let Some(method_name) = self.method_name() {
            token_refs.push(method_name.into());
        }
        token_refs
         */

        std::iter::once((None, "FunctionName"))
            .chain_with(|| self.names().extract_token_refs())
            .chain_with(|| {
                self.method_colon()
                    .into_iter()
                    .map(|mc| (Some(mc), "FunctionName"))
            })
            .chain_with(|| {
                self.method_name()
                    .into_iter()
                    .map(|mn| (Some(mn), "FunctionName"))
            })
    }
}

impl TokenReferenceExtractor for TypeSpecifier {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        // #[display("{punctuation}{type_info}")]
        std::iter::once((None, "TypeSpecifier"))
            .chain_with(|| std::iter::once((Some(self.punctuation()), "TypeSpecifier")))
            .chain_with(|| self.type_info().extract_token_refs())
    }
}

impl TokenReferenceExtractor for FunctionBody {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        /*
                   "{}{}{}{}{}{}{}",
           display_option(self.generics.as_ref()),
           self.parameters_parentheses.tokens().0,
           join_type_specifiers(&self.parameters, self.type_specifiers()),
           self.parameters_parentheses.tokens().1,
           display_option(self.return_type.as_ref()),
           self.block,
           self.end_token
        */

        std::iter::once((None, "FunctionBody"))
            .chain_with(|| {
                self.generics()
                    .into_iter()
                    .flat_map(|g| g.extract_token_refs())
            })
            .chain_with(|| {
                std::iter::once((
                    Some(self.parameters_parentheses().tokens().0),
                    "FunctionBody",
                ))
            })
            .chain_with(|| {
                self.parameters()
                    .iter()
                    .flat_map(|p| p.extract_token_refs())
            })
            .chain_with(|| {
                std::iter::once((
                    Some(self.parameters_parentheses().tokens().1),
                    "FunctionBody",
                ))
            })
            .chain_with(|| {
                self.return_type()
                    .into_iter()
                    .flat_map(|rt| rt.extract_token_refs())
            })
            .chain_with(|| self.block().extract_token_refs())
            .chain_with(|| std::iter::once((Some(self.end_token()), "FunctionBody")))
    }
}

impl TokenReferenceExtractor for FunctionCall {
    // #[display("{}{}", prefix, join_vec(suffixes))]
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        std::iter::once((None, "FunctionCall"))
            .chain_with(|| self.prefix().extract_token_refs())
            .chain_with(|| self.suffixes().flat_map(|s| s.extract_token_refs()))
    }
}

impl TokenReferenceExtractor for BinOp {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        std::iter::once((Some(self.token()), "BinOp"))
    }
}

impl TokenReferenceExtractor for UnOp {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        std::iter::once((Some(self.token()), "UnOp"))
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
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        std::iter::once((Some(self.if_token()), "IfExpression"))
            .chain_with(|| self.condition().extract_token_refs())
            .chain_with(|| std::iter::once((Some(self.then_token()), "IfExpression")))
            .chain_with(|| self.if_expression().extract_token_refs())
            .chain_with(|| {
                self.else_if_expressions()
                    .into_iter()
                    .flat_map(|e| e.extract_token_refs())
            })
            .chain_with(|| std::iter::once((Some(self.else_token()), "IfExpression")))
            .chain_with(|| self.else_expression().extract_token_refs())
    }
}

impl TokenReferenceExtractor for ElseIfExpression {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        std::iter::once((Some(self.else_if_token()), "ElseIfExpression"))
            .chain_with(|| self.condition().extract_token_refs())
            .chain_with(|| std::iter::once((Some(self.then_token()), "ElseIfExpression")))
            .chain_with(|| self.expression().extract_token_refs())
    }
}

impl TokenReferenceExtractor for InterpolatedString {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        // #[display("{}{}", join_vec(segments), last_string)]
        std::iter::once((None, "InterpolatedString"))
            .chain_with(|| self.segments().flat_map(|s| s.extract_token_refs()))
            .chain_with(|| self.last_string().extract_token_refs())
    }
}

impl TokenReferenceExtractor for InterpolatedStringSegment {
    // #[display("{literal}{expression}")]
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        std::iter::once((None, "InterpolatedStringSegment"))
            .chain_with(|| self.literal.extract_token_refs())
            .chain_with(|| self.expression.extract_token_refs())
    }
}

// TODO
impl TokenReferenceExtractor for Stmt {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        std::iter::once((None, "Stmt")) // Not needed (?)
    }
}

impl TokenReferenceExtractor for Expression {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        let iter: Box<dyn Iterator<Item = (Option<&TokenReference>, &'static str)>> = match self {
            Expression::BinaryOperator { lhs, binop, rhs } => Box::new(
                lhs.extract_token_refs()
                    .chain_with(|| binop.extract_token_refs())
                    .chain_with(|| rhs.extract_token_refs()),
            ),
            Expression::Parentheses {
                contained,
                expression,
            } => Box::new(
                std::iter::once((Some(contained.tokens().0), "Expression"))
                    .chain_with(|| expression.extract_token_refs())
                    .chain_with(|| std::iter::once((Some(contained.tokens().1), "Expression"))),
            ),
            Expression::UnaryOperator { unop, expression } => Box::new(Box::new(
                std::iter::once((None, "Expression"))
                    .chain_with(|| unop.extract_token_refs())
                    .chain_with(|| expression.extract_token_refs()),
            )),
            Expression::Function(f) => Box::new(
                std::iter::once((None, "Expression"))
                    .chain_with(|| std::iter::once((Some(&f.0), "Expression")))
                    .chain_with(|| f.1.extract_token_refs()),
            ),
            Expression::FunctionCall(fc) => Box::new(
                std::iter::once((None, "Expression")).chain_with(|| fc.extract_token_refs()),
            ),
            Expression::IfExpression(ie) => Box::new(
                std::iter::once((None, "Expression")).chain_with(|| ie.extract_token_refs()),
            ),
            Expression::InterpolatedString(is) => Box::new(
                std::iter::once((None, "Expression")).chain_with(|| is.extract_token_refs()),
            ),
            Expression::TableConstructor(tc) => Box::new(
                std::iter::once((None, "Expression")).chain_with(|| tc.extract_token_refs()),
            ),
            Expression::Number(tr) | Expression::String(tr) | Expression::Symbol(tr) => {
                Box::new(std::iter::once((Some(tr), "Expression")))
            }
            Expression::TypeAssertion {
                expression,
                type_assertion,
            } => Box::new(
                std::iter::once((None, "Expression"))
                    .chain_with(|| expression.extract_token_refs())
                    .chain_with(|| type_assertion.extract_token_refs()),
            ),
            Expression::Var(v) => Box::new(
                std::iter::once((None, "Expression")).chain_with(|| v.extract_token_refs()),
            ),
            _ => todo!("Expression"),
        };

        iter
    }
}

impl TokenReferenceExtractor for TypeDeclaration {
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

    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        std::iter::once((None, "TypeDeclaration"))
            .chain_with(|| std::iter::once((Some(self.type_token()), "TypeDeclaration")))
            .chain_with(|| self.type_name().extract_token_refs())
            .chain_with(|| {
                self.generics()
                    .into_iter()
                    .flat_map(|g| g.extract_token_refs())
            })
            .chain_with(|| std::iter::once((Some(self.equal_token()), "TypeDeclaration")))
            .chain_with(|| self.type_definition().extract_token_refs())
    }
}

impl TokenReferenceExtractor for ExportedTypeDeclaration {
    /*
    #[display(
        "{}{}{}{}{}{}{}",
        export_token,
        type_token,
        base,
        display_option(generics),
        equal_token,
        declare_as,
        semicolon_token
    )]
    */

    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        std::iter::once((None, "ExportedTypeDeclaration"))
            .chain_with(|| std::iter::once((Some(self.export_token()), "ExportedTypeDeclaration")))
            .chain_with(|| self.type_declaration().extract_token_refs())
    }
}

/*
#[cfg_attr(feature = "luau", display("{function_token}{name}{body}"))]
pub struct FunctionDeclaration {
 */
impl TokenReferenceExtractor for FunctionDeclaration {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        std::iter::once((None, "FunctionDeclaration"))
            .chain_with(|| std::iter::once((Some(self.function_token()), "FunctionDeclaration")))
            .chain_with(|| self.name().extract_token_refs())
            .chain_with(|| self.body().extract_token_refs())
    }
}

impl TokenReferenceExtractor for LocalFunction {
    // #[cfg_attr(feature = "luau", display("{local_token}{function_token}{name}{body}"))]
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        std::iter::once((None, "LocalFunction"))
            .chain_with(|| std::iter::once((Some(self.local_token()), "LocalFunction")))
            .chain_with(|| std::iter::once((Some(self.function_token()), "LocalFunction")))
            .chain_with(|| self.name().extract_token_refs())
            .chain_with(|| self.body().extract_token_refs())
    }
}
