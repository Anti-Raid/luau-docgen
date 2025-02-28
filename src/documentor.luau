-- Creates the actual documentation. The code here can be modified to change the template used 

type TypeSet = {
    a: number,
    b: number,
}

local ast: TypeSet = ...

print(prettyprint(ast.raw_types))

print("Type definitions:")
for typ in ast:iter_typedefs() do
    print(prettyprint(typ.debug_data))
    print(typ:string_repr())
    print(typ:raw_repr())
end

print("Functions:")
for func in ast:iter_functions() do
    print(prettyprint(func.debug_data))
    print("StringRepr:\n" .. func:string_repr() .. "\n")
    print("RawRepr\n" .. func:raw_repr() .. "\n")
end 

--return ast.raw_types