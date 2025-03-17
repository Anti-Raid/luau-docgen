--!strict
print("Running reqtest self-test for requires in plugin")
local a = require"../documentor_core/reqtest/a"
assert(a.a == 1) -- Ensure stable requires
print("Passed reqtest self-test for requires")

local istate = require("../documentor_core/istate")
local types = require("../documentor_core/types")
return {
    plugin_header = istate.PLUGIN_HEADER,
    setTypeSet = function(typeset: types.TypeSet)
        -- Do nothing
    end,

    onInitialize = function(istate: istate.IState)
        -- Do nothing
    end
}