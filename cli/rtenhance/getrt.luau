--!strict

local types = require("./base")
local defaults = require("./defaults")

local function getrt(): types.Globals
    local isLune, _ = pcall(require, "@lune/fs")
    
    if isLune then 
        return require("./lune")
    end

    return {
        runtime = "UnknownRt",
        documentor_args = {},
        parsetotypeset = defaults.defaultParseToTypeSet,
        fs_ops = nil,
        proc_ops = nil,
    }
end

return getrt