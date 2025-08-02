--!strict

local markdown = require("./markdownir/markdown")
local fmt = require("./markdownir/markdownformatter")

--- Given the typedefs block, the functions block
local function finalize(modname: string, description: string, typedefsBlock: {{markdown.MarkdownNode}}, functionsBlock: {{markdown.MarkdownNode}}): string
    local header = `---\ntitle: "{modname and #modname > 0 or "Untitled"}"\ndescription: "{description and #description > 0 or "No description"}"\n---`
    
    -- Finally, combine the two
    if modname ~= "" then
        local nodes: {markdown.MarkdownNode} = {
            {
                type = "Heading" :: "Heading",
                headingText = markdown.NewMarkdownText_FromRaw(modname)
            }, 
        } :: {markdown.MarkdownNode}

        if #typedefsBlock > 0 then
            nodes[#nodes + 1] = {
                type = "Heading" :: "Heading",
                level = 2, -- Special case is needed here because yeah
                headingText = markdown.NewMarkdownText_FromRaw("Types")
            } :: markdown.MarkdownNode
        end

        for _, typedefBlock in typedefsBlock do
            nodes[#nodes + 1] = {
                type = "Block" :: "Block",
                nodes = typedefBlock
            }
        end

        if #functionsBlock > 0 then
            nodes[#nodes + 1] = {
                type = "Heading" :: "Heading",
                headingText = markdown.NewMarkdownText_FromRaw("Functions")
            } :: markdown.MarkdownNode
        end

        for _, functionBlock in functionsBlock do
            nodes[#nodes + 1] = {
                type = "Block" :: "Block",
                nodes = functionBlock
            }
        end

        local block = {
            type = "Block" :: "Block",
            nodes = nodes
        } :: markdown.MarkdownNode

        return header .. "\n\n" .. fmt.MarkdownNode_String(block, true, 0, "Root") -- Convert to markdown
    else
        local nodes: {markdown.MarkdownNode} = {} :: {markdown.MarkdownNode}

        if #typedefsBlock > 0 then
            nodes[#nodes + 1] = {
                type = "Heading" :: "Heading",
                headingText = markdown.NewMarkdownText_FromRaw("Types")
            } :: markdown.MarkdownNode
        end

        for _, typedefBlock in typedefsBlock do
            nodes[#nodes + 1] = {
                type = "Block" :: "Block",
                nodes = typedefBlock
            }
        end

        if #functionsBlock > 0 then
            nodes[#nodes + 1] = {
                type = "Heading" :: "Heading",
                headingText = markdown.NewMarkdownText_FromRaw("Functions")
            } :: markdown.MarkdownNode
        end

        for _, functionBlock in functionsBlock do
            nodes[#nodes + 1] = {
                type = "Block" :: "Block",
                nodes = functionBlock
            }
        end

        local block = {
            type = "Block" :: "Block",
            nodes = nodes
        } :: markdown.MarkdownNode

        return header .. "\n\n" .. fmt.MarkdownNode_String(block, true, 0, "Root") -- Convert to markdown
    end
end

--- A finalizer takes in as input the nodes and markdown metadata and produces the final output using a markdown IR formatter
return {
    finalize = finalize,
}