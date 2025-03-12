--!strict

export type MarkdownTextNode = {
    text: string,
    style: "Raw"
} | {
    node: {MarkdownTextNode},
    style: "Bold"
} | {
    node: {MarkdownTextNode},
    style: "Italics"
} | {
    text: string,
    style: "Unstyled"
}

local function NewMarkdownTextNode_BoldArray(nodes: {MarkdownTextNode}): MarkdownTextNode
    return {
        node = nodes,
        style = "Bold"
    }
end

local function NewMarkdownTextNode_Bold(...: MarkdownTextNode): MarkdownTextNode
    return {
        node = {...},
        style = "Bold"
    }
end

local function NewMarkdownTextNode_ItalicsArray(nodes: {MarkdownTextNode}): MarkdownTextNode
    return {
        node = nodes,
        style = "Italics"
    }
end

local function NewMarkdownTextNode_Italics(...: MarkdownTextNode): MarkdownTextNode
    return {
        node = {...},
        style = "Italics"
    }
end

local function NewMarkdownTextNode_Unstyled(node: string): MarkdownTextNode
    return {
        text = node,
        style = "Unstyled"
    }
end

local function NewMarkdownTextNode_Raw(node: string): MarkdownTextNode
    return {
        text = node,
        style = "Raw"
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
    description: string,
} | {
    type: "Block",
    nodes: {MarkdownNode}
} | {
    type: "Warning",
    text: MarkdownText,
} | {
    type: "Text",
    text: MarkdownText,
} | {
    type: "Link",
    text: MarkdownText, 
    url: string
} | {
    type: "Table",
    headers: {MarkdownText},
    --- A set of rows, each row is a set of strings mapping to the table headers
    rowset: {{MarkdownText}}, 
} | {
    type: "List",
    entries: {MarkdownText}
}

--- To allow for more seamless markdown handling, a second 'markdown IR (intermediate representation)' is constructed which is then
--- converted to the final markdown
return {
    NewMarkdownTextNode_BoldArray = NewMarkdownTextNode_BoldArray,
    NewMarkdownTextNode_Bold = NewMarkdownTextNode_Bold,
    NewMarkdownTextNode_ItalicsArray = NewMarkdownTextNode_ItalicsArray,
    NewMarkdownTextNode_Italics = NewMarkdownTextNode_Italics,
    NewMarkdownTextNode_Unstyled = NewMarkdownTextNode_Unstyled,
    NewMarkdownTextNode_Raw = NewMarkdownTextNode_Raw,
    NewMarkdownText_FromNodeArray = NewMarkdownText_FromNodeArray,
    NewMarkdownText_FromNodes = NewMarkdownText_FromNodes,
    NewMarkdownText_FromRaw = NewMarkdownText_FromRaw,
}