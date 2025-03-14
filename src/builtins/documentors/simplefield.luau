--!strict

local markdown = require("../markdownir/markdown.luau")
local convertComments = require("../convertcomments.luau") 

--- Helper function to parse a simple (Basic/String/Boolean literal) field
local function parseSimpleField(
    originRepr: string?,
    type: string,
    data: string,
    convertedComments: convertComments.ConvertCommentResponse
): {markdown.MarkdownNode} 
    local fieldType: string = data
    if type == "Boolean" then
        fieldType ..= " (a boolean literal)"
    elseif type == "String" then
        fieldType ..= " (a string literal)"
    end

    local blockNodes: {markdown.MarkdownNode} = {
        {
            type = "Text" :: "Text",
            text = markdown.NewMarkdownText_FromRaw("Field with the following constraints:")
        },
        {
            type = "List" :: "List",
            entries = {
                markdown.NewMarkdownText_FromRaw("Type: " .. fieldType),
            }
        }
    } :: {markdown.MarkdownNode}

    return blockNodes
end

return {
    parseSimpleField = parseSimpleField
}