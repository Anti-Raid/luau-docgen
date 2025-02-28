-- Creates the actual documentation. The code here can be modified to change the template used 

--- A documentable type 
type Type = {
    --- the inner data of the type
    inner_data: any,
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
}

type TypeIterator = (() -> Type)

type TypeSet = {
    --- the raw types of the type set as a table
    raw_types_table: any,
    --- the raw types in the type set as userdata
    raw_types: {Type},
    --- Creates an iterator over the typedefs in the set
    iter_typedefs: (self: TypeSet) -> TypeIterator,
    --- Creates an iterator over the functions in the set
    iter_functions: (self: TypeSet) -> TypeIterator,
    --- Creates an iterator over the types in the set
    iter_types: (self: TypeSet) -> TypeIterator,
}

local ast: TypeSet = ...

print(prettyprint(ast.raw_types_table))

print("Type definitions:")
for typ in ast:iter_typedefs() do
    assert(typ:type() == "typedef")
    print(prettyprint(typ.inner_data))
    print(typ:string_repr())
    print(typ:raw_repr())
end

print("Functions:")
for func in ast:iter_functions() do
    assert(func:type() == "function")
    print(prettyprint(func.inner_data))
    print("StringRepr:\n" .. func:string_repr() .. "\n")
    print("RawRepr\n" .. func:raw_repr() .. "\n")
end 
