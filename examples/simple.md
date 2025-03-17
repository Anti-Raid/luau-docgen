<div id="Types"></div>

# Types

<div id="SimpleType"></div>

## SimpleType

<details>
<summary>Raw Type</summary>

```luau
type SimpleType = {
	---@field a Number of times to call ourselves
	a: (a: string) -> ()
}
```

</details>

<div id="a"></div>

### a

<details>
<summary>Function Signature</summary>

```luau
---@field a Number of times to call ourselves
a: (a: string) -> ()
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="a"></div>

##### a

Number of times to call ourselves

[string](#string)

<div id="SimpleType2"></div>

## SimpleType2

hello

<details>
<summary>Raw Type</summary>

```luau
--- hello
type SimpleType2 = {
	---@field a Number of times to call ourselves
	a: (a: string) -> ()
}
```

</details>

<div id="a"></div>

### a

<details>
<summary>Function Signature</summary>

```luau
---@field a Number of times to call ourselves
a: (a: string) -> ()
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="a"></div>

##### a

Number of times to call ourselves

[string](#string)

<div id="SimpleType3"></div>

## SimpleType3

Simple type with just function and return type

<details>
<summary>Raw Type</summary>

```luau
--- Simple type with just function and return type
type SimpleType3 = {
	-- String return type
	---@field a Number of times to call ourselves
	---@returns mystring Something something something??
	a: (a: string) -> string
}
```

</details>

<div id="a"></div>

### a

String return type

<details>
<summary>Function Signature</summary>

```luau
-- String return type
---@field a Number of times to call ourselves
---@returns mystring Something something something??
a: (a: string) -> string
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="a"></div>

##### a

Number of times to call ourselves

[string](#string)

<div id="Returns"></div>

#### Returns

<div id="mystring"></div>

##### mystring

Something something something??

[string](#string)