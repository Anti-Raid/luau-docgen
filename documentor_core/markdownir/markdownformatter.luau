--!strict

local types = require("../types")
local tableext = require("../table")
local markdown = require("./markdown")
local pp = require("../pp")

local function MarkdownTextNode_String(n: markdown.MarkdownTextNode): string
    if n.style == "Italics" then 
        local stringified = table.concat(
            tableext.arraymap(
                n.node, 
                function(node: markdown.MarkdownTextNode): string
                    return MarkdownTextNode_String(node)
                end,
                ""
            )
        )
        return "*" .. stringified .. "*" 
    elseif n.style == "Bold" then 
        local stringified = table.concat(
            tableext.arraymap(
                n.node, 
                function(node: markdown.MarkdownTextNode): string
                    return MarkdownTextNode_String(node)
                end,
                ""
            )
        )
        return "**" .. stringified .. "**" 
    elseif n.style == "Code" then 
        local stringified = table.concat(
            tableext.arraymap(
                n.node, 
                function(node: markdown.MarkdownTextNode): string
                    return MarkdownTextNode_String(node)
                end,
                ""
            )
        )
        return "`" .. stringified .. "`"    
    elseif n.style == "Unstyled" then 
        return "" .. n.text:gsub("*", "\\*"):gsub("<", "&lt;"):gsub(">", "&gt;") .. ""
    elseif n.style == "Raw" then return n.text
    else return n.node end
end

function MarkdownText_String(globals: types.Globals, t: markdown.MarkdownText): string 
    assert(t.nodes, "Invalid IR: MarkdownText must have nodes: [" .. pp(t) .. "]")
    return table.concat(
        tableext.arraymap(
            t.nodes, 
            function(node: markdown.MarkdownTextNode): string
                return MarkdownTextNode_String(node)
            end,
            ""
        )
    )
end

