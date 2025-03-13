export type SimpleType = {
    ---@field a Number of times to call ourselves
    a: (a: string) -> ()
}

--- hello
export type SimpleType2 = {
    ---@field a Number of times to call ourselves
    a: (a: string) -> ()
}

--- Simple type with just function and return type
export type SimpleType3 = {
    -- String return type
    ---@field a Number of times to call ourselves
    ---@returns mystring Something something something??
    a: (a: string) -> string
}