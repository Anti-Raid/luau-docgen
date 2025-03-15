--!strict

local types = require("./types.luau")
local pluginapi = require("./pluginsapi/types.luau")
local argparser = require("./argparser.luau")

-- Common internal state
export type IState = {
    globals: types.Globals,
    md: argparser.ParsedArgumentResult,
    plugin: pluginapi.Plugin
}

return {}