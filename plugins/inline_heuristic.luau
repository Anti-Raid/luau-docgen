-- Plugin to try inlining unions heuristically if there are too many variants
--!strict

local maxVariantsUntilForcedInlining = 5

local istate = require("../documentor_core/istate")

local inliner: istate.OptionalPlugin = {
    plugin_header = istate.PLUGIN_HEADER,
    onParseTypeFieldType = function(data: istate.ParseTypeFieldTypeData)
        local inline = data.inline
        if inline then return end -- Already inlined
        local fieldtype = data.typ:extract()
        if fieldtype.type == "Union" then
            if #fieldtype.data > maxVariantsUntilForcedInlining then
                data.inline = true :: boolean?
            end
        end
    end,
}

return inliner