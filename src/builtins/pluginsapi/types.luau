--!strict

local types = require("../types")

--- A plugin is a Luau module that can be used to influence documentor behavior
---
--- Only one plugin can be set at a time. The builtin `chain` plugin can be used to chain
--- multiple plugins together.
export type Plugin = {
    -- Called upon a new typeset being used/found
    --
    -- This is usually the first function called of the plugin
    setTypeSet: (typeset: types.TypeSet) -> ()
}

local DefaultPlugin: Plugin = {
    setTypeSet = function(typeset: types.TypeSet)
        -- Do nothing
    end
}

return {
    DefaultPlugin = DefaultPlugin,
}