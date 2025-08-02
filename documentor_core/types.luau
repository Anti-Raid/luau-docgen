-- Creates the actual documentation. The code here can be modified to change the template used 

--- E.g.
--- 
--- @my_special_comment -> typ="my_special_comment", data=""
--- @my_special_comment my comment -> typ="my_special_comment", data="my comment"
--- @my_special_comment my comment1 my comment2 -> typ="my_special_comment", data="my comment1 my comment2"
export type InnerComment = {
    comment_type: "Special",
    --- The type of the special comment
    typ: string,
    --- The data of the special comment
    data: string,
} | {
    comment_type: "Normal",
    --- The data of the normal comment
    data: string,
}

--- Contains a parsed list of comments from globals.parsecomments
export type Comment = {
    --- List of comments (in order of appearance)
    comments: {InnerComment},
}

export type ParseToTypeSetArgs = {
    -- The contents of the Luau file to parse
    contents: string,

    --- Whether to visit non-exported types
    ---
    --- Defaults to false
    include_nonexported_types: boolean?,
}

export type ParseToTypeSetResponse = {
    unsupported_count: number,
    typeset: TypeSet,
}

--- Fields needed for accelerated/custom parser runtime support
export type ProcOps = {
    --- Run a command and return the output
    run: (command: string, args: {string}) -> string, -- returns the output of the command
    --- JSON parse a string
    json_parse: (json: string) -> any, -- returns the parsed JSON object
}

export type FsOps = {
    --- Filesystem operations
    fs_readfile: (path: string) -> string, -- returns the contents of the file
    fs_writefile: (path: string, contents: string) -> (), -- writes the contents to the file
    fs_fileexists: (path: string) -> boolean, -- checks if the file exists
}

--- Globals
export type Globals = {
    --- Documentor args
    read documentor_args: {string},
    
    --- Parse to typeset
    parsetotypeset: (opts: ParseToTypeSetArgs) -> ParseToTypeSetResponse,

    runtime: string, -- Runtime being used
    fs_ops: FsOps?, -- filesystem operations
    proc_ops: ProcOps?, -- optional proc ops
}

export type TypeSet = {
    types: {Type},
}
--- A documentable type 
export type Type = {
    type: "TypeDef",
    data: TypeDef,
} | {
    type: "Function",
    data: TypeFunction,
}

--- A type definition
export type TypeDef = {
    --- Name of the typedef
    name: string,
    --- generic arguments of the typedef
    generics: {TypedArgument},
    --- type comments attached to the typedef
    type_comments: {string},
    --- The type definition type of the typedef
    typ: TypeFieldType,
}

--- A type function
export type TypeFunction = {
    --- Name of the function
    name: string,
    --- type comments attached to the function
    type_comments: {string},
    --- generic arguments of the function
    generics: {TypedArgument},
    --- arguments of the function
    args: {TypedArgument},
    --- return type of the function
    ret: TypeFieldType?,
    --- the function type of the function
    function_type: "Normal" | "Local",
}

export type TypeFieldKey = {
    type: "Name",
    name: string
} | {
    type: "IndexSignature",
    start_tok: string,
    inner: TypeFieldType,
    end_tok: string
}

--- A type field used within table types. The foo: number in { foo: number }.
export type TypeField = {
    --- The comments associated with the type field
    comments: {string},
    --- The name of the field
    field_name: TypeFieldKey,
    --- The type of the field
    field_type: TypeFieldType,
}

export type TypeFieldType = {
    type: "Basic",
    data: string,
} | 
--- A string singleton ("hello")
{
    type: "String",
    data: string,
} | 
--- A boolean singleton (true, false)
{
    type: "Boolean",
    data: boolean
} | 
--- An array of a type
{
    type: "Array",
    data: TypeFieldType,
} | 
--- A variadic type, similar to Array ...number
{
    type: "Variadic",
    data: TypeFieldType,
} | 
--- A variadic type pack: ...T in Function<...T>
{
    type: "VariadicPack",
    data: string,
} | 
--- A function type
{
    type: "Function",
    data: TypeFieldTypeFunction,
} | 
--- Contains the inner table fields
{
    type: "Table",
    data: {TypeField},
} | 
--- A type using generics, such as map<number, string>.
{
    type: "Generic",
    data: TypeFieldTypeGeneric,
} | 
--- T...
{
    type: "GenericPack",
    data: string,
} |
--- A union type (e.g. string | number)
{
    type: "Union",
    data: {TypeFieldType},
} |
--- A type intersection (e.g. string & number)
{
    type: "Intersection",
    data: {TypeFieldType},
} |
--- A module
{
    type: "Module",
    data: TypeFieldTypeModule,
} | 
--- Unknown module
---
--- Contains the module name, which may be an empty string    
{
    type: "UnknownModule",
    data: string,
} | 
--- An optional type
{
    type: "Optional",
    data: TypeFieldType,
} |
--- Tuple type
{
    type: "Tuple",
    data: {TypeFieldType},
} | 
--- A typeof statement
---
--- Inner is the contents of the statement
{
    type: "TypeOf",
    data: string,
} |
--- A typeof(setmetatable) statement
{
    type: "TypeOfSetMetatable",
    data: TypeFieldTypeTypeofSetMetatable,
}

--- A typed argument with an optional name and typ
export type TypedArgument = {
    --- The name of the argument (may be null with arguments like bare ...number)
    name: string?,
    --- The type of the argument (may be null with generics without a default type)
    typ: TypeFieldType?,
    --- Any optional/extra punctuation (trivia in grammar)
    punctuation: string?,
}

--- Inner data of a Function TypeFieldType
export type TypeFieldTypeFunction = {
    --- The generic arguments of the function
    generics: {TypedArgument},
    --- The arguments of the function
    args: {TypedArgument},
    --- The return type of the function
    ret: TypeFieldType,
}

--- Inner data of a Generic TypeFieldType
--- 
--- A type using generics, such as map<number, string> [base<generic 1, generic 2...>]
export type TypeFieldTypeGeneric = {
    --- The base type name of the generic type field
    base: string,
    --- The generic arguments of the type
    generics: {TypeFieldType},
}

--- Inner data of a Module TypeFieldType
---
--- A type coming from a module, such as module.Foo
export type TypeFieldTypeModule = {
    --- The module name of the type
    module: string,
    --- The base type name of the module
    base: string,
    --- The generic arguments of the module (if the type is generic e.g. promise.Promise<T>)
    generics: {TypeFieldType}?,
}

--- Inner data of a TypeOf SetMetatable declaration
export type TypeFieldTypeTypeofSetMetatable = {
    --- The fields of the type
    fields: {TypeField},
    --- The metatable fields of the type
    metatable_fields: {TypeField},
}

return {}