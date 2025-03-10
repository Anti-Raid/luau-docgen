--!strict
local types = require("types.luau")

type ConvertCommentResponse = {
    output: string,
    skip: boolean
}

-- Modify this function to change how special comments are converted to markdown
local specialcommentmap = {
    warning = function(output: ConvertCommentResponse, data: string)
        output.output ..= "<div class=\"warning\">\n" .. data .. "\n</div>\n"
    end,
    skip = function(output: ConvertCommentResponse, data: string)
        output.skip = true
    end,
}

--- Converts comments to markdown (with other metadata attached to it)
local function convertComments(globals: types.Globals, typecomments: {string}): ConvertCommentResponse 
    local comments = globals.parsecomments(typecomments, true)

    local output: ConvertCommentResponse = {
        output = "",
        skip = false,
    }

    for _, comment in comments.comments do 
        if comment.comment_type == "Normal" then
            output.output ..= comment.data .. "\n"
        elseif comment.comment_type == "Special" then
            local data = comment.data
            local typ = comment.typ
            if specialcommentmap[typ] then
                specialcommentmap[typ](output, data)
            else
                output.output ..= "@" .. typ .. " " .. data .. "\n" -- Readd the comment if no special comment handler is found
            end
        end
    end

    return output
end

return convertComments