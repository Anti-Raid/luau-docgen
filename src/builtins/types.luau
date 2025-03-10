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

--- Contains a single parsed argument from globals.parsedocumentorargs
export type ParsedArg = {
    --- The name of the argument
    name: string,
    --- The values passed to the argument
    values: {string},
    --- Whether the argument is short (-a) or long (--abc)
    short: boolean,
}

--- Contains a parsed list of arguments from globals.parsedocumentorargs
export type ParsedArgs = {
    --- List of arguments (in order of appearance)
    args: {ParsedArg},
}

--- Globals
export type Globals = {
    --- Documentor args
    documentor_args: {string},
    --- Pretty prints a value
    prettyprint: (...any) -> string,
    --- Parse a comment block
    parsecomments: (comments: {string}, ignore_nondoc: boolean?) -> Comment,
    --- Parse documentor args
    parsedocumentorargs: (args: {string}) -> ParsedArgs,
}

export type TypeIterator = (() -> Type)

export type TypeSet = {
    --- the raw types of the type set as a table
    dbg__raw_types_table: any,
    --- the raw types in the type set as userdata
    raw_types: {Type},
    --- Creates an iterator over the typedefs in the set
    iter_typedefs: (self: TypeSet) -> TypeIterator,
    --- Creates an iterator over the functions in the set
    iter_functions: (self: TypeSet) -> TypeIterator,
    --- Creates an iterator over the types in the set
    iter_all: (self: TypeSet) -> TypeIterator,
}

--- A documentable type 
export type Type = {
    --- the inner data of the type
    dbg__inner: any,
    --- Extract out the type and variant name
    extract: (self: Type) -> {
        type: "TypeDef",
        data: TypeDef,
    } | {
        type: "Function",
        data: TypeFunction,
    },
    --- the name of the type
    name: (self: Type) -> string,
    --- the type comments attached to the type
    type_comments: (self: Type) -> {string},
    --- the string representation of the type
    string_repr: (self: Type) -> string,
    --- the string representation of the type with different seperators
    string_repr_with_pats: (self: Type, fields_join_pat: string, args_join_pat: string, generics_join_pat: string) -> string,
    --- the raw representation of the type
    raw_repr: (self: Type) -> string,
}

--- A type definition
export type TypeDef = {
    dbg__inner: any,
    --- Name of the typedef
    name: string,
    --- generic arguments of the typedef
    generics: {TypedArgument},
    --- type comments attached to the typedef
    type_comments: {string},
    --- The type definition type of the typedef
    type_def_type: TypeDefType,
    --- The string representation of the typedef
    repr: string,
}

--- A type function
export type TypeFunction = {
    --- the inner data of the type
    dbg__inner: any,
    --- Name of the function
    name: string,
    --- The string representation of the function
    repr: string,
    --- type comments attached to the function
    type_comments: {string},
    --- generic arguments of the function
    generics: {TypedArgument},
    --- arguments of the function
    args: {TypedArgument},
    --- return type of the function
    ret: TypeFieldType?,
    --- the function type of the function
    function_type: "Normal" | "Local"
}

--- specifialized type definition type information
export type TypeDefType = {
    --- Extract out the type and variant name
    extract: (self: TypeDefType) -> {
        type: "Table",
        data: {TypeField}
    } | {
        type: "TypeOfSetMetatable",
        data: TypeDefTypeTypeofSetMetatable,
    } | {
        type: "Uncategorized",
        data: TypeFieldType,
    }
}

--- Inner data of a TypeOf SetMetatable declaration
export type TypeDefTypeTypeofSetMetatable = {
    --- The fields of the type
    fields: {TypeField},
    --- The metatable fields of the type
    metatable_fields: {TypeField},
}

--- A type field used within table types. The foo: number in { foo: number }.
export type TypeField = {
    --- The string representation of the type field
    repr: string,
    --- The comments associated with the type field
    comments: {string},
    --- The name of the field
    field_name: string,
    --- The type of the field
    field_type: TypeFieldType,
    --- The string representation of the field type
    string_repr: (self: TypeField, depth: number?) -> string,
    --- The string representation of the field type with different seperators
    string_repr_with_pats: (self: TypeField, comment_write_pat: string, depth: number?) -> string,
}

--- Compact type information (Any type, such as string, boolean?, number | boolean, etc)
export type TypeFieldType = {
    --- Extract out the type and variant name
    extract: (self: TypeFieldType) -> 
    -- A basic primitive type (string, number, etc)
    {
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
    },

    --- Recursively find the inner set of types that compose/make up a TypeFieldType
    unwind: (self: TypeFieldType) -> {TypeFieldType},

    --- The string representation of the type
    string_repr: (self: TypeFieldType, depth: number?) -> string,
}

--- A typed argument with an optional name and typ
export type TypedArgument = {
    --- The name of the argument (may be null with arguments like bare ...number)
    name: string?,
    --- The type of the argument (may be null with generics without a default type)
    typ: TypeFieldType?,
    --- Any optional/extra punctuation (trivia in grammar)
    punctuation: string?,
    --- The string representation of the argument.
    ---
    --- If with_punctuation is true, the punctuation will be included in the string representation (default: false)
    ---
    --- If is_generic is true, the argument will be treated as a generic argument (default: false)
    string_repr: (self: TypedArgument, with_punctuation: boolean?, is_generic: boolean?) -> string,
}

--- Inner data of a Function TypeFieldType
export type TypeFieldTypeFunction = {
    --- The arguments of the function
    args: {TypedArgument},
    --- The return type of the function
    ret: TypeFieldType,
    --- The string representation of the function
    string_repr: (self: TypeFieldTypeFunction) -> string,
}

--- Inner data of a Generic TypeFieldType
--- 
--- A type using generics, such as map<number, string> [base<generic 1, generic 2...>]
export type TypeFieldTypeGeneric = {
    --- The base type name of the generic type field
    base: string,
    --- The generic arguments of the type
    generics: {TypeFieldType},
    --- The string representation of the generic type
    string_repr: (self: TypeFieldTypeGeneric) -> string,
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
    --- The string representation of the module type
    string_repr: (self: TypeFieldTypeModule) -> string,
}

return {}