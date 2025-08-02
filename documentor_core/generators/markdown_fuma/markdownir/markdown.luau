--!strict

export type MarkdownTextNode = {
    text: string,
    style: "Raw",
} | {
    node: {MarkdownTextNode},
    style: "Bold"
} | {
    node: {MarkdownTextNode},
    style: "Italics"
} | {
    node: {MarkdownTextNode},
    style: "Code",
} | {
    text: string,
    style: "Unstyled"
} | {
    text: {MarkdownTextNode},
    url: string,
    style: "Link", -- Special link node (useful for Fuma tables)
}

local function NewMarkdownTextNode_BoldArray(nodes: {MarkdownTextNode}): MarkdownTextNode
    return {
        node = nodes,
        style = "Bold" :: "Bold"
    }
end

local function NewMarkdownTextNode_Bold(...: MarkdownTextNode): MarkdownTextNode
    return {
        node = {...},
        style = "Bold" :: "Bold"
    }
end

local function NewMarkdownTextNode_ItalicsArray(nodes: {MarkdownTextNode}): MarkdownTextNode
    return {
        node = nodes,
        style = "Italics" :: "Italics"
    }
end

local function NewMarkdownTextNode_Italics(...: MarkdownTextNode): MarkdownTextNode
    return {
        node = {...},
        style = "Italics" :: "Italics"
    }
end

local function NewMarkdownTextNode_CodeArray(nodes: {MarkdownTextNode}): MarkdownTextNode
    return {
        node = nodes,
        style = "Code" :: "Code"
    }
end

local function NewMarkdownTextNode_Code(...: MarkdownTextNode): MarkdownTextNode
    return {
        node = {...},
        style = "Code" :: "Code"
    }
end

local function NewMarkdownTextNode_Unstyled(node: string): MarkdownTextNode
    return {
        text = node,
        style = "Unstyled" :: "Unstyled"
    }
end

local function NewMarkdownTextNode_Raw(node: string): MarkdownTextNode
    return {
        text = node,
        style = "Raw" :: "Raw"
    }
end

local function NewMarkdownTextNode_Link(node: {MarkdownTextNode}, url: string): MarkdownTextNode
    return {
        text = node,
        url = url,
        style = "Link" :: "Link"
    }
end

export type MarkdownText = {
    nodes: {MarkdownTextNode}
}

local function NewMarkdownText_FromRaw(text: string): MarkdownText
    return {
        nodes = {
            NewMarkdownTextNode_Raw(text)
        }
    }
end

local function NewMarkdownText_FromUnstyled(text: string): MarkdownText
    return {
        nodes = {
            NewMarkdownTextNode_Unstyled(text)
        }
    }
end

local function NewMarkdownText_FromNodeArray(nodes: {MarkdownTextNode}): MarkdownText
    return {
        nodes = nodes,
    }
end

local function NewMarkdownText_FromNodes(...: MarkdownTextNode): MarkdownText
    return {
        nodes = {...}
    }
end

--- Converts a MarkdownNode to a string
--- MarkdownNode provides a psuedo markdown structure that may include user-inputted content as well. As such,
--- a MarkdownNode is merely an IR to help produce documentation than a full AST
export type MarkdownNode = {
    type: "Heading",
    level: number?,
    headingText: MarkdownText,
} | {
    type: "CodeBlock",
    language: string, 
    text: string, 
} | {
    type: "Snippet", -- A snippet is a node contained within a <details>
    detailsText: string,
    node: MarkdownNode,
} | {
    type: "Block", -- A block allows for a set of nodes to be nested within it with increasing depth
    nodes: {MarkdownNode},
} | {
    type: "InlineBlock", -- An inline block allows for a set of nodes to be nested within it with the same depth
    nodes: {MarkdownNode},
    inline: boolean?, -- Whether to add a newline between each element of the block (default: false)
} | {
    type: "Warning",
    text: MarkdownText,
} | {
    type: "Text",
    text: MarkdownText,
    inline: boolean?, -- Whether to add a newline between each element of the block (default: false)
} | {
    type: "Link",
    text: MarkdownText, 
    inline: boolean?, -- Whether to add a newline between each element of the block (default: false)
    url: string -- May be relative to a Heading which should be handled in formatter impl
} | {
    type: "Table",
    headers: {MarkdownText},
    --- A set of rows, each row is a set of strings mapping to the table headers
    rowset: {{MarkdownText}}, 
} | {
    type: "List",
    entries: {MarkdownText}
} | {
    type: "FumaTypeTable",
    columns: {FumaTypeTableColumn}, -- The columns of the table
}

export type FumaTypeTableColumn = {
    field: string, -- The name of the field
    typename: MarkdownText, -- The type of the field
    description: MarkdownText, -- The description of the type
    required: boolean, -- Whether the 
}

local function MarkdownNode_CreateSnippet(
    detailsText: string,
    node: MarkdownNode
): MarkdownNode
    return {
        type = "Snippet",
        detailsText = detailsText,
        node = node
    }
end

local function MarkdownNode_FumaTypeTable(
    columns: {FumaTypeTableColumn}
): MarkdownNode
    return {
        type = "FumaTypeTable",
        columns = columns,
    }
end

--- To allow for more seamless markdown handling, a second 'markdown IR (intermediate representation)' is constructed which is then
--- converted to the final markdown
return {
    NewMarkdownTextNode_BoldArray = NewMarkdownTextNode_BoldArray,
    NewMarkdownTextNode_Bold = NewMarkdownTextNode_Bold,
    NewMarkdownTextNode_ItalicsArray = NewMarkdownTextNode_ItalicsArray,
    NewMarkdownTextNode_Italics = NewMarkdownTextNode_Italics,
    NewMarkdownTextNode_CodeArray = NewMarkdownTextNode_CodeArray,
    NewMarkdownTextNode_Code = NewMarkdownTextNode_Code,
    NewMarkdownTextNode_Unstyled = NewMarkdownTextNode_Unstyled,
    NewMarkdownTextNode_Raw = NewMarkdownTextNode_Raw,
    NewMarkdownText_FromUnstyled = NewMarkdownText_FromUnstyled,
    NewMarkdownText_FromNodeArray = NewMarkdownText_FromNodeArray,
    NewMarkdownText_FromNodes = NewMarkdownText_FromNodes,
    NewMarkdownText_FromRaw = NewMarkdownText_FromRaw,
    MarkdownNode_CreateSnippet = MarkdownNode_CreateSnippet,
    NewMarkdownTextNode_Link = NewMarkdownTextNode_Link,
    MarkdownNode_FumaTypeTable = MarkdownNode_FumaTypeTable,
}