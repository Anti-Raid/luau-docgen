--!strict
local types = require("./types")
local convertcommentimpl = require("./convertcommentimpl")
local markdown = require("./markdownir/markdown")

export type ConvertCommentResponse = {
    output: {markdown.MarkdownNode},
    skip: boolean,
    variantDocs: {[string]: string}, -- Useful for documenting multivariant unions
    inlineFields: {[string]: boolean}, -- Useful for making specific fields inline
    fieldDocs: {[string]: string}, -- Useful to document functions etc
    genericDocs: {[string]: string}, -- Useful to document functions etc
    returns: {[string]: string}, -- Useful to document functions etc
}
 
-- Modify this function to change how special comments are converted to markdown
local specialcommentmap = {
    warning = function(output: ConvertCommentResponse, data: string)
        output.output[#output.output + 1] = {
            type = "Warning" :: "Warning",
            text = markdown.NewMarkdownText_FromRaw(data)
        }
    end,
    skip = function(output: ConvertCommentResponse, data: string)
        output.skip = true
    end,
    param = function(output: ConvertCommentResponse, data: string) -- Alias for field
        -- Split data by space
        local split = data:split(" ")
        if #split < 2 then
            return
        end

        local fieldName = split[1]
        local fieldData = table.concat(split, " ", 2)

        output.fieldDocs[fieldName] = fieldData
    end,
    field = function(output: ConvertCommentResponse, data: string)
        -- Split data by space
        local split = data:split(" ")
        if #split < 2 then
            return
        end

        local fieldName = split[1]
        local fieldData = table.concat(split, " ", 2)

        output.fieldDocs[fieldName] = fieldData
    end,
    returns = function(output: ConvertCommentResponse, data: string)
        -- Split data by space
        local split = data:split(" ")
        if #split < 2 then
            return
        end

        local fieldName = split[1]
        local fieldData = table.concat(split, " ", 2)

        output.returns[fieldName] = fieldData
    end,
    generic = function(output: ConvertCommentResponse, data: string)
        -- Split data by space
        local split = data:split(" ")
        if #split < 2 then
            return
        end

        local fieldName = split[1]
        local fieldData = table.concat(split, " ", 2)

        output.genericDocs[fieldName] = fieldData
    end,
    variant = function(output: ConvertCommentResponse, data: string)
        -- Split data by space
        local split = data:split(" ")
        if #split < 2 then
            return
        end

        local fieldName = split[1]
        local fieldData = table.concat(split, " ", 2)

        output.genericDocs[fieldName] = fieldData
    end,
    inline = function(output: ConvertCommentResponse, data: string)
        -- Split data by space
        local split = data:split(" ") :: {string?}

        local fieldName = split[1]

        if not fieldName then
            return
        end

        output.inlineFields[fieldName] = split[2] == nil or split[2] == "true"
    end,
}

--- Converts comments to markdown (with other metadata attached to it)
local function convertComments(globals: types.Globals, typecomments: {string}, ignorenondoc: boolean?): ConvertCommentResponse 
    local comments = convertcommentimpl.parsecomments(typecomments, ignorenondoc)

    local output: ConvertCommentResponse = {
        output = {},
        skip = false,
        variantDocs = {},
        inlineFields = {},
        fieldDocs = {},
        genericDocs = {},
        returns = {},
    }

    for i, comment in comments.comments do 
        if comment.comment_type == "Normal" then
            if comment.data == "!strict" then continue end
            output.output[#output.output + 1] = {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromRaw(comment.data)
            } :: markdown.MarkdownNode
        elseif comment.comment_type == "Special" then
            local data = comment.data
            local typ = comment.typ
            if specialcommentmap[typ] then
                specialcommentmap[typ](output, data)
            else
                output.output[#output.output + 1] = {
                    type = "Text" :: "Text",
                    text = markdown.NewMarkdownText_FromRaw("@" .. typ .. " " .. data) -- Default to just outputting the comment
                } :: markdown.MarkdownNode
            end
        end
    end

    return output
end

return {
    convertComments = convertComments,
}