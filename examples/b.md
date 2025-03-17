<div id="Types"></div>

# Types

<div id="c"></div>

## c

My favorite type

<details>
<summary>Raw Type</summary>

```luau
--!strict
--- My favorite type
type c<U, T = string> = {}
```

</details>

<div id="a"></div>

## a

Meow

<details>
<summary>Raw Type</summary>

```luau
-- Meow
type a = {
	-- Nanos
	nanos: number,

	-- Table
	a: {
		--- My favorite type
		b: string,

		--- Meow
		c: string,

		d: string,

		e: string,

		--- Hello
		f: {
			-- World
			g: boolean
		},

		--- G
		h: string
	},

	-- Catnip
	__meow: string,

	-- Metatable
	__add: (a: a, b: a) -> a,
	__sub: (a: a, b: a) -> a
}
```

</details>

<div id="nanos"></div>

### nanos

Nanos

[number](#number)

<div id="a"></div>

### a

Table

*This is an inline table type with the following fields*

<div id="b"></div>

##### b

My favorite type

[string](#string)

<div id="c"></div>

##### c

Meow

[string](#string)

<div id="d"></div>

##### d

[string](#string)

<div id="e"></div>

##### e

[string](#string)

<div id="f"></div>

##### f

Hello

*This is an inline table type with the following fields*

<div id="g"></div>

##### g

World

[boolean](#boolean)

<div id="h"></div>

##### h

G

[string](#string)

<div id="__meow"></div>

### __meow

Catnip

[string](#string)

<div id="MetatableFields"></div>

### Metatable Fields

<div id="__add"></div>

#### __add

<details>
<summary>Function Signature</summary>

```luau
__add: (a: a, b: a) -> a
```

</details>

<div id="Arguments"></div>

##### Arguments

<div id="a"></div>

##### a

[a](#a)

<div id="b"></div>

##### b

[a](#a)

<div id="Returns"></div>

##### Returns

<div id="ret1"></div>

##### ret1

[a](#a)<div id="__sub"></div>

#### __sub

<details>
<summary>Function Signature</summary>

```luau
__sub: (a: a, b: a) -> a
```

</details>

<div id="Arguments"></div>

##### Arguments

<div id="a"></div>

##### a

[a](#a)

<div id="b"></div>

##### b

[a](#a)

<div id="Returns"></div>

##### Returns

<div id="ret1"></div>

##### ret1

[a](#a)<div id="Functions"></div>

# Functions

<div id="test"></div>

## test

Comment here

<details>
<summary>Function Signature</summary>

```luau
--Comment here
function test(a: a, b: number) end
```

</details>

<div id="Arguments"></div>

## Arguments

<div id="a"></div>

### a

[a](#a)

<div id="b"></div>

### b

[number](#number)

<div id="a"></div>

## a

Hello normal function

<details>
<summary>Function Signature</summary>

```luau
-- Hello normal function
function a<T>() end
```

</details>

<div id="Generics"></div>

## Generics

<div id="T"></div>

### T

This generic is unconstrained and can be any type

