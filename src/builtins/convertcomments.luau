--!strict
local types = require("types.luau")
local markdown = require("markdown.luau")

export type ConvertCommentResponse = {
    output: {markdown.MarkdownNode},
    skip: boolean,
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
}

--- Converts comments to markdown (with other metadata attached to it)
local function convertComments(globals: types.Globals, typecomments: {string}, ignorenondoc: boolean?): ConvertCommentResponse 
    local comments = globals.parsecomments(typecomments, ignorenondoc)

    local output: ConvertCommentResponse = {
        output = {},
        skip = false,
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
            }
        elseif comment.comment_type == "Special" then
            local data = comment.data
            local typ = comment.typ
            if specialcommentmap[typ] then
                specialcommentmap[typ](output, data)
            else
                output.output[#output.output + 1] = {
                    type = "Text" :: "Text",
                    text = markdown.NewMarkdownText_FromRaw("@" .. typ .. " " .. data) -- Default to just outputting the comment
                }
            end
        end
    end

    return output
end

return {
    convertComments = convertComments,
}