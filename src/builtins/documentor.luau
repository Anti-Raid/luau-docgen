--!strict

-- Before doing anything else, make sure we can safely require stuff
print("Running reqtest self-test for requires")
local a = require"reqtest/a.luau"
assert(a.a == 1) -- Ensure stable requires
print("Passed reqtest self-test for requires")

local types = require("types.luau")
local argparser = require("argparser.luau")
local markdown = require("markdownir/markdown.luau")
local tableext = require("table.luau")
local finalizer = require("finalizer/defaultfinalizer.luau")
local typeDocumentor = require("documentors/type.luau")

local ast: types.TypeSet, globals: types.Globals = ... -- Passed as arguments
assert(ast, "No AST passed to documentor")
assert(globals, "No globals passed to documentor")

local p1 = tableext.extend({2}, {4})
assert(p1[1] == 2, "Inconsistent state: tableext.arrayextend failed to copy over 1")
assert(p1[2] == 4, "Inconsistent state: tableext.arrayextend failed to copy over 2")

-- Parse arguments at top-level
local md = argparser.parseArguments(globals)

-- First add in the typedefs
local typedefsBlock: {{markdown.MarkdownNode}} = {}
for typ in ast:iter_typedefs() do
    local typedef = typ:extract()
    assert(typedef.type == "TypeDef")
    print("Processing " .. typedef.data.name)
    local td = typeDocumentor.parseTypeDef(globals, md, typedef.data)

    typedefsBlock[#typedefsBlock + 1] = td -- Add to typedefsblock
end

--- Then add in the functions
local functionsBlock: {{markdown.MarkdownNode}} = {} -- Final output string
for typ in ast:iter_functions() do
    local typedef = typ:extract()
    assert(typedef.type == "Function")
    print("Processing " .. typedef.data.name)
    local td = typeDocumentor.parseTypeFunction(globals, md, typedef.data)

    functionsBlock[#functionsBlock + 1] = td -- Add to functionsBlock
end

return finalizer.finalize(globals, md, typedefsBlock, functionsBlock)