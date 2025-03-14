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
    local fieldConstraints: string = "None"
    if type == "Boolean" then
        fieldConstraints = "true/false"
    end

    local blockNodes: {markdown.MarkdownNode} = {
        {
            type = "Text",
            text = markdown.NewMarkdownText_FromRaw("Field with the following constraints:")
        },
        {
            type = "List",
            entries = {
                markdown.NewMarkdownText_FromRaw("Type: " .. fieldType),
                markdown.NewMarkdownText_FromRaw("Constraints: " .. fieldConstraints)
            }
        }
    }

    return blockNodes
end

return {
    parseSimpleField = parseSimpleField
}