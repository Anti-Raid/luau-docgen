<div id="Types"></div>

# Types

<div id="DangerType"></div>

## DangerType

<div class="warning">
Use at your own risk 
Something else here...
</div>

<details>
<summary>Raw Type</summary>

```luau
---# warning
---Use at your own risk \
---Something else here...
type DangerType = {
	--- A
	a: number,

	--- B
	b: number
}
```

</details>

<div id="a"></div>

### a

A

[number](#number)

<div id="b"></div>

### b

B

[number](#number)

<div id="Result"></div>

## Result

The result of a yielding operation that could error. You should always write
	error handling for all types of errors that can be returned.

<details>
<summary>Raw Type</summary>

```luau
--
	The result of a yielding operation that could error. You should always write
	error handling for all types of errors that can be returned.

type Result<T, E> = Ok<T> | Err<E>
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

[Ok](#Ok)<[T](#T)></details>

<details>
<summary>Variant 2</summary>

[Err](#Err)<[E](#E)></details>

<div id="A"></div>

## A

Generic with unions

<details>
<summary>Raw Type</summary>

```luau
--- Generic with unions
type A<T> = Ok<string | number, string>
```

</details>

[Ok](#Ok)<([string](#string) | [number](#number)), [string](#string)><div id="Function"></div>

## Function

<details>
<summary>Raw Type</summary>

```luau
type Function = (<T>(a: string, b: number) -> (a: string) -> T) | string
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

<details>
<summary>Function Signature</summary>

```luau
(<T>(a: string, b: number) -> (a: string) -> T) | string
```

</details>

<div id="Generics"></div>

### Generics

<div id="T"></div>

#### T

This generic is unconstrained and can be any type

<div id="Arguments"></div>

### Arguments

<div id="a"></div>

#### a

[string](#string)

<div id="b"></div>

#### b

[number](#number)

<div id="Returns"></div>

### Returns

<div id="ret1"></div>

#### ret1

(a: [string](#string)) -> [T](#T)</details>

<details>
<summary>Variant 2</summary>

[string](#string)

</details>

