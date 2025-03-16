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
    onInitialize: (istate: IState) -> (),

    --- Resolves a module to a link/url
    resolveModule: (module: string) -> string,

    --- Resolves a type to a link/url
    resolveType: (fieldtype: string, type: string) -> string,
}

local DefaultPlugin: Plugin = {
    plugin_header = PLUGIN_HEADER,
    setTypeSet = function(typeset: types.TypeSet)
        -- Do nothing
    end,

    onInitialize = function(istate: IState)
        -- Do nothing
    end,

    resolveModule = function(module: string): string
        -- Default implementation
        return `#module.{module}`
    end,

    resolveType = function(fieldtype: string, type: string): string
        -- Default implementation
        return `#{type}`
    end,
}

--- Attempts to load a plugin at path
local function loadPlugin(istate: IState, path: string): Plugin
    istate.globals.require_builtins = false
    local ok, plugin: Plugin? = pcall(require, istate.md.plugin)
    
    if not ok then
        istate.globals.require_builtins = true -- Reset to default to avoid side effects
        error("Failed to load plugin: " .. path .. " - " .. tostring(plugin) .. " - " .. tostring(ok))
    end
    
    if not plugin then
        istate.globals.require_builtins = true -- Reset to default to avoid side effects
        error("Requested plugin " .. path .. " returned no result")
    end

    istate.globals.require_builtins = true -- Reset to default to avoid side effects

    assert(type(plugin) == "table" or type(plugin) == "userdata", "Invalid plugin load request. Plugin is not a table or userdata: " .. tostring(plugin))
    assert(plugin.plugin_header == PLUGIN_HEADER, "Invalid plugin load request. Plugin header mismatch: " .. tostring(plugin.plugin_header) .. " != " .. PLUGIN_HEADER)

    return plugin
end

return {
    PLUGIN_HEADER = PLUGIN_HEADER,
    DefaultPlugin = DefaultPlugin,
    loadPlugin = loadPlugin,
}