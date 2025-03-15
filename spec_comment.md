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

*This field is a generic type with base* [Ok](#Ok)

[T](#T)

</details>

<details>
<summary>Variant 2</summary>

*This field is a generic type with base* [Err](#Err)

[E](#E)

</details>

