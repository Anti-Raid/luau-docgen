use full_moon::{
    ast::{
        Expression, Field, Parameter, TableConstructor,
        luau::{
            GenericDeclaration, GenericDeclarationParameter, GenericParameterInfo, IndexedTypeInfo,
            TypeArgument, TypeField, TypeFieldKey, TypeInfo, TypeIntersection, TypeUnion,
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

/// Abstraction to extract token references from compatible types
///
/// This should be much faster than v1 of token reference extractor and safer too.
pub trait TokenReferenceExtractor: Clone {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)>;

    fn get_surrounding_trivia(&self) -> Vec<String> {
        let mut comments = Vec::new();

        for (token_ref, ..) in self.extract_token_refs() {
            let Some(token_ref) = token_ref else {
                continue;
            };
            let trivia = get_comments_from_token_ref(token_ref);
            comments.extend(trivia);
        }

        comments
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
            Pair::End(item) => Either::Right(
                std::iter::once((None, "PairPunctuated")).chain(item.extract_token_refs()),
            ),
        }
    }
}

/// Punctuated impl
impl<T: TokenReferenceExtractor> TokenReferenceExtractor for Punctuated<T> {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        self.pairs().flat_map(|p| p.extract_token_refs())
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

// TODO
impl TokenReferenceExtractor for Expression {
    fn extract_token_refs(&self) -> impl Iterator<Item = (Option<&TokenReference>, &'static str)> {
        std::iter::once(todo!())
    }
}
