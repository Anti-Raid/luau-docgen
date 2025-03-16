---@skip 
export type SkipMe = {
    shouldbeskipped: number?
}

---# warning
---Use at your own risk \
---Something else here...
export type DangerType = {
    --- A
    a: number,
    --- B
    b: number
}

--[=[
	The result of a yielding operation that could error. You should always write
	error handling for all types of errors that can be returned.
]=]
export type Result<T, E> = Ok<T> | Err<E>

--- Generic with unions
export type A<T> = Ok<string | number, string> 
export type Function = (<T>(a: string, b: number) -> (a: string) -> T) | string