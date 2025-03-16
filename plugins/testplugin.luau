--!strict
print("Running reqtest self-test for requires in plugin")
local a = require"../src/builtins/reqtest/a"
assert(a.a == 1) -- Ensure stable requires
print("Passed reqtest self-test for requires")

local istate = require("../src/builtins/istate")
local types = require("../src/builtins/types")
return {
    plugin_header = istate.PLUGIN_HEADER,
    setTypeSet = function(typeset: types.TypeSet)
        -- Do nothing
    end,

    onInitialize = function(istate: istate.IState)
        -- Do nothing
    end
}