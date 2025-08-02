-- Plugin to try inlining unions heuristically if there are too many variants
--!strict

local MAX_VARIANTS_FOR_INLING = 5

local istate = require("../../istate")

local inliner: istate.OptionalPlugin = {
    plugin_header = istate.PLUGIN_HEADER,
    onParseTypeFieldType = function(data: istate.ParseTypeFieldTypeData)
        local inline = data.inline
        if inline then return end -- Already inlined
        local fieldtype = data.typ
        if fieldtype.type == "Union" then
            if #fieldtype.data > MAX_VARIANTS_FOR_INLING then
                return
            end

            -- If theres a table type in the union, then inlining is not a good idea design-wise
            for _, variant in fieldtype.data do
                local extracted = variant -- Avoid typechecker refinement issues
                if extracted.type == "Table" then
                    return
                end
            end

            if #fieldtype.data <= MAX_VARIANTS_FOR_INLING then
                data.inline = true :: boolean?
            end
        end
    end,
}

return inliner