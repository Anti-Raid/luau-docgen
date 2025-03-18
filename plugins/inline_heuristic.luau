-- Plugin to try inlining unions heuristically if there are too many variants
--!strict

local maxVariantsForInlining = 5

local istate = require("../documentor_core/istate")

local inliner: istate.OptionalPlugin = {
    plugin_header = istate.PLUGIN_HEADER,
    onParseTypeFieldType = function(data: istate.ParseTypeFieldTypeData)
        local inline = data.inline
        if inline then return end -- Already inlined
        local fieldtype = data.typ:extract()
        if fieldtype.type == "Union" then
            if #fieldtype.data > maxVariantsForInlining then
                return
            end

            -- If theres a table type in the union, then inlining is not a good idea design-wise
            for _, variant in fieldtype.data do
                local extracted = variant:extract()
                if extracted.type == "Table" then
                    return
                end
            end

            if #fieldtype.data <= maxVariantsForInlining then
                data.inline = true :: boolean?
            end
        end
    end,
}

return inliner