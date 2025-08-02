--!strict

local DEFAULTMAX_VARIANTS_FOR_INLING = 5

local istate = require("../istate")

--- Plugin to try inlining unions heuristically if there are too many variants
local function CreateInlinerPlugin(maxVariantsForInlining_value: number?): istate.OptionalPlugin
    local maxVariantsForInlining = maxVariantsForInlining_value or DEFAULTMAX_VARIANTS_FOR_INLING

    local inliner: istate.OptionalPlugin = {
        plugin_header = istate.PLUGIN_HEADER,
        onParseTypeFieldType = function(data: istate.ParseTypeFieldTypeData)
            local inline = data.inline
            if inline then return end -- Already inlined
            local fieldtype = data.typ
            if fieldtype.type == "Union" then
                if #fieldtype.data > maxVariantsForInlining then
                    return
                end

                -- If theres a table type in the union, then inlining is not a good idea design-wise
                for _, variant in fieldtype.data do
                    local extracted = variant -- Avoid typechecker refinement issues
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
end

return {
    CreateInlinerPlugin = CreateInlinerPlugin,
}
