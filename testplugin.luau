local istate = require("src/builtins/istate")
local types = require("src/builtins/types")
return {
    plugin_header = istate.PLUGIN_HEADER,
    setTypeSet = function(typeset: types.TypeSet)
        -- Do nothing
    end,

    onInitialize = function(istate: istate.IState)
        -- Do nothing
    end
}