<div id="Types"></div>

# Types

<div id="Span"></div>

## Span

Stores the locational information of a token or CST node.



Components:

* x: The start index.

* y: The end index.

* z: Unused.

<details>
<summary>Raw Type</summary>

```luau
--- Stores the locational information of a token or CST node.
--- 
--- Components:
--- * x: The start index.
--- * y: The end index.
--- * z: Unused.
type Span = {
	x: number,

	y: number,

	z: number
}
```

</details>

<div id="x"></div>

### x

[number](#number)

<div id="y"></div>

### y

[number](#number)

<div id="z"></div>

### z

[number](#number)

<div id="Trivia"></div>

## Trivia

Represents trivia unimportant to parsing: comments and whitespace.

<details>
<summary>Raw Type</summary>

```luau
--- Represents trivia unimportant to parsing: comments and whitespace.
type Trivia = {
		kind: "whitespace",

		text: string,

		span: Span
	} | {
		kind: "comment",

		text: string,

		span: Span
	}
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

*This is an inline table type with the following fields*

<div id="kind"></div>

#### kind

```luau
"whitespace"
```

<div id="text"></div>

#### text

[string](#string)

<div id="span"></div>

#### span

[Span](#Span)

</details>

<details>
<summary>Variant 2</summary>

*This is an inline table type with the following fields*

<div id="kind"></div>

#### kind

```luau
"comment"
```

<div id="text"></div>

#### text

[string](#string)

<div id="span"></div>

#### span

[Span](#Span)

</details>

<div id="Token"></div>

## Token

A token, such as an identifier, number, string, keyword, or symbol.



Each variant includes `span` and `trivia` fields. The `span` field stores

the location of the token, and the `trivia` field stores any trivia in front

of the token.



Some tokens have a `text` field which stores the text of the token. This

field is only present for tokens that can have different text in each

instance, such as identifiers or strings.

<details>
<summary>Raw Type</summary>

```luau
--- A token, such as an identifier, number, string, keyword, or symbol.
--- 
--- Each variant includes `span` and `trivia` fields. The `span` field stores
--- the location of the token, and the `trivia` field stores any trivia in front
--- of the token.
--- 
--- Some tokens have a `text` field which stores the text of the token. This
--- field is only present for tokens that can have different text in each
--- instance, such as identifiers or strings.
type Token = {
		kind: "eof",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "error",

		text: string,

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "ident",

		text: string,

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "number",

		text: string,

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "string",

		text: string,

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "istring_simple",

		text: string,

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "istring_first",

		text: string,

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "istring_middle",

		text: string,

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "istring_last",

		text: string,

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "attribute",

		text: string,

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "and",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "break",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "do",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "else",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "elseif",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "end",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "false",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "for",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "function",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "if",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "in",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "local",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "nil",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "not",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "or",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "repeat",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "return",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "then",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "true",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "until",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "while",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "+=",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "-=",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "*=",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "/=",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "//=",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "%=",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "^=",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "..=",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "+",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "-",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "*",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "/",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "//",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "%",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "^",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "..",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "<",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "<=",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: ">",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: ">=",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "==",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "~=",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "#",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "...",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "&",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "|",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "?",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: ":",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "::",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "->",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "=",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: ",",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: ";",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: ".",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "(",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: ")",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "{",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "}",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "[",

		span: Span,

		trivia: {Trivia}
	} | {
		kind: "]",

		span: Span,

		trivia: {Trivia}
	}
```

</details>

({kind: "eof", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "error", text: [string](#string), span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "ident", text: [string](#string), span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "number", text: [string](#string), span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "string", text: [string](#string), span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "istring_simple", text: [string](#string), span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "istring_first", text: [string](#string), span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "istring_middle", text: [string](#string), span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "istring_last", text: [string](#string), span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "attribute", text: [string](#string), span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "and", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "break", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "do", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "else", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "elseif", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "end", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "false", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "for", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "function", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "if", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "in", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "local", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "nil", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "not", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "or", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "repeat", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "return", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "then", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "true", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "until", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "while", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "+=", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "-=", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "\*=", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "/=", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "//=", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "%=", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "^=", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "..=", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "+", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "-", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "\*", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "/", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "//", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "%", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "^", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "..", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "&lt;", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "&lt;=", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "&gt;", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "&gt;=", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "==", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "~=", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "#", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "...", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "&", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "|", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "?", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: ":", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "::", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "-&gt;", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "=", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: ",", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: ";", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: ".", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "(", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: ")", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "{", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "}", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "[", span: [Span](#Span), trivia: {[Trivia](#Trivia)}} | {kind: "]", span: [Span](#Span), trivia: {[Trivia](#Trivia)}})<div id="TokenKind"></div>

## TokenKind

A token with a specific kind, such as `TokenKind<"+">` or `TokenKind<"string">`.

<details>
<summary>Raw Type</summary>

```luau
--- A token with a specific kind, such as `TokenKind<"+">` or `TokenKind<"string">`.
type TokenKind<Kind> = {
	kind: Kind,

	text: string,

	span: Span,

	trivia: {Trivia}
}
```

</details>

<div id="kind"></div>

### kind

[Kind](#Kind)

<div id="text"></div>

### text

[string](#string)

<div id="span"></div>

### span

[Span](#Span)

<div id="trivia"></div>

### trivia

{[Trivia](#Trivia)}

<div id="Pair"></div>

## Pair

A pair of a node and optional separator, such as `node,` or `node`.



This is used within `Separated` to represent nodes like the arguments

passed to a function, which would be `Separated<Expr>`.

<details>
<summary>Raw Type</summary>

```luau
--- A pair of a node and optional separator, such as `node,` or `node`.
--- 
--- This is used within `Separated` to represent nodes like the arguments
--- passed to a function, which would be `Separated<Expr>`.
type Pair<Node, Sep> = {
	node: Node,

	sep: (Sep & Token)?
}
```

</details>

<div id="node"></div>

### node

[Node](#Node)

<div id="sep"></div>

### sep

*This field is optional and may not be specified*

([Sep](#Sep) & [Token](#Token))?

<div id="Separated"></div>

## Separated

A list of nodes separated by tokens, such as `foo, bar, baz`.



This is used in many places, notably function arguments, table fields, and

stats in blocks.

<details>
<summary>Raw Type</summary>

```luau
--- A list of nodes separated by tokens, such as `foo, bar, baz`.
--- 
--- This is used in many places, notably function arguments, table fields, and
--- stats in blocks.
type Separated<Node, Sep> = {Pair<Node, Sep>}
```

</details>

{[Pair](#Pair)&lt;[Node](#Node), [Sep](#Sep)&gt;}

<div id="Delim"></div>

## Delim

Delimiters that surround something, such as `(foo)` or `{bar}`.



Note that this node does not store the node within the delimiters, it only

stores the delimiters themselves.

<details>
<summary>Raw Type</summary>

```luau
--- Delimiters that surround something, such as `(foo)` or `{bar}`.
--- 
--- Note that this node does not store the node within the delimiters, it only
--- stores the delimiters themselves.
type Delim<Open, Close> = {
	--- The opening delimiter; the `(` in `(foo)`.
	open: Open & Token,

	--- The closing delimiter; the `)` in `(foo)`.
	close: Close & Token
}
```

</details>

<div id="open"></div>

### open

The opening delimiter; the `(` in `(foo)`.

Intersection with variants:

<details>
<summary>Variant 1</summary>

[Open](#Open)

</details>

<details>
<summary>Variant 2</summary>

[Token](#Token)

</details>

<div id="close"></div>

### close

The closing delimiter; the `)` in `(foo)`.

Intersection with variants:

<details>
<summary>Variant 1</summary>

[Close](#Close)

</details>

<details>
<summary>Variant 2</summary>

[Token](#Token)

</details>

<div id="GenericDeclaration"></div>

## GenericDeclaration

A generic declaration without default types; the `<A, B, C...>` in

`<A, B, C...>() -> ()`.



This is used in function declarations, local function declarations, and

function types.



All names must come before all packs. For example, `<A, B..., C>` is invalid

because `C` comes after `B...`.

<details>
<summary>Raw Type</summary>

```luau
--- A generic declaration without default types; the `<A, B, C...>` in
--- `<A, B, C...>() -> ()`.
--- 
--- This is used in function declarations, local function declarations, and
--- function types.
--- 
--- All names must come before all packs. For example, `<A, B..., C>` is invalid
--- because `C` comes after `B...`.
type GenericDeclaration = {
	--- The angles surrounding the generic declaration; the `<>` in
	--- `<A, B, C...>`.
	angles: Delim<TokenKind<"<">, TokenKind<">">>,

	--- The generic types; the `A, B,` in `A, B, C...`.
	names: Separated<TokenKind<"ident">, TokenKind<",">>,

	--- The generic type packs; the `C...` in `A, B, C...`.
	packs: Separated<{
		--- The name; the `C` in `C...`.
		name: TokenKind<"ident">,

		--- The dots; the `...` in `C...`.
		dots: TokenKind<"...">
	}, TokenKind<",">>
}
```

</details>

<div id="angles"></div>

### angles

The angles surrounding the generic declaration; the `<>` in

`<A, B, C...>`.

[Delim](#Delim)&lt;[TokenKind](#TokenKind)&lt;"&lt;"&gt;, [TokenKind](#TokenKind)&lt;"&gt;"&gt;&gt;<div id="names"></div>

### names

The generic types; the `A, B,` in `A, B, C...`.

[Separated](#Separated)&lt;[TokenKind](#TokenKind)&lt;"ident"&gt;, [TokenKind](#TokenKind)&lt;","&gt;&gt;<div id="packs"></div>

### packs

The generic type packs; the `C...` in `A, B, C...`.

[Separated](#Separated)&lt;{name: [TokenKind](#TokenKind)&lt;"ident"&gt;, dots: [TokenKind](#TokenKind)&lt;"..."&gt;}, [TokenKind](#TokenKind)&lt;","&gt;&gt;<div id="GenericDeclarationWithDefaults"></div>

## GenericDeclarationWithDefaults

A generic declaration with optional default types; the

`<A = number, B... = (number, ...string)>` in

`type T<A = number, B... = (number, ...string)> = {}`.



This is used in type declarations.



In addition to the rules of `GenericDeclaration`, this node also requires

that any declarations after a declaration with a default type also have a

default type. For example, `<A = number, B>` is invalid because `B` doesn't

have a default type, but comes after a type with a default type.

<details>
<summary>Raw Type</summary>

```luau
--- A generic declaration with optional default types; the
--- `<A = number, B... = (number, ...string)>` in
--- `type T<A = number, B... = (number, ...string)> = {}`.
--- 
--- This is used in type declarations.
--- 
--- In addition to the rules of `GenericDeclaration`, this node also requires
--- that any declarations after a declaration with a default type also have a
--- default type. For example, `<A = number, B>` is invalid because `B` doesn't
--- have a default type, but comes after a type with a default type.
type GenericDeclarationWithDefaults = {
	--- The angles surrounding the generic declaration; the `<>` in
	--- `<A = number, B... = (number, ...string)>`.
	angles: Delim<TokenKind<"<">, TokenKind<">">>,

	--- The generic types; the `A = number,` in
	--- `<A = number, B... = (number, ...string)>`.
	names: Separated<{
		--- The name; the `A` in `A = number`.
		name: TokenKind<"ident">,

		--- The default type; the `= number` in `A = number`.
		default: {
			--- The equals sign; the `=` in `= number`.
			equals: TokenKind<"=">,

			--- The type; the `number` in `= number`.
			type: Type
		}?
	}, TokenKind<",">>,

	--- The generic type packs; the `B... = (number, ...string)` in
	--- `<A = number, B... = (number, ...string)>`.
	packs: Separated<{
		--- The name; the `B` in `B... = (number, ...string)`.
		name: TokenKind<"ident">,

		--- The dots; the first `...` in `B... = (number, ...string)`.
		dots: TokenKind<"...">,

		--- The default type; the `= (number, ...string)` in
		--- `B... = (number, ...string)`.
		default: {
			--- The equals sign; the `=` in `= (number, ...string)`.
			equals: TokenKind<"=">,

			--- The type; the `(number, ...string)` in `= (number, ...string)`.
			pack: TypePack
		}?
	}, TokenKind<",">>
}
```

</details>

<div id="angles"></div>

### angles

The angles surrounding the generic declaration; the `<>` in

`<A = number, B... = (number, ...string)>`.

[Delim](#Delim)&lt;[TokenKind](#TokenKind)&lt;"&lt;"&gt;, [TokenKind](#TokenKind)&lt;"&gt;"&gt;&gt;<div id="names"></div>

### names

The generic types; the `A = number,` in

`<A = number, B... = (number, ...string)>`.

[Separated](#Separated)&lt;{name: [TokenKind](#TokenKind)&lt;"ident"&gt;, default: {equals: [TokenKind](#TokenKind)&lt;"="&gt;, type: [Type](#Type)}?}, [TokenKind](#TokenKind)&lt;","&gt;&gt;<div id="packs"></div>

### packs

The generic type packs; the `B... = (number, ...string)` in

`<A = number, B... = (number, ...string)>`.

[Separated](#Separated)&lt;{name: [TokenKind](#TokenKind)&lt;"ident"&gt;, dots: [TokenKind](#TokenKind)&lt;"..."&gt;, default: {equals: [TokenKind](#TokenKind)&lt;"="&gt;, pack: [TypePack](#TypePack)}?}, [TokenKind](#TokenKind)&lt;","&gt;&gt;<div id="TypeArg"></div>

## TypeArg

An argument to a type, such as `foo` or `...bar` or `bar...`.



This is used in reference types for arguments to types. As an example:

`foo<bar, baz...>` would have two `TypeArg`s: `bar` and `baz...`.

<details>
<summary>Raw Type</summary>

```luau
--- An argument to a type, such as `foo` or `...bar` or `bar...`.
--- 
--- This is used in reference types for arguments to types. As an example:
--- `foo<bar, baz...>` would have two `TypeArg`s: `bar` and `baz...`.
type TypeArg = Type | TypePack
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

[Type](#Type)

</details>

<details>
<summary>Variant 2</summary>

[TypePack](#TypePack)

</details>

<div id="TableTypeField_NameProp"></div>

## TableTypeField_NameProp

A table type field with a name key, such as `foo: bar` or

`bar: number`.

<details>
<summary>Raw Type</summary>

```luau
--- A table type field with a name key, such as `foo: bar` or
--- `bar: number`.
type TableTypeField_NameProp = {
	kind: "nameprop",

	--- The access modifier; the `read` in `foo: bar`.
	--- 
	--- This token should only have values of `read` or `write`.
	access: TokenKind<"ident">?,

	--- The name; the `foo` in `foo: bar`.
	name: TokenKind<"ident">,

	--- The colon; the `:` in `foo: bar`.
	colon: TokenKind<":">,

	--- The type; the `bar` in `foo: bar`.
	type: Type
}
```

</details>

<div id="kind"></div>

### kind

```luau
"nameprop"
```

<div id="access"></div>

### access

The access modifier; the `read` in `foo: bar`.



This token should only have values of `read` or `write`.

*This field is optional and may not be specified*

[TokenKind](#TokenKind)&lt;"ident"&gt;?

<div id="name"></div>

### name

The name; the `foo` in `foo: bar`.

[TokenKind](#TokenKind)&lt;"ident"&gt;<div id="colon"></div>

### colon

The colon; the `:` in `foo: bar`.

[TokenKind](#TokenKind)&lt;":"&gt;<div id="type"></div>

### type

The type; the `bar` in `foo: bar`.

[Type](#Type)

<div id="TableTypeField_StringProp"></div>

## TableTypeField_StringProp

A table type field with a string key, such as `["foo"]: bar` or

`['bar']: number`.

<details>
<summary>Raw Type</summary>

```luau
--- A table type field with a string key, such as `["foo"]: bar` or
--- `['bar']: number`.
type TableTypeField_StringProp = {
	kind: "stringprop",

	--- The access modifier; the `read` in `["foo"]: bar`.
	--- 
	--- This token should only have values of `read` or `write`.
	access: TokenKind<"ident">?,

	--- The brackets surrounding the key; the `[]` in `["foo"]: bar`.
	bracks: Delim<TokenKind<"[">, TokenKind<"]">>,

	--- The key; the `"foo"` in `["foo"]: bar`.
	key: TokenKind<"string">,

	--- The colon; the `:` in `["foo"]: bar`.
	colon: TokenKind<":">,

	--- The type; the `bar` in `["foo"]: bar`.
	type: Type
}
```

</details>

<div id="kind"></div>

### kind

```luau
"stringprop"
```

<div id="access"></div>

### access

The access modifier; the `read` in `["foo"]: bar`.



This token should only have values of `read` or `write`.

*This field is optional and may not be specified*

[TokenKind](#TokenKind)&lt;"ident"&gt;?

<div id="bracks"></div>

### bracks

The brackets surrounding the key; the `[]` in `["foo"]: bar`.

[Delim](#Delim)&lt;[TokenKind](#TokenKind)&lt;"["&gt;, [TokenKind](#TokenKind)&lt;"]"&gt;&gt;<div id="key"></div>

### key

The key; the `"foo"` in `["foo"]: bar`.

[TokenKind](#TokenKind)&lt;"string"&gt;<div id="colon"></div>

### colon

The colon; the `:` in `["foo"]: bar`.

[TokenKind](#TokenKind)&lt;":"&gt;<div id="type"></div>

### type

The type; the `bar` in `["foo"]: bar`.

[Type](#Type)

<div id="TableTypeField_Indexer"></div>

## TableTypeField_Indexer

A table type indexer field, such as `[number]: string` or

`[string]: number`.

<details>
<summary>Raw Type</summary>

```luau
--- A table type indexer field, such as `[number]: string` or
--- `[string]: number`.
type TableTypeField_Indexer = {
	kind: "indexer",

	--- The access modifier; the `read` in `[number]: string`.
	--- 
	--- This token should only have values of `read` or `write`.
	access: TokenKind<"ident">?,

	--- The brackets surrounding the key; the `[]` in `[number]: string`.
	bracks: Delim<TokenKind<"[">, TokenKind<"]">>,

	--- The key; the `number` in `[number]: string`.
	key: Type,

	--- The colon; the `:` in `[number]: string`.
	colon: TokenKind<":">,

	--- The type; the `string` in `[number]: string`.
	type: Type
}
```

</details>

<div id="kind"></div>

### kind

```luau
"indexer"
```

<div id="access"></div>

### access

The access modifier; the `read` in `[number]: string`.



This token should only have values of `read` or `write`.

*This field is optional and may not be specified*

[TokenKind](#TokenKind)&lt;"ident"&gt;?

<div id="bracks"></div>

### bracks

The brackets surrounding the key; the `[]` in `[number]: string`.

[Delim](#Delim)&lt;[TokenKind](#TokenKind)&lt;"["&gt;, [TokenKind](#TokenKind)&lt;"]"&gt;&gt;<div id="key"></div>

### key

The key; the `number` in `[number]: string`.

[Type](#Type)

<div id="colon"></div>

### colon

The colon; the `:` in `[number]: string`.

[TokenKind](#TokenKind)&lt;":"&gt;<div id="type"></div>

### type

The type; the `string` in `[number]: string`.

[Type](#Type)

<div id="TableTypeField"></div>

## TableTypeField

A table type field, such as `foo: bar` or `["foo"]: bar` or

`write [number]: string`.

<details>
<summary>Raw Type</summary>

```luau
--- A table type field, such as `foo: bar` or `["foo"]: bar` or
--- `write [number]: string`.
type TableTypeField = TableTypeField_NameProp | TableTypeField_StringProp | TableTypeField_Indexer
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

[TableTypeField_NameProp](#TableTypeField_NameProp)

</details>

<details>
<summary>Variant 2</summary>

[TableTypeField_StringProp](#TableTypeField_StringProp)

</details>

<details>
<summary>Variant 3</summary>

[TableTypeField_Indexer](#TableTypeField_Indexer)

</details>

<div id="Type_Nil"></div>

## Type_Nil

The literal type `nil`.

<details>
<summary>Raw Type</summary>

```luau
--- The literal type `nil`.
type Type_Nil = {
	kind: "nil",

	--- The `nil` token.
	tok: TokenKind<"nil">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"nil"
```

<div id="tok"></div>

### tok

The `nil` token.

[TokenKind](#TokenKind)&lt;"nil"&gt;<div id="Type_Boolean"></div>

## Type_Boolean

The literal types `true` and `false`.

<details>
<summary>Raw Type</summary>

```luau
--- The literal types `true` and `false`.
type Type_Boolean = {
	kind: "boolean",

	--- The `true` or `false` token.
	tok: TokenKind<"true"> | TokenKind<"false">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"boolean"
```

<div id="tok"></div>

### tok

The `true` or `false` token.

Union with variants:

<details>
<summary>Variant 1</summary>

[TokenKind](#TokenKind)&lt;"true"&gt;</details>

<details>
<summary>Variant 2</summary>

[TokenKind](#TokenKind)&lt;"false"&gt;</details>

<div id="Type_String"></div>

## Type_String

A string literal type, such as `"foo"` or `'bar'` or `[[baz]]`.

<details>
<summary>Raw Type</summary>

```luau
--- A string literal type, such as `"foo"` or `'bar'` or `[[baz]]`.
type Type_String = {
	kind: "string",

	--- The string token.
	tok: TokenKind<"string">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"string"
```

<div id="tok"></div>

### tok

The string token.

[TokenKind](#TokenKind)&lt;"string"&gt;<div id="Type_Reference"></div>

## Type_Reference

A reference type, such as `foo` or `foo<bar>` or `foo.bar<baz>`.

<details>
<summary>Raw Type</summary>

```luau
--- A reference type, such as `foo` or `foo<bar>` or `foo.bar<baz>`.
type Type_Reference = {
	kind: "reference",

	--- The optional prefix; the `foo.` in `foo.bar<baz>`.
	prefix: {
		--- The name; the `foo` in `foo.`.
		name: TokenKind<"ident">,

		--- The dot; the `.` in `foo.`.
		dot: TokenKind<".">
	}?,

	--- The name; the `bar` in `foo.bar<baz>`.
	name: TokenKind<"ident">,

	--- The optional generics; the `<baz>` in `foo.bar<baz>`.
	generics: {
		--- The angles surrounding the generic declaration; the `<>` in
		--- `<baz>`.
		angles: Delim<TokenKind<"<">, TokenKind<">">>,

		--- The generic types; the `baz` in `<baz>`.
		types: Separated<TypeArg, TokenKind<",">>
	}?
}
```

</details>

<div id="kind"></div>

### kind

```luau
"reference"
```

<div id="prefix"></div>

### prefix

The optional prefix; the `foo.` in `foo.bar<baz>`.

*This field is optional and may not be specified*

{name: [TokenKind](#TokenKind)&lt;"ident"&gt;, dot: [TokenKind](#TokenKind)&lt;"."&gt;}?

<div id="name"></div>

### name

The name; the `bar` in `foo.bar<baz>`.

[TokenKind](#TokenKind)&lt;"ident"&gt;<div id="generics"></div>

### generics

The optional generics; the `<baz>` in `foo.bar<baz>`.

*This field is optional and may not be specified*

{angles: [Delim](#Delim)&lt;[TokenKind](#TokenKind)&lt;"&lt;"&gt;, [TokenKind](#TokenKind)&lt;"&gt;"&gt;&gt;, types: [Separated](#Separated)&lt;[TypeArg](#TypeArg), [TokenKind](#TokenKind)&lt;","&gt;&gt;}?

<div id="Type_Typeof"></div>

## Type_Typeof

A typeof type, such as `typeof(foo)` or `typeof(10)`.

<details>
<summary>Raw Type</summary>

```luau
--- A typeof type, such as `typeof(foo)` or `typeof(10)`.
type Type_Typeof = {
	kind: "typeof",

	--- The `typeof` token.
	typeof_tok: TokenKind<"ident">,

	--- The parentheses surrounding the expr; the `()` in `typeof(foo)`.
	parens: Delim<TokenKind<"(">, TokenKind<")">>,

	--- The expr; the `foo` in `typeof(foo)`.
	expr: Expr
}
```

</details>

<div id="kind"></div>

### kind

```luau
"typeof"
```

<div id="typeof_tok"></div>

### typeof_tok

The `typeof` token.

[TokenKind](#TokenKind)&lt;"ident"&gt;<div id="parens"></div>

### parens

The parentheses surrounding the expr; the `()` in `typeof(foo)`.

[Delim](#Delim)&lt;[TokenKind](#TokenKind)&lt;"("&gt;, [TokenKind](#TokenKind)&lt;")"&gt;&gt;<div id="expr"></div>

### expr

The expr; the `foo` in `typeof(foo)`.

[Expr](#Expr)

<div id="Type_Array"></div>

## Type_Array

An array type, such as `{ foo }` or `{ number }`.

<details>
<summary>Raw Type</summary>

```luau
--- An array type, such as `{ foo }` or `{ number }`.
type Type_Array = {
	kind: "array",

	--- The braces surrounding the type; the `{}` in `{ number }`.
	braces: Delim<TokenKind<"{">, TokenKind<"}">>,

	--- The type; the `number` in `{ number }`.
	type: Type
}
```

</details>

<div id="kind"></div>

### kind

```luau
"array"
```

<div id="braces"></div>

### braces

The braces surrounding the type; the `{}` in `{ number }`.

[Delim](#Delim)&lt;[TokenKind](#TokenKind)&lt;"{"&gt;, [TokenKind](#TokenKind)&lt;"}"&gt;&gt;<div id="type"></div>

### type

The type; the `number` in `{ number }`.

[Type](#Type)

<div id="Type_Table"></div>

## Type_Table

A table type, such as `{ foo: bar, ["baz"]: number, [number]: string }`.

<details>
<summary>Raw Type</summary>

```luau
--- A table type, such as `{ foo: bar, ["baz"]: number, [number]: string }`.
type Type_Table = {
	kind: "table",

	--- The braces surrounding the type; the `{}` in `{ foo: bar }`.
	braces: Delim<TokenKind<"{">, TokenKind<"}">>,

	--- The fields; the `foo: bar` in `{ foo: bar }`.
	fields: Separated<TableTypeField, TokenKind<","> | TokenKind<";">>
}
```

</details>

<div id="kind"></div>

### kind

```luau
"table"
```

<div id="braces"></div>

### braces

The braces surrounding the type; the `{}` in `{ foo: bar }`.

[Delim](#Delim)&lt;[TokenKind](#TokenKind)&lt;"{"&gt;, [TokenKind](#TokenKind)&lt;"}"&gt;&gt;<div id="fields"></div>

### fields

The fields; the `foo: bar` in `{ foo: bar }`.

[Separated](#Separated)&lt;[TableTypeField](#TableTypeField), ([TokenKind](#TokenKind)&lt;","&gt; | [TokenKind](#TokenKind)&lt;";"&gt;)&gt;<div id="Type_Function"></div>

## Type_Function

A function type, such as `<T>(foo: T, ...bar) -> baz`.

<details>
<summary>Raw Type</summary>

```luau
--- A function type, such as `<T>(foo: T, ...bar) -> baz`.
type Type_Function = {
	kind: "function",

	--- The optional generic declaration; the `<T>` in
	--- `<T>(foo: T, ...bar) -> baz`.
	generics: GenericDeclaration?,

	--- The parentheses surrounding the arguments; the `()` in
	--- `<T>(foo: T, ...bar) -> baz`.
	parens: Delim<TokenKind<"(">, TokenKind<")">>,

	--- The parameters; the `foo: T,` in `<T>(foo: T, ...bar) -> baz`.
	params: Separated<{
		--- The optional name of the parameter; the `foo:` in `foo: T`.
		name: {
			--- The name; the `foo` in `foo:`.
			name: TokenKind<"ident">,

			--- The colon; the `:` in `foo:`.
			colon: TokenKind<":">
		}?,

		--- The type of the parameter; the `T` in `foo: T`.
		type: Type
	}, TokenKind<",">>,

	--- The optional varargs; the `...bar` in `<T>(foo: T, ...bar) -> baz`.
	varargs: TailType?,

	--- The arrow; the `->` in `<T>(foo: T, ...bar) -> baz`.
	arrow: TokenKind<"->">,

	--- The return type; the `baz` in `<T>(foo: T, ...bar) -> baz`.
	ret: ReturnType
}
```

</details>

<div id="kind"></div>

### kind

```luau
"function"
```

<div id="generics"></div>

### generics

The optional generic declaration; the `<T>` in

`<T>(foo: T, ...bar) -> baz`.

*This field is optional and may not be specified*

[GenericDeclaration](#GenericDeclaration)?

<div id="parens"></div>

### parens

The parentheses surrounding the arguments; the `()` in

`<T>(foo: T, ...bar) -> baz`.

[Delim](#Delim)&lt;[TokenKind](#TokenKind)&lt;"("&gt;, [TokenKind](#TokenKind)&lt;")"&gt;&gt;<div id="params"></div>

### params

The parameters; the `foo: T,` in `<T>(foo: T, ...bar) -> baz`.

[Separated](#Separated)&lt;{name: {name: [TokenKind](#TokenKind)&lt;"ident"&gt;, colon: [TokenKind](#TokenKind)&lt;":"&gt;}?, type: [Type](#Type)}, [TokenKind](#TokenKind)&lt;","&gt;&gt;<div id="varargs"></div>

### varargs

The optional varargs; the `...bar` in `<T>(foo: T, ...bar) -> baz`.

*This field is optional and may not be specified*

[TailType](#TailType)?

<div id="arrow"></div>

### arrow

The arrow; the `->` in `<T>(foo: T, ...bar) -> baz`.

[TokenKind](#TokenKind)&lt;"-&gt;"&gt;<div id="ret"></div>

### ret

The return type; the `baz` in `<T>(foo: T, ...bar) -> baz`.

[ReturnType](#ReturnType)

<div id="Type_Paren"></div>

## Type_Paren

A parenthesized type, such as `(foo)` or `(bar)`.

<details>
<summary>Raw Type</summary>

```luau
--- A parenthesized type, such as `(foo)` or `(bar)`.
type Type_Paren = {
	kind: "paren",

	--- The parentheses surrounding the type; the `()` in `(foo)`.
	parens: Delim<TokenKind<"(">, TokenKind<")">>,

	--- The type; the `foo` in `(foo)`.
	type: Type
}
```

</details>

<div id="kind"></div>

### kind

```luau
"paren"
```

<div id="parens"></div>

### parens

The parentheses surrounding the type; the `()` in `(foo)`.

[Delim](#Delim)&lt;[TokenKind](#TokenKind)&lt;"("&gt;, [TokenKind](#TokenKind)&lt;")"&gt;&gt;<div id="type"></div>

### type

The type; the `foo` in `(foo)`.

[Type](#Type)

<div id="Type_Optional"></div>

## Type_Optional

An optional type, such as `foo?` or `bar?`.

<details>
<summary>Raw Type</summary>

```luau
--- An optional type, such as `foo?` or `bar?`.
type Type_Optional = {
	kind: "optional",

	--- The type; the `foo` in `foo?`.
	type: Type,

	--- The question mark; the `?` in `foo?`.
	question: TokenKind<"?">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"optional"
```

<div id="type"></div>

### type

The type; the `foo` in `foo?`.

[Type](#Type)

<div id="question"></div>

### question

The question mark; the `?` in `foo?`.

[TokenKind](#TokenKind)&lt;"?"&gt;<div id="Type_Union"></div>

## Type_Union

A union type, such as `| foo | bar` or `foo | bar`.

<details>
<summary>Raw Type</summary>

```luau
--- A union type, such as `| foo | bar` or `foo | bar`.
type Type_Union = {
	kind: "union",

	--- The optional leading pipe; the `|` in `| foo | bar`.
	leading: TokenKind<"|">?,

	--- The types; the `foo | bar` in `| foo | bar`.
	types: Separated<Type, TokenKind<"|">>
}
```

</details>

<div id="kind"></div>

### kind

```luau
"union"
```

<div id="leading"></div>

### leading

The optional leading pipe; the `|` in `| foo | bar`.

*This field is optional and may not be specified*

[TokenKind](#TokenKind)&lt;"|"&gt;?

<div id="types"></div>

### types

The types; the `foo | bar` in `| foo | bar`.

[Separated](#Separated)&lt;[Type](#Type), [TokenKind](#TokenKind)&lt;"|"&gt;&gt;<div id="Type_Intersection"></div>

## Type_Intersection

An intersection type, such as `& foo & bar` or `foo & bar`.

<details>
<summary>Raw Type</summary>

```luau
--- An intersection type, such as `& foo & bar` or `foo & bar`.
type Type_Intersection = {
	kind: "intersection",

	--- The optional leading ampersand; the `&` in `& foo & bar`.
	leading: TokenKind<"&">?,

	--- The types; the `foo & bar` in `& foo & bar`.
	types: Separated<Type, TokenKind<"&">>
}
```

</details>

<div id="kind"></div>

### kind

```luau
"intersection"
```

<div id="leading"></div>

### leading

The optional leading ampersand; the `&` in `& foo & bar`.

*This field is optional and may not be specified*

[TokenKind](#TokenKind)&lt;"&"&gt;?

<div id="types"></div>

### types

The types; the `foo & bar` in `& foo & bar`.

[Separated](#Separated)&lt;[Type](#Type), [TokenKind](#TokenKind)&lt;"&"&gt;&gt;<div id="Type"></div>

## Type

A type, such as `number` or `foo` or `{}`.



This node is used in many places, such as variable declarations, function

parameters, and type declarations themselves.

<details>
<summary>Raw Type</summary>

```luau
--- A type, such as `number` or `foo` or `{}`.
--- 
--- This node is used in many places, such as variable declarations, function
--- parameters, and type declarations themselves.
type Type = Type_Nil | Type_Boolean | Type_String | Type_Reference | Type_Typeof | Type_Array | Type_Table | Type_Function | Type_Paren | Type_Optional | Type_Union | Type_Intersection
```

</details>

([Type_Nil](#Type_Nil) | [Type_Boolean](#Type_Boolean) | [Type_String](#Type_String) | [Type_Reference](#Type_Reference) | [Type_Typeof](#Type_Typeof) | [Type_Array](#Type_Array) | [Type_Table](#Type_Table) | [Type_Function](#Type_Function) | [Type_Paren](#Type_Paren) | [Type_Optional](#Type_Optional) | [Type_Union](#Type_Union) | [Type_Intersection](#Type_Intersection))<div id="VariadicTypePack"></div>

## VariadicTypePack

A variadic type pack, such as `...foo` or `...number`.

<details>
<summary>Raw Type</summary>

```luau
--- A variadic type pack, such as `...foo` or `...number`.
type VariadicTypePack = {
	kind: "variadic",

	--- The dots; the `...` in `...foo`.
	dots: TokenKind<"...">,

	--- The type; the `foo` in `...foo`.
	type: Type
}
```

</details>

<div id="kind"></div>

### kind

```luau
"variadic"
```

<div id="dots"></div>

### dots

The dots; the `...` in `...foo`.

[TokenKind](#TokenKind)&lt;"..."&gt;<div id="type"></div>

### type

The type; the `foo` in `...foo`.

[Type](#Type)

<div id="GenericTypePack"></div>

## GenericTypePack

A generic type pack, such as `foo...` or `T...`.

<details>
<summary>Raw Type</summary>

```luau
--- A generic type pack, such as `foo...` or `T...`.
type GenericTypePack = {
	kind: "generic",

	--- The name; the `foo` in `foo...`.
	name: TokenKind<"ident">,

	--- The dots; the `...` in `foo...`.
	dots: TokenKind<"...">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"generic"
```

<div id="name"></div>

### name

The name; the `foo` in `foo...`.

[TokenKind](#TokenKind)&lt;"ident"&gt;<div id="dots"></div>

### dots

The dots; the `...` in `foo...`.

[TokenKind](#TokenKind)&lt;"..."&gt;<div id="TypeList"></div>

## TypeList

A type list, such as `(foo, bar, baz...)` or `(number...)`.

<details>
<summary>Raw Type</summary>

```luau
--- A type list, such as `(foo, bar, baz...)` or `(number...)`.
type TypeList = {
	kind: "list",

	--- The parentheses surrounding the type pack; the `()` in
	--- `(foo, bar, baz...)`.
	parens: Delim<TokenKind<"(">, TokenKind<")">>,

	--- The types; the `foo, bar,` in `(foo, bar, baz...)`.
	types: Separated<Type, TokenKind<",">>,

	--- The optional tail type pack; the `baz...` in `(foo, bar, baz...)`.
	tail: TailType?
}
```

</details>

<div id="kind"></div>

### kind

```luau
"list"
```

<div id="parens"></div>

### parens

The parentheses surrounding the type pack; the `()` in

`(foo, bar, baz...)`.

[Delim](#Delim)&lt;[TokenKind](#TokenKind)&lt;"("&gt;, [TokenKind](#TokenKind)&lt;")"&gt;&gt;<div id="types"></div>

### types

The types; the `foo, bar,` in `(foo, bar, baz...)`.

[Separated](#Separated)&lt;[Type](#Type), [TokenKind](#TokenKind)&lt;","&gt;&gt;<div id="tail"></div>

### tail

The optional tail type pack; the `baz...` in `(foo, bar, baz...)`.

*This field is optional and may not be specified*

[TailType](#TailType)?

<div id="TailType"></div>

## TailType

A tail type in a type pack, such as `...foo` or `bar...`.

<details>
<summary>Raw Type</summary>

```luau
--- A tail type in a type pack, such as `...foo` or `bar...`.
type TailType = VariadicTypePack | GenericTypePack
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

[VariadicTypePack](#VariadicTypePack)

</details>

<details>
<summary>Variant 2</summary>

[GenericTypePack](#GenericTypePack)

</details>

<div id="TypePack"></div>

## TypePack

A type pack, such as `...foo` or `foo...` or `(foo, bar, baz...)`.

<details>
<summary>Raw Type</summary>

```luau
--- A type pack, such as `...foo` or `foo...` or `(foo, bar, baz...)`.
type TypePack = VariadicTypePack | GenericTypePack | TypeList
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

[VariadicTypePack](#VariadicTypePack)

</details>

<details>
<summary>Variant 2</summary>

[GenericTypePack](#GenericTypePack)

</details>

<details>
<summary>Variant 3</summary>

[TypeList](#TypeList)

</details>

<div id="ReturnType"></div>

## ReturnType

A return type, such as `(foo, bar, baz...)` or `(foo | bar, baz)` or `foo`.

<details>
<summary>Raw Type</summary>

```luau
--- A return type, such as `(foo, bar, baz...)` or `(foo | bar, baz)` or `foo`.
type ReturnType = Type | TypePack
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

[Type](#Type)

</details>

<details>
<summary>Variant 2</summary>

[TypePack](#TypePack)

</details>

<div id="Binding"></div>

## Binding

A binding, such as `foo: bar` or `foo`.



This is used in a few places, such as function parameters and local variable

declarations.

<details>
<summary>Raw Type</summary>

```luau
--- A binding, such as `foo: bar` or `foo`.
--- 
--- This is used in a few places, such as function parameters and local variable
--- declarations.
type Binding = {
	--- The name; the `foo` in `foo: bar`.
	name: TokenKind<"ident">,

	--- The optional type; the `: bar` in `foo: bar`.
	type: {
		--- The colon; the `:` in `: bar`.
		colon: TokenKind<":">,

		--- The type; the `bar` in `: bar`.
		type: Type
	}?
}
```

</details>

<div id="name"></div>

### name

The name; the `foo` in `foo: bar`.

[TokenKind](#TokenKind)&lt;"ident"&gt;<div id="type"></div>

### type

The optional type; the `: bar` in `foo: bar`.

*This field is optional and may not be specified*

{colon: [TokenKind](#TokenKind)&lt;":"&gt;, type: [Type](#Type)}?

<div id="IString_Simple"></div>

## IString_Simple

An interpolated string with no exprs, such as `'simple'`.

<details>
<summary>Raw Type</summary>

```luau
--- An interpolated string with no exprs, such as `'simple'`.
type IString_Simple = {
	kind: "simple",

	--- The string token.
	tok: TokenKind<"istring_simple">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"simple"
```

<div id="tok"></div>

### tok

The string token.

[TokenKind](#TokenKind)&lt;"istring_simple"&gt;<div id="IString_Complex"></div>

## IString_Complex

An interpolated string with exprs, such as `'foo {1} bar {2} baz'` or

`'hello {"world"}'`.

<details>
<summary>Raw Type</summary>

```luau
--- An interpolated string with exprs, such as `'foo {1} bar {2} baz'` or
--- `'hello {"world"}'`.
type IString_Complex = {
	kind: "complex",

	--- The first segment; the `'foo {'` in `'foo {1} bar {2} baz'`.
	first: TokenKind<"istring_first">,

	--- The middle segments; the `1} bar {2` in `'foo {1} bar {2} baz'`.
	--- 
	--- This needs better documentation. Someone please remind me to do this.
	middle: Separated<Expr, TokenKind<"istring_middle">>,

	--- The last segment; the `} baz'` in `'foo {1} bar {2} baz'`.
	last: TokenKind<"istring_last">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"complex"
```

<div id="first"></div>

### first

The first segment; the `'foo {'` in `'foo {1} bar {2} baz'`.

[TokenKind](#TokenKind)&lt;"istring_first"&gt;<div id="middle"></div>

### middle

The middle segments; the `1} bar {2` in `'foo {1} bar {2} baz'`.



This needs better documentation. Someone please remind me to do this.

[Separated](#Separated)&lt;[Expr](#Expr), [TokenKind](#TokenKind)&lt;"istring_middle"&gt;&gt;<div id="last"></div>

### last

The last segment; the `} baz'` in `'foo {1} bar {2} baz'`.

[TokenKind](#TokenKind)&lt;"istring_last"&gt;<div id="IString"></div>

## IString

An interpolated string, such as `'simple'` or `'foo {1} bar {2} baz'` or

`'hello {"world"}'`.

<details>
<summary>Raw Type</summary>

```luau
--- An interpolated string, such as `'simple'` or `'foo {1} bar {2} baz'` or
--- `'hello {"world"}'`.
type IString = IString_Simple | IString_Complex
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

[IString_Simple](#IString_Simple)

</details>

<details>
<summary>Variant 2</summary>

[IString_Complex](#IString_Complex)

</details>

<div id="IfElseExprBranch"></div>

## IfElseExprBranch

A branch of an if-else expr, such as `foo then bar`.

<details>
<summary>Raw Type</summary>

```luau
--- A branch of an if-else expr, such as `foo then bar`.
type IfElseExprBranch = {
	--- The condition; the `foo` in `foo then bar`.
	condition: Expr,

	--- The `then` token; the `then` in `foo then bar`.
	then_tok: TokenKind<"then">,

	--- The body; the `bar` in `foo then bar`.
	body: Expr
}
```

</details>

<div id="condition"></div>

### condition

The condition; the `foo` in `foo then bar`.

[Expr](#Expr)

<div id="then_tok"></div>

### then_tok

The `then` token; the `then` in `foo then bar`.

[TokenKind](#TokenKind)&lt;"then"&gt;<div id="body"></div>

### body

The body; the `bar` in `foo then bar`.

[Expr](#Expr)

<div id="UnaryOperator"></div>

## UnaryOperator

An unary operator: `+`, `-`, `not`, or `#`.

<details>
<summary>Raw Type</summary>

```luau
--- An unary operator: `+`, `-`, `not`, or `#`.
type UnaryOperator = TokenKind<"+"> | TokenKind<"-"> | TokenKind<"not"> | TokenKind<"#">
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

[TokenKind](#TokenKind)&lt;"+"&gt;</details>

<details>
<summary>Variant 2</summary>

[TokenKind](#TokenKind)&lt;"-"&gt;</details>

<details>
<summary>Variant 3</summary>

[TokenKind](#TokenKind)&lt;"not"&gt;</details>

<details>
<summary>Variant 4</summary>

[TokenKind](#TokenKind)&lt;"#"&gt;</details>

<div id="BinaryOperator"></div>

## BinaryOperator

A binary operator: `+`, `-`, `*`, `/`, `//`, `%`, `^`, `..`, `<`, `<=`, `>`,

`>=`, `==`, `~=`, `and`, or `or`.

<details>
<summary>Raw Type</summary>

```luau
--- A binary operator: `+`, `-`, `*`, `/`, `//`, `%`, `^`, `..`, `<`, `<=`, `>`,
--- `>=`, `==`, `~=`, `and`, or `or`.
type BinaryOperator = TokenKind<"+"> | TokenKind<"-"> | TokenKind<"*"> | TokenKind<"/"> | TokenKind<"//"> | TokenKind<"%"> | TokenKind<"^"> | TokenKind<".."> | TokenKind<"<"> | TokenKind<"<="> | TokenKind<">"> | TokenKind<">="> | TokenKind<"=="> | TokenKind<"~="> | TokenKind<"and"> | TokenKind<"or">
```

</details>

([TokenKind](#TokenKind)&lt;"+"&gt; | [TokenKind](#TokenKind)&lt;"-"&gt; | [TokenKind](#TokenKind)&lt;"\*"&gt; | [TokenKind](#TokenKind)&lt;"/"&gt; | [TokenKind](#TokenKind)&lt;"//"&gt; | [TokenKind](#TokenKind)&lt;"%"&gt; | [TokenKind](#TokenKind)&lt;"^"&gt; | [TokenKind](#TokenKind)&lt;".."&gt; | [TokenKind](#TokenKind)&lt;"&lt;"&gt; | [TokenKind](#TokenKind)&lt;"&lt;="&gt; | [TokenKind](#TokenKind)&lt;"&gt;"&gt; | [TokenKind](#TokenKind)&lt;"&gt;="&gt; | [TokenKind](#TokenKind)&lt;"=="&gt; | [TokenKind](#TokenKind)&lt;"~="&gt; | [TokenKind](#TokenKind)&lt;"and"&gt; | [TokenKind](#TokenKind)&lt;"or"&gt;)<div id="Expr_Nil"></div>

## Expr_Nil

The literal expr `nil`.

<details>
<summary>Raw Type</summary>

```luau
--- The literal expr `nil`.
type Expr_Nil = {
	kind: "nil",

	--- The `nil` token.
	tok: TokenKind<"nil">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"nil"
```

<div id="tok"></div>

### tok

The `nil` token.

[TokenKind](#TokenKind)&lt;"nil"&gt;<div id="Expr_Boolean"></div>

## Expr_Boolean

The literal expr `true` and `false`.

<details>
<summary>Raw Type</summary>

```luau
--- The literal expr `true` and `false`.
type Expr_Boolean = {
	kind: "boolean",

	--- The `true` or `false` token.
	tok: TokenKind<"true"> | TokenKind<"false">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"boolean"
```

<div id="tok"></div>

### tok

The `true` or `false` token.

Union with variants:

<details>
<summary>Variant 1</summary>

[TokenKind](#TokenKind)&lt;"true"&gt;</details>

<details>
<summary>Variant 2</summary>

[TokenKind](#TokenKind)&lt;"false"&gt;</details>

<div id="Expr_Number"></div>

## Expr_Number

A number literal expr, such as `123` or `0xABCD`.

<details>
<summary>Raw Type</summary>

```luau
--- A number literal expr, such as `123` or `0xABCD`.
type Expr_Number = {
	kind: "number",

	--- The number token.
	tok: TokenKind<"number">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"number"
```

<div id="tok"></div>

### tok

The number token.

[TokenKind](#TokenKind)&lt;"number"&gt;<div id="Expr_String"></div>

## Expr_String

A string literal expr, such as `"foo"` or `'bar'` or `[[baz]]`.

<details>
<summary>Raw Type</summary>

```luau
--- A string literal expr, such as `"foo"` or `'bar'` or `[[baz]]`.
type Expr_String = {
	kind: "string",

	--- The string token.
	tok: TokenKind<"string">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"string"
```

<div id="tok"></div>

### tok

The string token.

[TokenKind](#TokenKind)&lt;"string"&gt;<div id="Expr_Varargs"></div>

## Expr_Varargs

The literal expr `...`.

<details>
<summary>Raw Type</summary>

```luau
--- The literal expr `...`.
type Expr_Varargs = {
	kind: "varargs",

	--- The `...` token.
	tok: TokenKind<"...">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"varargs"
```

<div id="tok"></div>

### tok

The `...` token.

[TokenKind](#TokenKind)&lt;"..."&gt;<div id="Expr_IString"></div>

## Expr_IString

An interpolated string expr, such as `'simple'` or

`'foo {1} bar {2} baz'` or `'hello {"world"}'`.

<details>
<summary>Raw Type</summary>

```luau
--- An interpolated string expr, such as `'simple'` or
--- `'foo {1} bar {2} baz'` or `'hello {"world"}'`.
type Expr_IString = {
	kind: "istring",

	--- The interpolated string; the `'simple'` in `'simple'`.
	istring: IString
}
```

</details>

<div id="kind"></div>

### kind

```luau
"istring"
```

<div id="istring"></div>

### istring

The interpolated string; the `'simple'` in `'simple'`.

[IString](#IString)

<div id="Expr_Table"></div>

## Expr_Table

A table literal expr, such as `{ foo = bar }` or `{ 1, 2, 3 }`.

<details>
<summary>Raw Type</summary>

```luau
--- A table literal expr, such as `{ foo = bar }` or `{ 1, 2, 3 }`.
type Expr_Table = {
	kind: "table",

	--- The table literal.
	table: Table
}
```

</details>

<div id="kind"></div>

### kind

```luau
"table"
```

<div id="table"></div>

### table

The table literal.

[Table](#Table)

<div id="Expr_Function"></div>

## Expr_Function

An anonymous function expr, such as

`@native function(foo, bar) return foo + bar end` or `function() end`.

<details>
<summary>Raw Type</summary>

```luau
--- An anonymous function expr, such as
--- `@native function(foo, bar) return foo + bar end` or `function() end`.
type Expr_Function = {
	kind: "function",

	--- The function attributes; the `@native` in
	--- `@native function(foo, bar) return foo + bar end`.
	attributes: {TokenKind<"attribute">},

	--- The `function` token.
	function_tok: TokenKind<"function">,

	--- The function body; the `(foo, bar) return foo + bar end` in
	--- `@native function(foo, bar) return foo + bar end`.
	body: FunctionBody
}
```

</details>

<div id="kind"></div>

### kind

```luau
"function"
```

<div id="attributes"></div>

### attributes

The function attributes; the `@native` in

`@native function(foo, bar) return foo + bar end`.

{[TokenKind](#TokenKind)&lt;"attribute"&gt;}

<div id="function_tok"></div>

### function_tok

The `function` token.

[TokenKind](#TokenKind)&lt;"function"&gt;<div id="body"></div>

### body

The function body; the `(foo, bar) return foo + bar end` in

`@native function(foo, bar) return foo + bar end`.

[FunctionBody](#FunctionBody)

<div id="Expr_IfElse"></div>

## Expr_IfElse

An if-else expr, such as `if foo then bar elseif baz then qux else quux`.

<details>
<summary>Raw Type</summary>

```luau
--- An if-else expr, such as `if foo then bar elseif baz then qux else quux`.
type Expr_IfElse = {
	kind: "ifelse",

	--- The `if` token; the `if` in
	--- `if foo then bar elseif baz then qux else quux`.
	if_tok: TokenKind<"if">,

	--- The branches; the `foo then bar elseif baz then qux` in
	--- `if foo then bar elseif baz then qux else quux`.
	branches: Separated<IfElseExprBranch, TokenKind<"elseif">>,

	--- The `else` token; the `else` in
	--- `if foo then bar elseif baz then qux else quux`.
	else_tok: TokenKind<"else">,

	--- The else body; the `quux` in
	--- `if foo then bar elseif baz then qux else quux`.
	else_body: Expr
}
```

</details>

<div id="kind"></div>

### kind

```luau
"ifelse"
```

<div id="if_tok"></div>

### if_tok

The `if` token; the `if` in

`if foo then bar elseif baz then qux else quux`.

[TokenKind](#TokenKind)&lt;"if"&gt;<div id="branches"></div>

### branches

The branches; the `foo then bar elseif baz then qux` in

`if foo then bar elseif baz then qux else quux`.

[Separated](#Separated)&lt;[IfElseExprBranch](#IfElseExprBranch), [TokenKind](#TokenKind)&lt;"elseif"&gt;&gt;<div id="else_tok"></div>

### else_tok

The `else` token; the `else` in

`if foo then bar elseif baz then qux else quux`.

[TokenKind](#TokenKind)&lt;"else"&gt;<div id="else_body"></div>

### else_body

The else body; the `quux` in

`if foo then bar elseif baz then qux else quux`.

[Expr](#Expr)

<div id="Expr_Var"></div>

## Expr_Var

A var expr, such as `foo.bar[baz]()` or `foo`.

<details>
<summary>Raw Type</summary>

```luau
--- A var expr, such as `foo.bar[baz]()` or `foo`.
type Expr_Var = {
	kind: "var",

	--- The var.
	var: Var
}
```

</details>

<div id="kind"></div>

### kind

```luau
"var"
```

<div id="var"></div>

### var

The var.

[Var](#Var)

<div id="Expr_Assertion"></div>

## Expr_Assertion

A type assertion expr, such as `foo :: bar` or `{} :: { number }`.

<details>
<summary>Raw Type</summary>

```luau
--- A type assertion expr, such as `foo :: bar` or `{} :: { number }`.
type Expr_Assertion = {
	kind: "assertion",

	--- The expr; the `foo` in `foo :: bar`.
	expr: Expr,

	--- The double colon; the `::` in `foo :: bar`.
	colon: TokenKind<"::">,

	--- The type; the `bar` in `foo :: bar`.
	type: Type
}
```

</details>

<div id="kind"></div>

### kind

```luau
"assertion"
```

<div id="expr"></div>

### expr

The expr; the `foo` in `foo :: bar`.

[Expr](#Expr)

<div id="colon"></div>

### colon

The double colon; the `::` in `foo :: bar`.

[TokenKind](#TokenKind)&lt;"::"&gt;<div id="type"></div>

### type

The type; the `bar` in `foo :: bar`.

[Type](#Type)

<div id="Expr_Unary"></div>

## Expr_Unary

An unary expr, such as `-foo` or `not bar`.

<details>
<summary>Raw Type</summary>

```luau
--- An unary expr, such as `-foo` or `not bar`.
type Expr_Unary = {
	kind: "unary",

	--- The operator; the `-` in `-foo`.
	operator: UnaryOperator,

	--- The expr; the `foo` in `-foo`.
	expr: Expr
}
```

</details>

<div id="kind"></div>

### kind

```luau
"unary"
```

<div id="operator"></div>

### operator

The operator; the `-` in `-foo`.

[UnaryOperator](#UnaryOperator)

<div id="expr"></div>

### expr

The expr; the `foo` in `-foo`.

[Expr](#Expr)

<div id="Expr_Binary"></div>

## Expr_Binary

A binary expr, such as `foo + bar` or `baz and qux`.

<details>
<summary>Raw Type</summary>

```luau
--- A binary expr, such as `foo + bar` or `baz and qux`.
type Expr_Binary = {
	kind: "binary",

	--- The left expr; the `foo` in `foo + bar`.
	left: Expr,

	--- The operator; the `+` in `foo + bar`.
	operator: BinaryOperator,

	--- The right expr; the `bar` in `foo + bar`.
	right: Expr
}
```

</details>

<div id="kind"></div>

### kind

```luau
"binary"
```

<div id="left"></div>

### left

The left expr; the `foo` in `foo + bar`.

[Expr](#Expr)

<div id="operator"></div>

### operator

The operator; the `+` in `foo + bar`.

[BinaryOperator](#BinaryOperator)

<div id="right"></div>

### right

The right expr; the `bar` in `foo + bar`.

[Expr](#Expr)

<div id="Expr"></div>

## Expr

An expression, such as `nil` or `foo` or `foo + bar`.



This node is used in many places, such as function arguments, table fields,

variable assignments, and return stats.

<details>
<summary>Raw Type</summary>

```luau
--- An expression, such as `nil` or `foo` or `foo + bar`.
--- 
--- This node is used in many places, such as function arguments, table fields,
--- variable assignments, and return stats.
type Expr = Expr_Nil | Expr_Boolean | Expr_Number | Expr_String | Expr_Varargs | Expr_IString | Expr_Table | Expr_Function | Expr_IfElse | Expr_Var | Expr_Assertion | Expr_Unary | Expr_Binary
```

</details>

([Expr_Nil](#Expr_Nil) | [Expr_Boolean](#Expr_Boolean) | [Expr_Number](#Expr_Number) | [Expr_String](#Expr_String) | [Expr_Varargs](#Expr_Varargs) | [Expr_IString](#Expr_IString) | [Expr_Table](#Expr_Table) | [Expr_Function](#Expr_Function) | [Expr_IfElse](#Expr_IfElse) | [Expr_Var](#Expr_Var) | [Expr_Assertion](#Expr_Assertion) | [Expr_Unary](#Expr_Unary) | [Expr_Binary](#Expr_Binary))<div id="FunctionArg_Pack"></div>

## FunctionArg_Pack

Pack argument to a call, such as `(foo, bar)` or `()`.

<details>
<summary>Raw Type</summary>

```luau
--- Pack argument to a call, such as `(foo, bar)` or `()`.
type FunctionArg_Pack = {
	kind: "pack",

	--- The parens surrounding the pack; the `()` in `()`.
	parens: Delim<TokenKind<"(">, TokenKind<")">>,

	--- The exprs; the `foo, bar` in `(foo, bar)`.
	exprs: Separated<Expr, TokenKind<",">>
}
```

</details>

<div id="kind"></div>

### kind

```luau
"pack"
```

<div id="parens"></div>

### parens

The parens surrounding the pack; the `()` in `()`.

[Delim](#Delim)&lt;[TokenKind](#TokenKind)&lt;"("&gt;, [TokenKind](#TokenKind)&lt;")"&gt;&gt;<div id="exprs"></div>

### exprs

The exprs; the `foo, bar` in `(foo, bar)`.

[Separated](#Separated)&lt;[Expr](#Expr), [TokenKind](#TokenKind)&lt;","&gt;&gt;<div id="FunctionArg_Table"></div>

## FunctionArg_Table

Table argument to a call, such as `{ foo = bar }` or `{}`.

<details>
<summary>Raw Type</summary>

```luau
--- Table argument to a call, such as `{ foo = bar }` or `{}`.
type FunctionArg_Table = {
	kind: "table",

	--- The table literal.
	table: Table
}
```

</details>

<div id="kind"></div>

### kind

```luau
"table"
```

<div id="table"></div>

### table

The table literal.

[Table](#Table)

<div id="FunctionArg_String"></div>

## FunctionArg_String

String argument to a call, such as `"foo"` or `'bar'`.

<details>
<summary>Raw Type</summary>

```luau
--- String argument to a call, such as `"foo"` or `'bar'`.
type FunctionArg_String = {
	kind: "string",

	--- The string token.
	tok: TokenKind<"string">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"string"
```

<div id="tok"></div>

### tok

The string token.

[TokenKind](#TokenKind)&lt;"string"&gt;<div id="FunctionArg"></div>

## FunctionArg

An argument to a call, such as `(foo, bar)` or `()` or `"baz"`.

<details>
<summary>Raw Type</summary>

```luau
--- An argument to a call, such as `(foo, bar)` or `()` or `"baz"`.
type FunctionArg = FunctionArg_Pack | FunctionArg_Table | FunctionArg_String
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

[FunctionArg_Pack](#FunctionArg_Pack)

</details>

<details>
<summary>Variant 2</summary>

[FunctionArg_Table](#FunctionArg_Table)

</details>

<details>
<summary>Variant 3</summary>

[FunctionArg_String](#FunctionArg_String)

</details>

<div id="VarRoot_Name"></div>

## VarRoot_Name

A name as a variable, such as `foo`.

<details>
<summary>Raw Type</summary>

```luau
--- A name as a variable, such as `foo`.
type VarRoot_Name = {
	kind: "name",

	--- The name token.
	tok: TokenKind<"ident">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"name"
```

<div id="tok"></div>

### tok

The name token.

[TokenKind](#TokenKind)&lt;"ident"&gt;<div id="VarRoot_Paren"></div>

## VarRoot_Paren

A parenthesized expr, such as `(foo)` or `(1 + 1)`.

<details>
<summary>Raw Type</summary>

```luau
--- A parenthesized expr, such as `(foo)` or `(1 + 1)`.
type VarRoot_Paren = {
	kind: "paren",

	--- The parentheses surrounding the expr; the `()` in `(foo)`.
	parens: Delim<TokenKind<"(">, TokenKind<")">>,

	--- The expr; the `foo` in `(foo)`.
	expr: Expr
}
```

</details>

<div id="kind"></div>

### kind

```luau
"paren"
```

<div id="parens"></div>

### parens

The parentheses surrounding the expr; the `()` in `(foo)`.

[Delim](#Delim)&lt;[TokenKind](#TokenKind)&lt;"("&gt;, [TokenKind](#TokenKind)&lt;")"&gt;&gt;<div id="expr"></div>

### expr

The expr; the `foo` in `(foo)`.

[Expr](#Expr)

<div id="VarRoot"></div>

## VarRoot

The root of a variable, such as `foo` or `(foo)`.

<details>
<summary>Raw Type</summary>

```luau
--- The root of a variable, such as `foo` or `(foo)`.
type VarRoot = VarRoot_Name | VarRoot_Paren
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

[VarRoot_Name](#VarRoot_Name)

</details>

<details>
<summary>Variant 2</summary>

[VarRoot_Paren](#VarRoot_Paren)

</details>

<div id="VarSuffix_NameIndex"></div>

## VarSuffix_NameIndex

A named index, such as `root.foo` or `root.bar`.

<details>
<summary>Raw Type</summary>

```luau
--- A named index, such as `root.foo` or `root.bar`.
type VarSuffix_NameIndex = {
	kind: "nameindex",

	--- The dot; the `.` in `.foo`.
	dot: TokenKind<".">,

	--- The name; the `foo` in `.foo`.
	name: TokenKind<"ident">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"nameindex"
```

<div id="dot"></div>

### dot

The dot; the `.` in `.foo`.

[TokenKind](#TokenKind)&lt;"."&gt;<div id="name"></div>

### name

The name; the `foo` in `.foo`.

[TokenKind](#TokenKind)&lt;"ident"&gt;<div id="VarSuffix_ExprIndex"></div>

## VarSuffix_ExprIndex

An expr index, such as `root[foo]` or `root[1 + 1]`.

<details>
<summary>Raw Type</summary>

```luau
--- An expr index, such as `root[foo]` or `root[1 + 1]`.
type VarSuffix_ExprIndex = {
	kind: "exprindex",

	--- The brackets surrounding the expr; the `[]` in `[foo]`.
	bracks: Delim<TokenKind<"[">, TokenKind<"]">>,

	--- The expr; the `foo` in `[foo]`.
	expr: Expr
}
```

</details>

<div id="kind"></div>

### kind

```luau
"exprindex"
```

<div id="bracks"></div>

### bracks

The brackets surrounding the expr; the `[]` in `[foo]`.

[Delim](#Delim)&lt;[TokenKind](#TokenKind)&lt;"["&gt;, [TokenKind](#TokenKind)&lt;"]"&gt;&gt;<div id="expr"></div>

### expr

The expr; the `foo` in `[foo]`.

[Expr](#Expr)

<div id="VarSuffix_Call"></div>

## VarSuffix_Call

A call, such as `root:method(foo)` or `root()`.

<details>
<summary>Raw Type</summary>

```luau
--- A call, such as `root:method(foo)` or `root()`.
type VarSuffix_Call = {
	kind: "call",

	--- The optional method; the `:method` in `root:method(foo)`.
	method: {
		--- The colon; the `:` in `:method`.
		colon: TokenKind<":">,

		--- The name; the `method` in `:method`.
		name: TokenKind<"ident">
	}?,

	--- The argument; the `(foo)` in `root:method(foo)`.
	arg: FunctionArg
}
```

</details>

<div id="kind"></div>

### kind

```luau
"call"
```

<div id="method"></div>

### method

The optional method; the `:method` in `root:method(foo)`.

*This field is optional and may not be specified*

{colon: [TokenKind](#TokenKind)&lt;":"&gt;, name: [TokenKind](#TokenKind)&lt;"ident"&gt;}?

<div id="arg"></div>

### arg

The argument; the `(foo)` in `root:method(foo)`.

[FunctionArg](#FunctionArg)

<div id="VarSuffix"></div>

## VarSuffix

A suffix of a variable, such as `.foo` or `[bar]` or `()`.

<details>
<summary>Raw Type</summary>

```luau
--- A suffix of a variable, such as `.foo` or `[bar]` or `()`.
type VarSuffix = VarSuffix_NameIndex | VarSuffix_ExprIndex | VarSuffix_Call
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

[VarSuffix_NameIndex](#VarSuffix_NameIndex)

</details>

<details>
<summary>Variant 2</summary>

[VarSuffix_ExprIndex](#VarSuffix_ExprIndex)

</details>

<details>
<summary>Variant 3</summary>

[VarSuffix_Call](#VarSuffix_Call)

</details>

<div id="Var"></div>

## Var

A variable, such as `foo` or `foo.bar()[baz]`.



This node is used in exprs, assignments, and function calls. This is

essentially anything that can appear on the left side of an assignment stat

or before a function call.



As an example:

<details>
<summary>Raw Type</summary>

```luau
--- A variable, such as `foo` or `foo.bar()[baz]`.
--- 
--- This node is used in exprs, assignments, and function calls. This is
--- essentially anything that can appear on the left side of an assignment stat
--- or before a function call.
--- 
--- As an example:
type Var = {
	--- The root of the variable; the `foo` in `foo.bar()[baz]`.
	root: VarRoot,

	--- The suffixes of the variable; the `.bar()[baz]` in `foo.bar()[baz]`.
	suffixes: {VarSuffix}
}
```

</details>

<div id="root"></div>

### root

The root of the variable; the `foo` in `foo.bar()[baz]`.

[VarRoot](#VarRoot)

<div id="suffixes"></div>

### suffixes

The suffixes of the variable; the `.bar()[baz]` in `foo.bar()[baz]`.

{[VarSuffix](#VarSuffix)}

<div id="TableField_NameKey"></div>

## TableField_NameKey

A table field with a name key, such as `foo = bar` or `bar = 1`.

<details>
<summary>Raw Type</summary>

```luau
--- A table field with a name key, such as `foo = bar` or `bar = 1`.
type TableField_NameKey = {
	kind: "namekey",

	--- The name; the `foo` in `foo = bar`.
	name: TokenKind<"ident">,

	--- The equals sign; the `=` in `foo = bar`.
	equals: TokenKind<"=">,

	--- The value; the `bar` in `foo = bar`.
	value: Expr
}
```

</details>

<div id="kind"></div>

### kind

```luau
"namekey"
```

<div id="name"></div>

### name

The name; the `foo` in `foo = bar`.

[TokenKind](#TokenKind)&lt;"ident"&gt;<div id="equals"></div>

### equals

The equals sign; the `=` in `foo = bar`.

[TokenKind](#TokenKind)&lt;"="&gt;<div id="value"></div>

### value

The value; the `bar` in `foo = bar`.

[Expr](#Expr)

<div id="TableField_ExprKey"></div>

## TableField_ExprKey

A table field with an expr key, such as `[foo] = bar` or `[1] = 2`.

<details>
<summary>Raw Type</summary>

```luau
--- A table field with an expr key, such as `[foo] = bar` or `[1] = 2`.
type TableField_ExprKey = {
	kind: "exprkey",

	--- The brackets surrounding the key; the `[]` in `[foo] = bar`.
	bracks: Delim<TokenKind<"[">, TokenKind<"]">>,

	--- The key; the `foo` in `[foo] = bar`.
	key: Expr,

	--- The equals sign; the `=` in `[foo] = bar`.
	equals: TokenKind<"=">,

	--- The value; the `bar` in `[foo] = bar`.
	value: Expr
}
```

</details>

<div id="kind"></div>

### kind

```luau
"exprkey"
```

<div id="bracks"></div>

### bracks

The brackets surrounding the key; the `[]` in `[foo] = bar`.

[Delim](#Delim)&lt;[TokenKind](#TokenKind)&lt;"["&gt;, [TokenKind](#TokenKind)&lt;"]"&gt;&gt;<div id="key"></div>

### key

The key; the `foo` in `[foo] = bar`.

[Expr](#Expr)

<div id="equals"></div>

### equals

The equals sign; the `=` in `[foo] = bar`.

[TokenKind](#TokenKind)&lt;"="&gt;<div id="value"></div>

### value

The value; the `bar` in `[foo] = bar`.

[Expr](#Expr)

<div id="TableField_NoKey"></div>

## TableField_NoKey

A table field with no key, such as `foo` or `1`.

<details>
<summary>Raw Type</summary>

```luau
--- A table field with no key, such as `foo` or `1`.
type TableField_NoKey = {
	kind: "nokey",

	--- The value; the `foo` in `foo`.
	value: Expr
}
```

</details>

<div id="kind"></div>

### kind

```luau
"nokey"
```

<div id="value"></div>

### value

The value; the `foo` in `foo`.

[Expr](#Expr)

<div id="TableField"></div>

## TableField

A table field, such as `foo = bar` or `[baz] = qux` or `quux`.

<details>
<summary>Raw Type</summary>

```luau
--- A table field, such as `foo = bar` or `[baz] = qux` or `quux`.
type TableField = TableField_NameKey | TableField_ExprKey | TableField_NoKey
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

[TableField_NameKey](#TableField_NameKey)

</details>

<details>
<summary>Variant 2</summary>

[TableField_ExprKey](#TableField_ExprKey)

</details>

<details>
<summary>Variant 3</summary>

[TableField_NoKey](#TableField_NoKey)

</details>

<div id="Table"></div>

## Table

A table literal, such as `{ foo = bar, [baz] = qux, quux }`.

<details>
<summary>Raw Type</summary>

```luau
--- A table literal, such as `{ foo = bar, [baz] = qux, quux }`.
type Table = {
	--- The braces surrounding the table; the `{}` in `{ foo = bar }`.
	braces: Delim<TokenKind<"{">, TokenKind<"}">>,

	--- The fields; the `foo = bar` in `{ foo = bar }`.
	fields: Separated<TableField, TokenKind<","> | TokenKind<";">>
}
```

</details>

<div id="braces"></div>

### braces

The braces surrounding the table; the `{}` in `{ foo = bar }`.

[Delim](#Delim)&lt;[TokenKind](#TokenKind)&lt;"{"&gt;, [TokenKind](#TokenKind)&lt;"}"&gt;&gt;<div id="fields"></div>

### fields

The fields; the `foo = bar` in `{ foo = bar }`.

[Separated](#Separated)&lt;[TableField](#TableField), ([TokenKind](#TokenKind)&lt;","&gt; | [TokenKind](#TokenKind)&lt;";"&gt;)&gt;<div id="FunctionBody"></div>

## FunctionBody

A function body, such as `<T>(foo: T, ...: bar): baz return 10 end`.



This is used in anonymous functions, function declarations, and local

function declarations.

<details>
<summary>Raw Type</summary>

```luau
--- A function body, such as `<T>(foo: T, ...: bar): baz return 10 end`.
--- 
--- This is used in anonymous functions, function declarations, and local
--- function declarations.
type FunctionBody = {
	--- The optional generic declaration; the `<T>` in
	--- `<T>(foo: T, ...: bar): baz return 10 end`.
	generics: GenericDeclaration?,

	--- The parentheses surrounding the parameters; the `()` in
	--- `<T>(foo: T, ...: bar): baz return 10 end`.
	parens: Delim<TokenKind<"(">, TokenKind<")">>,

	--- The parameters; the `foo: T,` in
	--- `<T>(foo: T, ...: bar): baz return 10 end`.
	params: Separated<Binding, TokenKind<",">>,

	--- The optional varargs; the `...: bar` in
	--- `<T>(foo: T, ...: bar): baz return 10 end`.
	varargs: {
		--- The dots; the `...` in `...: bar`.
		dots: TokenKind<"...">,

		--- The optional type; the `: bar` in `...: bar`.
		type: {
			--- The colon; the `:` in `: bar`.
			colon: TokenKind<":">,

			--- The type; the `bar` in `: bar`.
			type: Type | GenericTypePack
		}?
	}?,

	--- The return type; the `: baz` in
	--- `<T>(foo: T, ...: bar): baz return 10 end`.
	ret: {
		--- The colon; the `:` in `: baz`.
		colon: TokenKind<":">,

		--- The type; the `baz` in `: baz`.
		type: ReturnType
	}?,

	--- The block; the `return 10` in
	--- `<T>(foo: T, ...: bar): baz return 10 end`.
	block: Block,

	--- The `end` token; the `end` in
	--- `<T>(foo: T, ...: bar): baz return 10 end`.
	end_tok: TokenKind<"end">
}
```

</details>

<div id="generics"></div>

### generics

The optional generic declaration; the `<T>` in

`<T>(foo: T, ...: bar): baz return 10 end`.

*This field is optional and may not be specified*

[GenericDeclaration](#GenericDeclaration)?

<div id="parens"></div>

### parens

The parentheses surrounding the parameters; the `()` in

`<T>(foo: T, ...: bar): baz return 10 end`.

[Delim](#Delim)&lt;[TokenKind](#TokenKind)&lt;"("&gt;, [TokenKind](#TokenKind)&lt;")"&gt;&gt;<div id="params"></div>

### params

The parameters; the `foo: T,` in

`<T>(foo: T, ...: bar): baz return 10 end`.

[Separated](#Separated)&lt;[Binding](#Binding), [TokenKind](#TokenKind)&lt;","&gt;&gt;<div id="varargs"></div>

### varargs

The optional varargs; the `...: bar` in

`<T>(foo: T, ...: bar): baz return 10 end`.

*This field is optional and may not be specified*

{dots: [TokenKind](#TokenKind)&lt;"..."&gt;, type: {colon: [TokenKind](#TokenKind)&lt;":"&gt;, type: ([Type](#Type) | [GenericTypePack](#GenericTypePack))}?}?

<div id="ret"></div>

### ret

The return type; the `: baz` in

`<T>(foo: T, ...: bar): baz return 10 end`.

*This field is optional and may not be specified*

{colon: [TokenKind](#TokenKind)&lt;":"&gt;, type: [ReturnType](#ReturnType)}?

<div id="block"></div>

### block

The block; the `return 10` in

`<T>(foo: T, ...: bar): baz return 10 end`.

[Block](#Block)

<div id="end_tok"></div>

### end_tok

The `end` token; the `end` in

`<T>(foo: T, ...: bar): baz return 10 end`.

[TokenKind](#TokenKind)&lt;"end"&gt;<div id="IfStatBranch"></div>

## IfStatBranch

A branch in an if stat, such as `foo then bar()`

<details>
<summary>Raw Type</summary>

```luau
--- A branch in an if stat, such as `foo then bar()`
type IfStatBranch = {
	--- The condition; the `foo` in `foo then bar()`.
	condition: Expr,

	--- The `then` token.
	then_tok: TokenKind<"then">,

	--- The block; the `bar()` in `foo then bar()`.
	block: Block
}
```

</details>

<div id="condition"></div>

### condition

The condition; the `foo` in `foo then bar()`.

[Expr](#Expr)

<div id="then_tok"></div>

### then_tok

The `then` token.

[TokenKind](#TokenKind)&lt;"then"&gt;<div id="block"></div>

### block

The block; the `bar()` in `foo then bar()`.

[Block](#Block)

<div id="CompoundOperator"></div>

## CompoundOperator

A compound operator: `+=`, `-=`, `*=`, `/=`, `//=`, `%=`, `*=`, `or `..=`.

<details>
<summary>Raw Type</summary>

```luau
--- A compound operator: `+=`, `-=`, `*=`, `/=`, `//=`, `%=`, `*=`, `or `..=`.
type CompoundOperator = TokenKind<"+="> | TokenKind<"-="> | TokenKind<"*="> | TokenKind<"/="> | TokenKind<"//="> | TokenKind<"%="> | TokenKind<"^="> | TokenKind<"..=">
```

</details>

([TokenKind](#TokenKind)&lt;"+="&gt; | [TokenKind](#TokenKind)&lt;"-="&gt; | [TokenKind](#TokenKind)&lt;"\*="&gt; | [TokenKind](#TokenKind)&lt;"/="&gt; | [TokenKind](#TokenKind)&lt;"//="&gt; | [TokenKind](#TokenKind)&lt;"%="&gt; | [TokenKind](#TokenKind)&lt;"^="&gt; | [TokenKind](#TokenKind)&lt;"..="&gt;)<div id="Stat_Assign"></div>

## Stat_Assign

An assignment stat, such as `foo, bar = baz, qux` or `foo = bar`.

<details>
<summary>Raw Type</summary>

```luau
--- An assignment stat, such as `foo, bar = baz, qux` or `foo = bar`.
type Stat_Assign = {
	kind: "assign",

	--- The left side of the assignment; the `foo, bar` in
	--- `foo, bar = baz, qux`.
	left: Separated<Var, TokenKind<",">>,

	--- The equals sign; the `=` in `foo, bar = baz, qux`.
	equals: TokenKind<"=">,

	--- The right side of the assignment; the `baz, qux` in
	--- `foo, bar = baz, qux`.
	right: Separated<Expr, TokenKind<",">>
}
```

</details>

<div id="kind"></div>

### kind

```luau
"assign"
```

<div id="left"></div>

### left

The left side of the assignment; the `foo, bar` in

`foo, bar = baz, qux`.

[Separated](#Separated)&lt;[Var](#Var), [TokenKind](#TokenKind)&lt;","&gt;&gt;<div id="equals"></div>

### equals

The equals sign; the `=` in `foo, bar = baz, qux`.

[TokenKind](#TokenKind)&lt;"="&gt;<div id="right"></div>

### right

The right side of the assignment; the `baz, qux` in

`foo, bar = baz, qux`.

[Separated](#Separated)&lt;[Expr](#Expr), [TokenKind](#TokenKind)&lt;","&gt;&gt;<div id="Stat_CompoundAssign"></div>

## Stat_CompoundAssign

A compound assignment stat, such as `foo += bar`.

<details>
<summary>Raw Type</summary>

```luau
--- A compound assignment stat, such as `foo += bar`.
type Stat_CompoundAssign = {
	kind: "compoundassign",

	--- The left side of the assignment; the `foo` in `foo += bar`.
	left: Var,

	--- The compound operator; the `+=` in `foo += bar`.
	operator: CompoundOperator,

	--- The right side of the assignment; the `bar` in `foo += bar`.
	right: Expr
}
```

</details>

<div id="kind"></div>

### kind

```luau
"compoundassign"
```

<div id="left"></div>

### left

The left side of the assignment; the `foo` in `foo += bar`.

[Var](#Var)

<div id="operator"></div>

### operator

The compound operator; the `+=` in `foo += bar`.

[CompoundOperator](#CompoundOperator)

<div id="right"></div>

### right

The right side of the assignment; the `bar` in `foo += bar`.

[Expr](#Expr)

<div id="Stat_Call"></div>

## Stat_Call

A function call stat, such as `foo.bar()` or `baz()`.

<details>
<summary>Raw Type</summary>

```luau
--- A function call stat, such as `foo.bar()` or `baz()`.
type Stat_Call = {
	kind: "call",

	--- A var ending with a call suffix.
	--- 
	--- This call not ending with a call suffix will result in a syntax error
	--- when emitted.
	call: Var
}
```

</details>

<div id="kind"></div>

### kind

```luau
"call"
```

<div id="call"></div>

### call

A var ending with a call suffix.



This call not ending with a call suffix will result in a syntax error

when emitted.

[Var](#Var)

<div id="Stat_Do"></div>

## Stat_Do

A do stat, such as `do foo() end`.

<details>
<summary>Raw Type</summary>

```luau
--- A do stat, such as `do foo() end`.
type Stat_Do = {
	kind: "do",

	--- The `do` token.
	do_tok: TokenKind<"do">,

	--- The block within the do; the `foo()` in `do foo() end`.
	block: Block,

	--- The `end` token.
	end_tok: TokenKind<"end">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"do"
```

<div id="do_tok"></div>

### do_tok

The `do` token.

[TokenKind](#TokenKind)&lt;"do"&gt;<div id="block"></div>

### block

The block within the do; the `foo()` in `do foo() end`.

[Block](#Block)

<div id="end_tok"></div>

### end_tok

The `end` token.

[TokenKind](#TokenKind)&lt;"end"&gt;<div id="Stat_While"></div>

## Stat_While

A while stat, such as `while foo do bar() end`.

<details>
<summary>Raw Type</summary>

```luau
--- A while stat, such as `while foo do bar() end`.
type Stat_While = {
	kind: "while",

	--- The `while` token.
	while_tok: TokenKind<"while">,

	--- The condition; the `foo` in `while foo do bar() end`.
	condition: Expr,

	--- The `do` token.
	do_tok: TokenKind<"do">,

	--- The block; the `bar()` in `while foo do bar() end`.
	block: Block,

	--- The `end` token.
	end_tok: TokenKind<"end">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"while"
```

<div id="while_tok"></div>

### while_tok

The `while` token.

[TokenKind](#TokenKind)&lt;"while"&gt;<div id="condition"></div>

### condition

The condition; the `foo` in `while foo do bar() end`.

[Expr](#Expr)

<div id="do_tok"></div>

### do_tok

The `do` token.

[TokenKind](#TokenKind)&lt;"do"&gt;<div id="block"></div>

### block

The block; the `bar()` in `while foo do bar() end`.

[Block](#Block)

<div id="end_tok"></div>

### end_tok

The `end` token.

[TokenKind](#TokenKind)&lt;"end"&gt;<div id="Stat_Repeat"></div>

## Stat_Repeat

A repeat stat, such as `repeat foo() until bar`.

<details>
<summary>Raw Type</summary>

```luau
--- A repeat stat, such as `repeat foo() until bar`.
type Stat_Repeat = {
	kind: "repeat",

	--- The `repeat` token.
	repeat_tok: TokenKind<"repeat">,

	--- The block; the `foo()` in `repeat foo() until bar`.
	block: Block,

	--- The `until` token.
	until_tok: TokenKind<"until">,

	--- The condition; the `bar` in `repeat foo() until bar`.
	condition: Expr
}
```

</details>

<div id="kind"></div>

### kind

```luau
"repeat"
```

<div id="repeat_tok"></div>

### repeat_tok

The `repeat` token.

[TokenKind](#TokenKind)&lt;"repeat"&gt;<div id="block"></div>

### block

The block; the `foo()` in `repeat foo() until bar`.

[Block](#Block)

<div id="until_tok"></div>

### until_tok

The `until` token.

[TokenKind](#TokenKind)&lt;"until"&gt;<div id="condition"></div>

### condition

The condition; the `bar` in `repeat foo() until bar`.

[Expr](#Expr)

<div id="Stat_If"></div>

## Stat_If

An if stat, such as

`if foo then bar() elseif baz then qux() else quux() end`.

<details>
<summary>Raw Type</summary>

```luau
--- An if stat, such as
--- `if foo then bar() elseif baz then qux() else quux() end`.
type Stat_If = {
	kind: "if",

	--- The `if` token.
	if_tok: TokenKind<"if">,

	--- The branches; the `foo then bar() elseif baz then qux()` in
	--- `if foo then bar() elseif baz then qux() else quux() end`.
	branches: Separated<IfStatBranch, TokenKind<"elseif">>,

	--- The optional else branch; the `else quux()` in
	--- `if foo then bar() elseif baz then qux() else quux() end`.
	else_branch: {
		--- The `else` token.
		else_tok: TokenKind<"else">,

		--- The else branch block; the `quux()` in `else quux()`.
		block: Block
	}?,

	--- The `end` token.
	end_tok: TokenKind<"end">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"if"
```

<div id="if_tok"></div>

### if_tok

The `if` token.

[TokenKind](#TokenKind)&lt;"if"&gt;<div id="branches"></div>

### branches

The branches; the `foo then bar() elseif baz then qux()` in

`if foo then bar() elseif baz then qux() else quux() end`.

[Separated](#Separated)&lt;[IfStatBranch](#IfStatBranch), [TokenKind](#TokenKind)&lt;"elseif"&gt;&gt;<div id="else_branch"></div>

### else_branch

The optional else branch; the `else quux()` in

`if foo then bar() elseif baz then qux() else quux() end`.

*This field is optional and may not be specified*

{else_tok: [TokenKind](#TokenKind)&lt;"else"&gt;, block: [Block](#Block)}?

<div id="end_tok"></div>

### end_tok

The `end` token.

[TokenKind](#TokenKind)&lt;"end"&gt;<div id="Stat_NumericFor"></div>

## Stat_NumericFor

A numeric for loop stat, such as `for foo = 1, 2, 3 do bar() end`.

<details>
<summary>Raw Type</summary>

```luau
--- A numeric for loop stat, such as `for foo = 1, 2, 3 do bar() end`.
type Stat_NumericFor = {
	kind: "numericfor",

	--- The `for` token.
	for_tok: TokenKind<"for">,

	--- The binding; the `foo` in `for foo = 1, 2, 3  do bar() end`.
	binding: Binding,

	--- The equals token; the `=` in `for foo = 1, 2, 3 do bar() end`.
	equals: TokenKind<"=">,

	--- The start expr; the `1` in `for foo = 1, 2, 3 do bar() end`.
	start_expr: Expr,

	--- The comma between the start and end; the first comma in
	--- `for foo = 1, 2, 3 do bar() end`.
	comma: TokenKind<",">,

	--- The end expr; the `2` in `for foo = 1, 2, 3 do bar() end`.
	end_expr: Expr,

	--- The optional step; the `, 3` in `for foo = 1, 2, 3 do bar() end`.
	step: {
		--- The comma between the end and step; the comma in `, 3` and the
		--- second comma in `for foo = 1, 2, 3 do bar() end`.
		comma: TokenKind<",">,

		--- The step expr; the `3` in `, 3` and the `3` in
		--- `for foo = 1, 2, 3 do bar() end`.
		expr: Expr
	}?,

	--- The `do` token.
	do_tok: TokenKind<"do">,

	--- The block; the `bar()` in `for foo = 1, 2, 3 do bar() end`.
	block: Block,

	--- The `end` token.
	end_tok: TokenKind<"end">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"numericfor"
```

<div id="for_tok"></div>

### for_tok

The `for` token.

[TokenKind](#TokenKind)&lt;"for"&gt;<div id="binding"></div>

### binding

The binding; the `foo` in `for foo = 1, 2, 3  do bar() end`.

[Binding](#Binding)

<div id="equals"></div>

### equals

The equals token; the `=` in `for foo = 1, 2, 3 do bar() end`.

[TokenKind](#TokenKind)&lt;"="&gt;<div id="start_expr"></div>

### start_expr

The start expr; the `1` in `for foo = 1, 2, 3 do bar() end`.

[Expr](#Expr)

<div id="comma"></div>

### comma

The comma between the start and end; the first comma in

`for foo = 1, 2, 3 do bar() end`.

[TokenKind](#TokenKind)&lt;","&gt;<div id="end_expr"></div>

### end_expr

The end expr; the `2` in `for foo = 1, 2, 3 do bar() end`.

[Expr](#Expr)

<div id="step"></div>

### step

The optional step; the `, 3` in `for foo = 1, 2, 3 do bar() end`.

*This field is optional and may not be specified*

{comma: [TokenKind](#TokenKind)&lt;","&gt;, expr: [Expr](#Expr)}?

<div id="do_tok"></div>

### do_tok

The `do` token.

[TokenKind](#TokenKind)&lt;"do"&gt;<div id="block"></div>

### block

The block; the `bar()` in `for foo = 1, 2, 3 do bar() end`.

[Block](#Block)

<div id="end_tok"></div>

### end_tok

The `end` token.

[TokenKind](#TokenKind)&lt;"end"&gt;<div id="Stat_ForIn"></div>

## Stat_ForIn

A for-in loop stat, such as `for foo: bar, baz in qux, quux do quuz() end`.

<details>
<summary>Raw Type</summary>

```luau
--- A for-in loop stat, such as `for foo: bar, baz in qux, quux do quuz() end`.
type Stat_ForIn = {
	kind: "forin",

	--- The `for` token.
	for_tok: TokenKind<"for">,

	--- The bindings; the `foo: bar, baz` in
	--- `for foo: bar, baz in qux, quux do quuz() end`.
	bindings: Separated<Binding, TokenKind<",">>,

	--- The `in` token.
	in_tok: TokenKind<"in">,

	--- The exprs; the `qux, quux` in
	--- `for foo: bar, baz in qux, quux do quuz() end`.
	exprs: Separated<Expr, TokenKind<",">>,

	--- The `do` token.
	do_tok: TokenKind<"do">,

	--- The block; the `quuz()` in
	--- `for foo: bar, baz in qux, quux do quuz() end`.
	block: Block,

	--- The `end` token.
	end_tok: TokenKind<"end">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"forin"
```

<div id="for_tok"></div>

### for_tok

The `for` token.

[TokenKind](#TokenKind)&lt;"for"&gt;<div id="bindings"></div>

### bindings

The bindings; the `foo: bar, baz` in

`for foo: bar, baz in qux, quux do quuz() end`.

[Separated](#Separated)&lt;[Binding](#Binding), [TokenKind](#TokenKind)&lt;","&gt;&gt;<div id="in_tok"></div>

### in_tok

The `in` token.

[TokenKind](#TokenKind)&lt;"in"&gt;<div id="exprs"></div>

### exprs

The exprs; the `qux, quux` in

`for foo: bar, baz in qux, quux do quuz() end`.

[Separated](#Separated)&lt;[Expr](#Expr), [TokenKind](#TokenKind)&lt;","&gt;&gt;<div id="do_tok"></div>

### do_tok

The `do` token.

[TokenKind](#TokenKind)&lt;"do"&gt;<div id="block"></div>

### block

The block; the `quuz()` in

`for foo: bar, baz in qux, quux do quuz() end`.

[Block](#Block)

<div id="end_tok"></div>

### end_tok

The `end` token.

[TokenKind](#TokenKind)&lt;"end"&gt;<div id="Stat_Function"></div>

## Stat_Function

A function declaration stat, such as

`@native function foo.bar:baz() return 1 end`.

<details>
<summary>Raw Type</summary>

```luau
--- A function declaration stat, such as
--- `@native function foo.bar:baz() return 1 end`.
type Stat_Function = {
	kind: "function",

	--- The attributes; the `@native` in
	--- `@native function foo.bar:baz() return 1 end`.
	attributes: {TokenKind<"attribute">},

	--- The `function` token.
	function_tok: TokenKind<"function">,

	--- The name; the `foo.bar` in
	--- `@native function foo.bar:baz() return 1 end`.
	names: Separated<TokenKind<"ident">, TokenKind<".">>,

	--- The optional method; the `:baz` in
	--- `@native function foo.bar:baz() return 1 end`.
	method: {
		--- The colon; the `:` in `:baz`.
		colon: TokenKind<":">,

		--- The method name; the `baz` in `:baz`.
		name: TokenKind<"ident">
	}?,

	--- The function body; the `() return 1 end` in
	--- `@native function foo.bar:baz() return 1 end`.
	body: FunctionBody
}
```

</details>

<div id="kind"></div>

### kind

```luau
"function"
```

<div id="attributes"></div>

### attributes

The attributes; the `@native` in

`@native function foo.bar:baz() return 1 end`.

{[TokenKind](#TokenKind)&lt;"attribute"&gt;}

<div id="function_tok"></div>

### function_tok

The `function` token.

[TokenKind](#TokenKind)&lt;"function"&gt;<div id="names"></div>

### names

The name; the `foo.bar` in

`@native function foo.bar:baz() return 1 end`.

[Separated](#Separated)&lt;[TokenKind](#TokenKind)&lt;"ident"&gt;, [TokenKind](#TokenKind)&lt;"."&gt;&gt;<div id="method"></div>

### method

The optional method; the `:baz` in

`@native function foo.bar:baz() return 1 end`.

*This field is optional and may not be specified*

{colon: [TokenKind](#TokenKind)&lt;":"&gt;, name: [TokenKind](#TokenKind)&lt;"ident"&gt;}?

<div id="body"></div>

### body

The function body; the `() return 1 end` in

`@native function foo.bar:baz() return 1 end`.

[FunctionBody](#FunctionBody)

<div id="Stat_LocalFunction"></div>

## Stat_LocalFunction

A local function declaration stat, such as

`@native local function foo() return 1 end`.

<details>
<summary>Raw Type</summary>

```luau
--- A local function declaration stat, such as
--- `@native local function foo() return 1 end`.
type Stat_LocalFunction = {
	kind: "localfunction",

	--- The attributes; the `@native` in
	--- `@native local function foo() return 1 end`.
	attributes: {TokenKind<"attribute">},

	--- The `local` token.
	local_tok: TokenKind<"local">,

	--- The `function` token.
	function_tok: TokenKind<"function">,

	--- The name; the `foo` in `@native local function foo() return 1 end`.
	name: TokenKind<"ident">,

	--- The function body; the `() return 1 end` in
	--- `@native local function foo() return 1 end`.
	body: FunctionBody
}
```

</details>

<div id="kind"></div>

### kind

```luau
"localfunction"
```

<div id="attributes"></div>

### attributes

The attributes; the `@native` in

`@native local function foo() return 1 end`.

{[TokenKind](#TokenKind)&lt;"attribute"&gt;}

<div id="local_tok"></div>

### local_tok

The `local` token.

[TokenKind](#TokenKind)&lt;"local"&gt;<div id="function_tok"></div>

### function_tok

The `function` token.

[TokenKind](#TokenKind)&lt;"function"&gt;<div id="name"></div>

### name

The name; the `foo` in `@native local function foo() return 1 end`.

[TokenKind](#TokenKind)&lt;"ident"&gt;<div id="body"></div>

### body

The function body; the `() return 1 end` in

`@native local function foo() return 1 end`.

[FunctionBody](#FunctionBody)

<div id="Stat_TypeFunction"></div>

## Stat_TypeFunction

A type function declaration stat, such as

`type function foo() return 1 end`.

<details>
<summary>Raw Type</summary>

```luau
--- A type function declaration stat, such as
--- `type function foo() return 1 end`.
type Stat_TypeFunction = {
	kind: "typefunction",

	--- The optional `export` token.
	--- 
	--- Note that the value of this identifier must be `export` otherwise this
	--- will result in a syntax error.
	export_tok: TokenKind<"ident">?,

	--- The `type` token.
	type_tok: TokenKind<"type">,

	--- The `function` token.
	function_tok: TokenKind<"function">,

	--- The name; the `foo` in `type function foo() return 1 end`.
	name: TokenKind<"ident">,

	--- The function body; the `() return 1 end` in
	--- `type function foo() return 1 end`.
	body: FunctionBody
}
```

</details>

<div id="kind"></div>

### kind

```luau
"typefunction"
```

<div id="export_tok"></div>

### export_tok

The optional `export` token.



Note that the value of this identifier must be `export` otherwise this

will result in a syntax error.

*This field is optional and may not be specified*

[TokenKind](#TokenKind)&lt;"ident"&gt;?

<div id="type_tok"></div>

### type_tok

The `type` token.

[TokenKind](#TokenKind)&lt;"type"&gt;<div id="function_tok"></div>

### function_tok

The `function` token.

[TokenKind](#TokenKind)&lt;"function"&gt;<div id="name"></div>

### name

The name; the `foo` in `type function foo() return 1 end`.

[TokenKind](#TokenKind)&lt;"ident"&gt;<div id="body"></div>

### body

The function body; the `() return 1 end` in

`type function foo() return 1 end`.

[FunctionBody](#FunctionBody)

<div id="Stat_LocalVariable"></div>

## Stat_LocalVariable

A local variable stat, such as `local foo: bar, baz = qux, quux, quuz`.

<details>
<summary>Raw Type</summary>

```luau
--- A local variable stat, such as `local foo: bar, baz = qux, quux, quuz`.
type Stat_LocalVariable = {
	kind: "localvariable",

	--- The `local` token.
	local_tok: TokenKind<"local">,

	--- The bindings; the `foo: bar, baz` in
	--- `local foo: bar, baz = qux, quux, quuz`.
	bindings: Separated<Binding, TokenKind<",">>,

	--- The optional values; the `= qux, quux, quuz` in
	--- `local foo: bar, baz = qux, quux, quuz`.
	values: {
		--- The equals; the `=` in `= qux, quux, quuz`.
		equals: TokenKind<"=">,

		--- The exprs; the `qux, quux, quuz` in `= qux, quux, quuz`.
		exprs: Separated<Expr, TokenKind<",">>
	}?
}
```

</details>

<div id="kind"></div>

### kind

```luau
"localvariable"
```

<div id="local_tok"></div>

### local_tok

The `local` token.

[TokenKind](#TokenKind)&lt;"local"&gt;<div id="bindings"></div>

### bindings

The bindings; the `foo: bar, baz` in

`local foo: bar, baz = qux, quux, quuz`.

[Separated](#Separated)&lt;[Binding](#Binding), [TokenKind](#TokenKind)&lt;","&gt;&gt;<div id="values"></div>

### values

The optional values; the `= qux, quux, quuz` in

`local foo: bar, baz = qux, quux, quuz`.

*This field is optional and may not be specified*

{equals: [TokenKind](#TokenKind)&lt;"="&gt;, exprs: [Separated](#Separated)&lt;[Expr](#Expr), [TokenKind](#TokenKind)&lt;","&gt;&gt;}?

<div id="Stat_Type"></div>

## Stat_Type

A type declaration stat, such as `export type foo<bar> = baz`.

<details>
<summary>Raw Type</summary>

```luau
--- A type declaration stat, such as `export type foo<bar> = baz`.
type Stat_Type = {
	kind: "type",

	--- The optional `export` token.
	--- 
	--- Note that the value of this identifier must be `export` otherwise this
	--- will result in a syntax error.
	export_tok: TokenKind<"ident">?,

	--- The `type` token.
	---
	--- Note that the value of this identifier must be `type` otherwise this
	--- will result in a syntax error.
	type_tok: TokenKind<"ident">,

	--- The name of the type; the `foo` in `export type foo<bar> = baz`.
	name: TokenKind<"ident">,

	--- The optional generic declarations; the `<bar>` in `export type foo<bar> = baz`.
	generics: GenericDeclarationWithDefaults?,

	--- The equals token; the `=` in `export type foo<bar> = baz`.
	equals: TokenKind<"=">,

	--- The type; the `baz` in `export type foo<bar> = baz`.
	type: Type
}
```

</details>

<div id="kind"></div>

### kind

```luau
"type"
```

<div id="export_tok"></div>

### export_tok

The optional `export` token.



Note that the value of this identifier must be `export` otherwise this

will result in a syntax error.

*This field is optional and may not be specified*

[TokenKind](#TokenKind)&lt;"ident"&gt;?

<div id="type_tok"></div>

### type_tok

The `type` token.



Note that the value of this identifier must be `type` otherwise this

will result in a syntax error.

[TokenKind](#TokenKind)&lt;"ident"&gt;<div id="name"></div>

### name

The name of the type; the `foo` in `export type foo<bar> = baz`.

[TokenKind](#TokenKind)&lt;"ident"&gt;<div id="generics"></div>

### generics

The optional generic declarations; the `<bar>` in `export type foo<bar> = baz`.

*This field is optional and may not be specified*

[GenericDeclarationWithDefaults](#GenericDeclarationWithDefaults)?

<div id="equals"></div>

### equals

The equals token; the `=` in `export type foo<bar> = baz`.

[TokenKind](#TokenKind)&lt;"="&gt;<div id="type"></div>

### type

The type; the `baz` in `export type foo<bar> = baz`.

[Type](#Type)

<div id="Stat"></div>

## Stat

A statement in a block, such as `foo()` or `local foo = bar` or `foo = bar`.

<details>
<summary>Raw Type</summary>

```luau
--- A statement in a block, such as `foo()` or `local foo = bar` or `foo = bar`.
type Stat = Stat_Assign | Stat_CompoundAssign | Stat_Call | Stat_Do | Stat_While | Stat_Repeat | Stat_If | Stat_NumericFor | Stat_ForIn | Stat_Function | Stat_LocalFunction | Stat_TypeFunction | Stat_LocalVariable | Stat_Type
```

</details>

([Stat_Assign](#Stat_Assign) | [Stat_CompoundAssign](#Stat_CompoundAssign) | [Stat_Call](#Stat_Call) | [Stat_Do](#Stat_Do) | [Stat_While](#Stat_While) | [Stat_Repeat](#Stat_Repeat) | [Stat_If](#Stat_If) | [Stat_NumericFor](#Stat_NumericFor) | [Stat_ForIn](#Stat_ForIn) | [Stat_Function](#Stat_Function) | [Stat_LocalFunction](#Stat_LocalFunction) | [Stat_TypeFunction](#Stat_TypeFunction) | [Stat_LocalVariable](#Stat_LocalVariable) | [Stat_Type](#Stat_Type))<div id="LastStat_Return"></div>

## LastStat_Return

A return laststat, such as `return foo, bar, baz` or `return`.

<details>
<summary>Raw Type</summary>

```luau
--- A return laststat, such as `return foo, bar, baz` or `return`.
type LastStat_Return = {
	kind: "return",

	--- The `return` token.
	return_tok: TokenKind<"return">,

	--- The returned exprs; the `foo, bar, baz` in `return foo, bar, baz`.
	exprs: Separated<Expr, TokenKind<",">>
}
```

</details>

<div id="kind"></div>

### kind

```luau
"return"
```

<div id="return_tok"></div>

### return_tok

The `return` token.

[TokenKind](#TokenKind)&lt;"return"&gt;<div id="exprs"></div>

### exprs

The returned exprs; the `foo, bar, baz` in `return foo, bar, baz`.

[Separated](#Separated)&lt;[Expr](#Expr), [TokenKind](#TokenKind)&lt;","&gt;&gt;<div id="LastStat_Break"></div>

## LastStat_Break

A `break` laststat.

<details>
<summary>Raw Type</summary>

```luau
--- A `break` laststat.
type LastStat_Break = {
	kind: "break",

	--- The `break` token.
	tok: TokenKind<"break">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"break"
```

<div id="tok"></div>

### tok

The `break` token.

[TokenKind](#TokenKind)&lt;"break"&gt;<div id="LastStat_Continue"></div>

## LastStat_Continue

A `continue` laststat.

<details>
<summary>Raw Type</summary>

```luau
--- A `continue` laststat.
type LastStat_Continue = {
	kind: "continue",

	--- The `continue` token.
	--- 
	--- Note that the value of this identifier must be `continue` otherwise this
	--- will result in a syntax error.
	tok: TokenKind<"ident">
}
```

</details>

<div id="kind"></div>

### kind

```luau
"continue"
```

<div id="tok"></div>

### tok

The `continue` token.



Note that the value of this identifier must be `continue` otherwise this

will result in a syntax error.

[TokenKind](#TokenKind)&lt;"ident"&gt;<div id="LastStat"></div>

## LastStat

The last statement in a block, such as `return`, `break`, or `continue`.

<details>
<summary>Raw Type</summary>

```luau
--- The last statement in a block, such as `return`, `break`, or `continue`.
type LastStat = LastStat_Return | LastStat_Break | LastStat_Continue
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

[LastStat_Return](#LastStat_Return)

</details>

<details>
<summary>Variant 2</summary>

[LastStat_Break](#LastStat_Break)

</details>

<details>
<summary>Variant 3</summary>

[LastStat_Continue](#LastStat_Continue)

</details>

<div id="Block"></div>

## Block

A block of stats, ending with an optional laststat, such as

`foo(); bar(); return baz;`.

<details>
<summary>Raw Type</summary>

```luau
--- A block of stats, ending with an optional laststat, such as
--- `foo(); bar(); return baz;`.
type Block = {
	--- The stats, the `foo(); bar();` in `foo(); bar(); return baz;`.
	stats: Separated<Stat, TokenKind<";">>,

	--- The optional laststat, the `return baz;` in `foo(); bar(); return baz;`.
	last_stat: {
		--- The laststat; the `return baz` in `return baz;`.
		stat: LastStat,

		--- The optional semicolon; the `;` in `return baz;`.
		semicolon: TokenKind<";">?
	}?
}
```

</details>

<div id="stats"></div>

### stats

The stats, the `foo(); bar();` in `foo(); bar(); return baz;`.

[Separated](#Separated)&lt;[Stat](#Stat), [TokenKind](#TokenKind)&lt;";"&gt;&gt;<div id="last_stat"></div>

### last_stat

The optional laststat, the `return baz;` in `foo(); bar(); return baz;`.

*This field is optional and may not be specified*

{stat: [LastStat](#LastStat), semicolon: [TokenKind](#TokenKind)&lt;";"&gt;?}?

<div id="Cst"></div>

## Cst

A full CST with a block and eof.

<details>
<summary>Raw Type</summary>

```luau
--- A full CST with a block and eof.
type Cst = {
	--- The block of stats.
	block: Block,

	--- The eof token.
	eof: TokenKind<"eof">
}
```

</details>

<div id="block"></div>

### block

The block of stats.

[Block](#Block)

<div id="eof"></div>

### eof

The eof token.

[TokenKind](#TokenKind)&lt;"eof"&gt;