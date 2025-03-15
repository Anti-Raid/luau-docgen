--!strict
local types = require("../types.luau")
local markdown = require("../markdownir/markdown.luau")
local finalizer = require("../finalizer/defaultfinalizer.luau")
local typeDocumentor = require("../documentors/type.luau")
local istatemod = require("../istate.luau")

local function documentTypeSet(istate: istatemod.IState, ast: types.TypeSet)
    istate.plugin.setTypeSet(ast)

    -- First add in the typedefs
    local typedefsBlock: {{markdown.MarkdownNode}} = {}
    for typ in ast:iter_typedefs() do
        local typedef = typ:extract()
        assert(typedef.type == "TypeDef")
        print("Processing " .. typedef.data.name)
        local td = typeDocumentor.parseTypeDef(istate, typedef.data)

        typedefsBlock[#typedefsBlock + 1] = td -- Add to typedefsblock
    end

    --- Then add in the functions
    local functionsBlock: {{markdown.MarkdownNode}} = {} -- Final output string
    for typ in ast:iter_functions() do
        local typedef = typ:extract()
        assert(typedef.type == "Function")
        print("Processing " .. typedef.data.name)
        local td = typeDocumentor.parseTypeFunction(istate, typedef.data)

        functionsBlock[#functionsBlock + 1] = td -- Add to functionsBlock
    end

    return finalizer.finalize(istate, typedefsBlock, functionsBlock)
end

return {
    documentTypeSet = documentTypeSet
}