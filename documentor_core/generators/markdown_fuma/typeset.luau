--!strict
local types = require("../../types")
local markdown = require("./markdownir/markdown")
local finalizer = require("./finalizer")
local typeDocumentor = require("./type")
local istatemod = require("./istate")

local function documentTypeSet(istate: istatemod.IState, ast: types.TypeSet, modname: string, description: string): string
    istate.plugin.setTypeSet(ast)

    local typedefs: {types.Type} = {}
    local functions: {types.Type} = {}

    for _, typ in ast.types do
        if typ.type == "TypeDef" then
            typedefs[#typedefs + 1] = typ
        elseif typ.type == "Function" then
            functions[#functions + 1] = typ
        end
    end

    -- First add in the typedefs
    local typedefsBlock: {{markdown.MarkdownNode}} = {}
    for _, typ in typedefs do
        local typedef = typ
        assert(typedef.type == "TypeDef")
        print("Processing " .. typedef.data.name)
        local td = typeDocumentor.parseTypeDef(istate, typedef.data)

        typedefsBlock[#typedefsBlock + 1] = td -- Add to typedefsblock
    end

    --- Then add in the functions
    local functionsBlock: {{markdown.MarkdownNode}} = {} -- Final output string
    for _, typ in functions do
        local typedef = typ
        assert(typedef.type == "Function")
        print("Processing " .. typedef.data.name)
        local td = typeDocumentor.parseTypeFunction(istate, typedef.data)

        functionsBlock[#functionsBlock + 1] = td -- Add to functionsBlock
    end

    return finalizer.finalize(modname, description, typedefsBlock, functionsBlock)
end

return {
    documentTypeSet = documentTypeSet
} 