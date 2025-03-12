--!strict
local types = require("types.luau")

type ConvertCommentResponse = {
    output: string,
    skip: boolean,
    fieldDocs: {[string]: string} -- Useful to document functions etc
}

-- Modify this function to change how special comments are converted to markdown
local specialcommentmap = {
    warning = function(output: ConvertCommentResponse, data: string)
        output.output ..= "<div class=\"warning\">\n" .. data .. "\n</div>"
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
}

--- Converts comments to markdown (with other metadata attached to it)
local function convertComments(globals: types.Globals, typecomments: {string}, ignorenondoc: boolean?): ConvertCommentResponse 
    local comments = globals.parsecomments(typecomments, ignorenondoc)

    local output: ConvertCommentResponse = {
        output = "",
        skip = false,
        fieldDocs = {},
    }

    for i, comment in comments.comments do 
        local addNl = false
        if comment.comment_type == "Normal" then
            output.output ..= comment.data 
            addNl = true
        elseif comment.comment_type == "Special" then
            local data = comment.data
            local typ = comment.typ
            if specialcommentmap[typ] then
                specialcommentmap[typ](output, data)
                addNl = false
            else
                output.output ..= "@" .. typ .. " " .. data -- Readd the comment if no special comment handler is found
                addNl = true
            end
        end

        if addNl and i ~= #comments.comments then
            output.output ..= "\n"
        end    
    end

    return output
end

return convertComments