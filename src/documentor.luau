--!strict

-- Creates the actual documentation. The code here can be modified to change the template used 

--- A documentable type 
type Type = {
    --- the inner data of the type
    dbg__inner: any,
    --- the type of the type
    type: (self: Type) -> string,
    --- the name of the type
    name: (self: Type) -> string,
    --- the type comments attached to the type
    type_comments: (self: Type) -> string,
    --- the string representation of the type
    string_repr: (self: Type) -> string,
    --- the raw representation of the type
    raw_repr: (self: Type) -> string,
    --- If a typedef, returns the inner typedef
    typedef: (self: Type) -> TypeDef
}

type TypeIterator = (() -> Type)

type TypeSet = {
    --- the raw types of the type set as a table
    dbg__raw_types_table: any,
    --- the raw types in the type set as userdata
    raw_types: {Type},
    --- Creates an iterator over the typedefs in the set
    iter_typedefs: (self: TypeSet) -> TypeIterator,
    --- Creates an iterator over the functions in the set
    iter_functions: (self: TypeSet) -> TypeIterator,
    --- Creates an iterator over the types in the set
    iter_types: (self: TypeSet) -> TypeIterator,
}

--- A type definition
type TypeDef = {
    dbg__inner: any,
    --- Type of the inner type def
    type: (self: TypeDef) -> string
}

-- Begin of documentation generation actual code
local ast: TypeSet = ...

print(_G.prettyprint(ast.dbg__raw_types_table))

print("Type definitions:")
for typ in ast:iter_typedefs() do
    assert(typ:type() == "typedef")
    print(_G.prettyprint(typ.dbg__inner))
    print("StringRepr:\n" .. typ:string_repr() .. "\n")
    print("RawRepr\n" .. typ:raw_repr() .. "\n")
    print("Name: " .. typ:name())
    print("Inner Type: " .. typ:typedef():type())
end

print("Functions:")
for func in ast:iter_functions() do
    assert(func:type() == "function")
    print(_G.prettyprint(func.dbg__inner))
    print("StringRepr:\n" .. func:string_repr() .. "\n")
    print("RawRepr\n" .. func:raw_repr() .. "\n")
    print("Name: " .. func:name())
end 