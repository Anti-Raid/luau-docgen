--!strict

local types = require("./types.luau")
local argparser = require("./argparser.luau")

-- Common internal state
export type IState = {
    globals: types.Globals,
    md: argparser.ParsedArgumentResult,
    plugin: Plugin
}

--- The header that must be set in the plugin
local PLUGIN_HEADER = "LUAU_DOCGEN_PLUGIN"

--- A plugin is a Luau module that can be used to influence documentor behavior
---
--- Only one plugin can be set at a time. The builtin `chain` plugin can be used to chain
--- multiple plugins together.
export type Plugin = {
    -- This field must be set to `PLUGIN_HEADER` to ensure return type is correct
    plugin_header: string,

    -- Called upon a new typeset being used/found
    --
    -- This is usually the first function called of the plugin
    setTypeSet: (typeset: types.TypeSet) -> (),

    --[[ 
Called when the documentor is first initialized 

Can be used to modify the istate before the documentor runs as tables are passed by reference in Lua
 
```luau
> a = {a = 1}
> a.a
1
> function b(c) c.a = 2 end
> b(a)
> a.a
2 
``` 
    ]]
    onInitialize: (istate: IState) -> ()

}

local DefaultPlugin: Plugin = {
    plugin_header = PLUGIN_HEADER,
    setTypeSet = function(typeset: types.TypeSet)
        -- Do nothing
    end,

    onInitialize = function(istate: IState)
        -- Do nothing
    end
}

return {
    PLUGIN_HEADER = PLUGIN_HEADER,
    DefaultPlugin = DefaultPlugin,
}