--- Converts a markdown node to a string using mdbook-compatible formatting
---
--- For other markdown variants, it may be desirable to make a custom markdown formatter
local function MarkdownNode_String(globals: types.Globals, n: markdown.MarkdownNode, strictValidation: boolean?, depth: number?, label: string?, inline: boolean?): string
    local nodeDepth = depth or 0
    --print(n.type) --pp(n))
    --print("Processing " .. n.type .. " with depth " .. tostring(nodeDepth) .. " and label " .. tostring(label) .. " and fragment " .. pp(n))
    if n.type == "Heading" then 
        local depthToUse = n.level or nodeDepth
        if strictValidation and depthToUse and depthToUse < nodeDepth then
            error(`Internal error - Invalid IR: n.level of {n.level} < nodeDepth of {nodeDepth}`)
        end

        if depthToUse > 5 then
            depthToUse = 5
        end

        local text = MarkdownText_String(globals, n.headingText)

        if inline then 
            error("Inline headings are not supported yet")
        end

        return "<div id=\"" .. text:gsub(" ", "") .. "\"></div>\n\n" .. string.rep("#", depthToUse) .. " " .. text .. "\n\n"
    elseif n.type == "CodeBlock" then 
        local language = n.language
        local text = n.text :: string

        if inline then 
            error("Inline code blocks are not supported yet")
        end

        return "```" .. language .. "\n" .. text .. "\n```\n\n"
    elseif n.type == "Snippet" then 
        local detailsText = n.detailsText
        local node = n.node
        assert(detailsText, "Invalid IR: Snippet node must have a details text")
        assert(node, "Invalid IR: Snippet node must have a node")

        if inline then 
            error("Inline snippets are not supported yet")
        end

        return "<details>\n<summary>" .. detailsText .. "</summary>\n\n" .. MarkdownNode_String(globals, node, strictValidation, nodeDepth+1, tostring(label) .. "/Snippet@" .. tostring(nodeDepth), inline) .. "</details>\n\n"
    elseif n.type == "Block" then 
        local nodes = n.nodes
        assert(nodes, "Invalid IR: Block node must have nodes")

        local sep = "\n\n"
        if inline then 
            sep = ""
        end

        return table.concat(
            tableext.arraymap(
                nodes, 
                function(node: markdown.MarkdownNode): string
                    --print("Processing block node " .. pp(node) .. " with label " .. tostring(label))
                    return MarkdownNode_String(globals, node, strictValidation, nodeDepth+1, tostring(label) .. "/Block@" .. tostring(nodeDepth), inline)
                end,
                sep
            )
        )
    elseif n.type == "InlineBlock" then
        local nodes = n.nodes
        assert(nodes, "Invalid IR: InlineBlock node must have nodes")

        local sep = "\n\n"
        if inline or n.inline then 
            sep = ""
        end

        return table.concat(
            tableext.arraymap(
                nodes, 
                function(node: markdown.MarkdownNode): string
                    --print("Processing inline block node " .. pp(node) .. " with label " .. tostring(label))
                    return MarkdownNode_String(globals, node, strictValidation, nodeDepth, tostring(label) .. "/InlineBlock", n.inline)
                end,
                sep
            )
        )
    elseif n.type == "Warning" then
        local text = n.text :: markdown.MarkdownText
        assert(text, "Invalid IR: Warning node must have text")

        if inline then 
            error("Inline warnings are not supported yet")
        end

        return "<div class=\"warning\">\n" .. MarkdownText_String(globals, text) .. "\n</div>\n\n"
    elseif n.type == "Text" then
        local text = n.text :: markdown.MarkdownText
        assert(text, "Invalid IR: Text node must have text")

        if inline or n.inline then 
            return MarkdownText_String(globals, text)
        end

        return MarkdownText_String(globals, text) .. "\n\n"
    elseif n.type == "Link" then
        local url = n.url
        local text = n.text :: markdown.MarkdownText
        assert(url, "Invalid IR: Link node must have a URL")
        assert(text, "Invalid IR: Link node must have text")

        local link = "[" .. MarkdownText_String(globals, text):gsub("<", "&lt;"):gsub(">", "&gt;") .. "](" .. url:gsub("<", "."):gsub(">", ""):gsub(",", ".") .. ")"
        if inline or n.inline then 
            return link
        end

        return link .. "\n\n"
    elseif n.type == "List" then
        local tabData = n :: any -- Luau type solver workaround
        local entries = tabData.entries :: {markdown.MarkdownText}
        assert(entries, "Invalid IR: List node must have entries")

        if inline then 
            error("Inline lists are not supported yet")
        end

        local output = ""
        for i, item in entries do
            if i == #entries then
                output ..= "- " .. MarkdownText_String(globals, item) .. "\n\n"
            else
                output ..= "- " .. MarkdownText_String(globals, item) .. "\n"
            end
        end
    
        return output    
    elseif n.type == "Table" then 
        local tabData = n :: any -- Luau type solver workaround
        local headers = tabData.headers :: {markdown.MarkdownText}
        local rowset = tabData.rowset :: {{markdown.MarkdownText}}
        assert(headers, "Invalid IR: Table node must have headers")
        assert(rowset, "Invalid IR: Table node must have rowset")

        if inline then 
            error("Inline tables are not supported yet")
        end

        local function parseCell(cell: markdown.MarkdownText): string
            return MarkdownText_String(globals, cell):gsub("\n", "<br>") :: string
        end
    
        local output = "|"
    
        for _, header in ipairs(headers) do
            output ..= MarkdownText_String(globals, header) .. "|"
        end
    
        output ..= "\n|"
    
        for _ = 1, #headers do
            output ..= "---|"
        end
    
        output ..= "\n"
    
        for i, row in ipairs(rowset) do
            output ..= "|"
    
            for _, cell in ipairs(row) do
                output ..= parseCell(cell) .. "|"
            end
    
            if i ~= #rowset then
                output ..= "\n"
            end
        end
    
        return output    
    else 
        print("Invalid IR: MarkdownNode must have a valid type: " .. pp(n.type) .. " with type " .. pp(n) .. " and label " .. tostring(label) .. "!") 
        error("Invalid IR: MarkdownNode must have a valid type. See above for more details")
    end
end

--- Default markdown formatter for mdbook
---
--- For other markdown variants, it may be desirable to make a custom markdown formatter
return {
    MarkdownTextNode_String = MarkdownTextNode_String,
    MarkdownText_String = MarkdownText_String,
    MarkdownNode_String = MarkdownNode_String,
}