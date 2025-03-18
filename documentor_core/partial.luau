--[=[
    Makes all of the properties in a table optional.

    @param input { [any]: any } -- The table to make partial.
]=]
export type function Partial(input: any)
    if input:is("union") then
        local comps = input:components()
        for key, value in ipairs(comps) do
            comps[key] = Partial(value) 
        end 

        return types.unionof(table.unpack(comps)) 
    end 

    if input:is("intersection") then
        local comps = input:components()
        for key, value in ipairs(comps) do
            comps[key] = Partial(value) 
        end

        return types.intersectionof(table.unpack(comps)) 
    end

    for key, value in input:properties() do
        local read = types.unionof(value.read, types.singleton(nil))
        local write = value.write and types.unionof(value.write, types.singleton(nil)) or nil
        input:setreadproperty(key, read)
        if value.write then input:setwriteproperty(key, if(read and write) and (write == read) then read else write) end
    end
    return input  
end 

return {}