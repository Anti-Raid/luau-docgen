--!strict
local types = require("../../types")
local markdown = require("./markdownir/markdown")
local convertComments = require("./convertcomments")
local tableext = require("../../table")
local typefieldDocumentor = require("./typefield")
local istate = require("./istate")
local transformrepr = require("../../transformrepr")

local function parseTypeDef(istate: istate.IState, typ: types.TypeDef): {markdown.MarkdownNode} 
    local convComments = convertComments.convertComments(typ.type_comments, istate.ignorenondoc)

    if convComments.skip then
        return {} -- Ignore explicitly skipped types
    end

    -- Initial content/prelude
    local blockNodes: {markdown.MarkdownNode} = {}

    -- Add header node
    blockNodes[#blockNodes + 1] = {
        type = "Heading" :: "Heading",
        level = nil :: number?, -- Bug in luau new type solver needs this (for now)
        headingText = markdown.NewMarkdownText_FromRaw(typ.name)    
    }

    if #convComments.output > 0 then
        -- Add converted comments output as well
        tableext.extend(blockNodes, convComments.output)
    end

    -- Add code block of the type
    blockNodes[#blockNodes + 1] = markdown.MarkdownNode_CreateSnippet("Raw Type", {
        type = "CodeBlock" :: "CodeBlock", 
        language = "luau",
        text = transformrepr.transformTypeDefRepr(typ, ",\n\n\t", ", ")
    })

    tableext.extend(blockNodes, typefieldDocumentor.parseTypeFieldType(
        {
            istate = istate, 
            originRepr = transformrepr.transformTypeFieldTypeRepr(typ.typ),
            typ = typ.typ,
            convertedComments = convComments,
            depth = 0, -- Depth is 0 as we are at the top level
        }
    ))

    return blockNodes
end 

local function parseTypeFunction(istate: istate.IState, typ: types.TypeFunction): {markdown.MarkdownNode} 
    local convComments = convertComments.convertComments(typ.type_comments, istate.ignorenondoc)

    if convComments.skip then
        return {} -- Ignore explicitly skipped types
    end

    -- Initial content/prelude
    local blockNodes: {markdown.MarkdownNode} = {}

    -- Add header node
    blockNodes[#blockNodes + 1] = {
        type = "Heading" :: "Heading",
        level = nil :: number?, -- Bug in luau new type solver needs this (for now)
        headingText = markdown.NewMarkdownText_FromRaw(typ.name)    
    }

    if #convComments.output > 0 then
        -- Add converted comments output as well
        tableext.extend(blockNodes, convComments.output)
    end
 
    tableext.extend(blockNodes, typefieldDocumentor.parseFunction(
        istate,
        transformrepr.transformTypeFunction(typ, ", ", ", "),
        convComments,
        typ.generics,
        typ.args,
        typ.ret
    ))


    return blockNodes
end

return {
    parseTypeDef = parseTypeDef,
    parseTypeFunction = parseTypeFunction,
}