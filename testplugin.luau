local types = require("src/builtins/types.luau")
return {
    plugin_header = "LUAU_DOCGEN_PLUGIN",
    setTypeSet = function(typeset)
        -- Do nothing
    end,

    onInitialize = function(istate)
        -- Do nothing
    end
}