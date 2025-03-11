--!strict

--- Returns a string that is a markdown seperator (for newlines).
local function nlseperate(): string
    return "\n\n"
end

--- Returns a section separator
local function sectionSeparator(): string
    return "---"
end

--- Returns a string that is a markdown heading with the given depth and text.
local function createHeading(depth: number, text: string): string
    return string.rep("#", depth) .. " " .. text
end

--- Returns a string that is a markdown code block with the given language and text (and description).
local function createCodeBlock(language: string, text: string, description: string?): string
    local codeblock = "```" .. language .. "\n" .. text .. "\n```"

    -- For formatting, make it a details block for formatting purposes
    codeblock = "<details>\n<summary>" .. (description or "Code Block") .. "</summary>" .. nlseperate() .. codeblock .. nlseperate() .. "</details>"

    return codeblock
end

--- Returns bolded text.
local function bold(text: string): string
    return "**" .. text .. "**"
end

--- Returns italicized text.
local function italic(text: string): string
    return "*" .. text .. "*"
end

--- Returns a link.
local function link(text: string, url: string): string
    return "[" .. text .. "](" .. url .. ")"
end


export type Table = {
    headers: {string},
    rowset: {{string}}, -- A set of rows, each row is a set of strings mapping to the table headers
}

local function createTable(table: Table): string
    local function parseCell(cell: string): string
        return cell:gsub("\n", "<br>") :: string
    end

    local output = "|"

    for _, header in ipairs(table.headers) do
        output ..= header .. "|"
    end

    output ..= "\n|"

    for _ = 1, #table.headers do
        output ..= "---|"
    end

    output ..= "\n"

    for i, row in ipairs(table.rowset) do
        output ..= "|"

        for _, cell in ipairs(row) do
            output ..= parseCell(cell) .. "|"
        end

        if i ~= #table.rowset then
            output ..= "\n"
        end
    end

    return output
end

--- Returns a list
local function createList(items: {string}): string
    local output = ""

    for i, item in ipairs(items) do
        if i == #items then
            output ..= "- " .. item
        else
            output ..= "- " .. item .. "\n"
        end
    end

    return output
end

--- Returns a single line codeblock
local function createSingleLineCodeBlock(text: string): string
    return "``" .. text .. "``"
end

return {
    createHeading = createHeading,
    createCodeBlock = createCodeBlock,
    bold = bold,
    italic = italic,
    link = link,
    createTable = createTable,
    createList = createList,
    nlseperate = nlseperate,
    sectionSeparator = sectionSeparator,
    createSingleLineCodeBlock = createSingleLineCodeBlock,
}