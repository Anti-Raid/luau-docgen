--!strict

local types = require("./types")
local convertComments = require("./convertcomments")
local argparser = require("./argparser")

-- Common internal state
export type IState = {
    globals: types.Globals,
    md: argparser.ParsedArgumentResult,
    plugin: Plugin
}

--- Data passed to typefieldtype
export type ParseTypeFieldTypeData = {
    istate: IState,
    --- Full repr of the type originally prior to descent
    originRepr: string?, 
    --- The type being parsed
    typ: types.TypeFieldType,
    --- Converted comments for the type field itself 
    convertedComments: convertComments.ConvertCommentResponse,
    --- Whether the type field is inline or not
    inline: boolean?,
    --- Current depth of the type relative to the root
    depth: number,
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

    --- Resolves a type to a link/url
    resolveTypeToUrl: (fieldtype: string, type: string) -> string,

    --- Resolves a module type to the module url and type url
    resolveModuleToUrl: (fieldtype: string, module: string, type: string) -> {
        moduleUrl: string,
        typeUrl: string,
    },

    --- Called when a type field is being parsed. Can be used to modify how types are parsed
    onParseTypeFieldType: (data: ParseTypeFieldTypeData) -> (),
}

export type OptionalPlugin = {
    -- This field must be set to `PLUGIN_HEADER` to ensure return type is correct
    plugin_header: string,

    -- Called upon a new typeset being used/found
    --
    -- This is usually the first function called of the plugin
    setTypeSet: ((typeset: types.TypeSet) -> ())?,

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
    onInitialize: ((istate: IState) -> ())?,

    --- Resolves a type to a link/url
    resolveTypeToUrl: ((fieldtype: string, type: string) -> string)?,

    --- Resolves a module type to the module url and type url
    resolveModuleToUrl: ((fieldtype: string, module: string, type: string) -> {
        moduleUrl: string,
        typeUrl: string,
    })?,

    --- Called when a type field is being parsed. Can be used to modify how types are parsed
    onParseTypeFieldType: ((data: ParseTypeFieldTypeData) -> ())?,    
}

local DefaultPlugin: Plugin = {
    plugin_header = PLUGIN_HEADER,
    setTypeSet = function(typeset: types.TypeSet)
        -- Do nothing
    end,

    onInitialize = function(istate: IState)
        -- Do nothing
    end,

    resolveModuleToUrl = function(fieldtype: string, module: string, type: string): {
        moduleUrl: string,
        typeUrl: string
    }
        -- Default implementation
        return {
            moduleUrl = `#module.{module}`,
            typeUrl = `#{type}`,
        }
    end,

    resolveTypeToUrl = function(fieldtype: string, type: string): string
        -- Default implementation
        return `#{type}`
    end,

    onParseTypeFieldType = function(data: ParseTypeFieldTypeData)
        -- Do nothing
    end,
}

local ChainPlugin = {}
ChainPlugin.__index = ChainPlugin

function ChainPlugin.new(plugins: {OptionalPlugin}): Plugin
    local ChainPlugin = {
        plugin_header = PLUGIN_HEADER,
    }

    function ChainPlugin.chainWith(plugin: Plugin)
        table.insert(plugins, plugin)
    end

    function ChainPlugin.setTypeSet(typeset: types.TypeSet)
        for _, plugin in plugins do
            if plugin.setTypeSet then
                plugin.setTypeSet(typeset)
            end
        end
    end

    function ChainPlugin.onInitialize(istate: IState)
        for _, plugin in plugins do
            if plugin.onInitialize then
                plugin.onInitialize(istate)
            end
        end
    end

    function ChainPlugin.resolveModuleToUrl(fieldtype: string, module: string, type: string): {
        moduleUrl: string,
        typeUrl: string,
    }
        for _, plugin in plugins do
            if plugin.resolveModuleToUrl then
                local url = plugin.resolveModuleToUrl(fieldtype, module, type)
                if url and url.moduleUrl and url.typeUrl and url.moduleUrl ~= "" and url.typeUrl ~= "" then
                    return url
                end
            end
        end

        return DefaultPlugin.resolveModuleToUrl(fieldtype, module, type)
    end

    function ChainPlugin.resolveTypeToUrl(fieldtype: string, type: string): string
        for _, plugin in plugins do
            if plugin.resolveTypeToUrl then
                local url = plugin.resolveTypeToUrl(fieldtype, type)
                if url and url ~= "" then
                    return url
                end
            end
        end

        return DefaultPlugin.resolveTypeToUrl(fieldtype, type)
    end

    function ChainPlugin.onParseTypeFieldType(data: ParseTypeFieldTypeData)
        for _, plugin in plugins do
            if plugin.onParseTypeFieldType then
                plugin.onParseTypeFieldType(data)
            end
        end
    end

    return setmetatable(ChainPlugin, ChainPlugin)
end

--- Attempts to load a plugin at path
local function loadPlugin(istate: IState, path: string): Plugin
    local ok, plugin: Plugin? = pcall(require, path)
    
    if not ok then
        error("Failed to load plugin: " .. path .. " - " .. tostring(plugin) .. " - " .. tostring(ok))
    end
    
    if not plugin then
        error("Requested plugin " .. path .. " returned no result")
    end

    -- If type(plugin) is a function, then call it with the current istate to allow for plugin chaining

    assert(type(plugin) == "table" or type(plugin) == "userdata", "Invalid plugin load request. Plugin is not a table or userdata: " .. tostring(plugin))
    assert(plugin.plugin_header == PLUGIN_HEADER, "Invalid plugin load request. Plugin header mismatch: " .. tostring(plugin.plugin_header) .. " != " .. PLUGIN_HEADER)

    return plugin
end

--- Attempts to load all plugins desired
local function loadAllPlugins(istate: IState, plugins: {string}): Plugin
    local loadedPlugins: {OptionalPlugin} = {}

    for _, plugin in plugins do
        loadedPlugins[#loadedPlugins + 1] = loadPlugin(istate, plugin) :: OptionalPlugin
    end

    if #loadedPlugins == 0 then
        return DefaultPlugin
    end

    -- Otherwise, chain them together
    return ChainPlugin.new(loadedPlugins)
end

return {
    PLUGIN_HEADER = PLUGIN_HEADER,
    DefaultPlugin = DefaultPlugin, 
    loadPlugin = loadPlugin,
    loadAllPlugins = loadAllPlugins,
}