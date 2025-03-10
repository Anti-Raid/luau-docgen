--!strict
local types = require("types.luau")
local convertComments = require("convertcomments.luau")
local parseArguments = require("argparser.luau")

-- Begin of documentation generation actual code
local ast: types.TypeSet, globals: types.Globals = ...

local output = "" -- Final output string

-- First insert prelude
local md = parseArguments(globals)

if md.modname ~= "" then
    output ..= ("# " .. md.modname .. "\n\n")
else 
    output ..= ("# Documentation\n\n")
end

for typ in ast:iter_typedefs() do
    local convComments = convertComments(globals, typ:type_comments())

    if convComments.skip then
        continue -- Ignore explicitly skipped types
    end

    output ..= ("## " .. typ:name() .. "\n\n" .. convComments.output .. "\n")
    output ..= ("### Raw Type\n\n```luau\n" .. typ:string_repr_with_pats(",\n\n\t", ", ", ", ") .. "\n```\n")
end

for typ in ast:iter_functions() do
    local convComments = convertComments(globals, typ:type_comments())

    if convComments.skip then
        continue -- Ignore explicitly skipped types
    end

    output ..= ("## " .. typ:name() .. "\n\n" .. convComments.output .. "\n")
    output ..= ("### Function Signature\n\n```luau\n" .. typ:string_repr_with_pats(",\n\n\t", ", ", ", ") .. "\n```\n")
end

return output