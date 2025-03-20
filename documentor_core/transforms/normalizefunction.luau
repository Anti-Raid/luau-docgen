--!strict

local types = require("../types")

--[[
Given a function like:

```lua
local tab = {}

function tab.foo(a, b)
    return a + b
end
```

Inline the function into ``tab`` as a field.

Given a function like:
```lua
local tab = {}

function tab:foo(a, b)
    return a + b
end
```

Add a self parameter to the function and inline it into ``tab`` as a field.
]]
local function normalizeFunction(typedefs: {types.Type}, functions: {types.Type})
--[[    -- Helper method to inline a function into a table
    local function inlineFunction(targetIdx: number, functionIdx: number, functionName: string, ismethod: boolean)
        local target = typedefs[targetIdx]
        local func = functions[functionIdx]
        assert(func.type == "Function")
        
        if target.type == "Uncategorized" then
            return -- Do nothing if not a table or a typeofsetmetatable
        end

        func.data.name = functionName -- Set new function name

        if ismethod then
            -- Add self to the function
            table.insert(func.args, {
                name = "self",
                typ = target
            })
        end

        -- Inline the function into the table
        assert(target.data == "Table")
        tab.data.fields[func.name] = func

        return tab
    end]]
end