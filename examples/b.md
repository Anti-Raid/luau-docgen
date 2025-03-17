# Types

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

### nanos

Nanos

Field with the following constraints:

- Type: number
- Constraints: None

### a

Table

*This is an inline table type with the following fields*

##### b

My favorite type

Field with the following constraints:

- Type: string
- Constraints: None

##### c

Meow

Field with the following constraints:

- Type: string
- Constraints: None

##### d

Field with the following constraints:

- Type: string
- Constraints: None

##### e

Field with the following constraints:

- Type: string
- Constraints: None

##### f

Hello

*This is an inline table type with the following fields*

##### g

World

Field with the following constraints:

- Type: boolean
- Constraints: None

##### h

G

Field with the following constraints:

- Type: string
- Constraints: None

### __meow

Catnip

Field with the following constraints:

- Type: string
- Constraints: None

### Metatable Fields

#### __add

<details>
<summary>Function Signature</summary>

```luau
__add: (a: a, b: a) -> a
```

</details>

##### Arguments

- **a** *(a)*
- **b** *(a)*

##### Returns

- **ret1** *(a)*

#### __sub

<details>
<summary>Function Signature</summary>

```luau
__sub: (a: a, b: a) -> a
```

</details>

##### Arguments

- **a** *(a)*
- **b** *(a)*

##### Returns

- **ret1** *(a)*

# Functions

## test

Comment here

<details>
<summary>Function Signature</summary>

```luau
--Comment here
function test(a: a, b: number) end
```

</details>

## Arguments

- **a** *(a)*
- **b** *(number)*

## a

Hello normal function

<details>
<summary>Function Signature</summary>

```luau
-- Hello normal function
function a<T>() end
```

</details>

## Generics

- **T** *(any)*

