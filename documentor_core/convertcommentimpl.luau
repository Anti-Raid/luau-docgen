--!strict 

export type InnerComment = {
    comment_type: "Special",
    --- The type of the special comment
    typ: string,
    --- The data of the special comment
    data: string,
} | {
    comment_type: "Normal",
    --- The data of the normal comment
    data: string,
}

--- Contains a parsed list of comments from globals.parsecomments
export type Comment = {
    --- List of comments (in order of appearance)
    comments: {InnerComment},
}
 
-- Define InnerComment enum equivalent as a table with functions to create variants
local InnerComment = {}
InnerComment.__index = InnerComment

function InnerComment.Normal(data): InnerComment
    return { comment_type = "Normal" :: "Normal", data = data }
end

function InnerComment.Special(typ, data): InnerComment
    return { comment_type = "Special" :: "Special", typ = typ, data = data }
end

-- Contains a parsed list of comments
local Comment = {}
Comment.__index = Comment

function Comment.new(comments): Comment
    local self = setmetatable({}, Comment)
    self.comments = comments
    return self
end

-- Parses a list of comments into a Comment structure
function parsecomments(comments: {string}, ignore_nondoc: boolean?): Comment
    local i_comments = {}  -- This table is equivalent to Vec<InnerComment>
    local i = 1         -- Lua arrays are 1-indexed

    while i <= #comments do
        local comment = comments[i]
        if ignore_nondoc and not comment:find("^%-") then
            i = i + 1 :: any
        else
            comment = comment:gsub("^%-", ""):match("^%s*(.-)%s*$") :: string
            -- Single line comment
            if comment:find("^@") then
                local first_space = comment:find(" ")
                if first_space then
                    local part1 = comment:sub(1, first_space - 1)
                    local part2 = comment:sub(first_space + 1)
                    table.insert(i_comments, InnerComment.Special(part1:sub(2), part2))
                else
                    table.insert(i_comments, InnerComment.Special(comment:sub(2), ""))
                end
            -- Multiline block comment
            elseif comment:find("^#") then
                local stripped = comment:sub(2)  -- remove '#' character
                local block_comment = stripped:match("^%s*(.-)%s*$")
                local data_set = {}
                i = i + 1  -- Go to the next line
                while i <= #comments do
                    local next_comment = comments[i]
                    if ignore_nondoc and not next_comment:find("^%-") then
                        i = i + 1
                    else
                        local processed = next_comment:gsub("^%-", ""):gsub("\\%s*$", "")
                        table.insert(data_set, processed)
                        if not next_comment:find("\\%s*$") then
                            break
                        end
                        i = i + 1
                    end
                end
                local data = table.concat(data_set, "\n")
                table.insert(i_comments, InnerComment.Special(block_comment or "", data))
            -- Normal comment
            else
                table.insert(i_comments, InnerComment.Normal(comment))
            end
            i = i + 1
        end
    end

    return Comment.new(i_comments)
end

-- Deep equality check for tables
function deepEqual(t1: any, t2: any)
    if type(t1) ~= type(t2) then
        return false
    end
    if type(t1) ~= "table" then
        return t1 == t2
    end
    for k, v in pairs(t1 :: any) do
        if type(v) == "table" and type(t2[k]) == "table" then
            if not deepEqual(v, t2[k] :: any) then
                return false
            end
        else
            if v ~= t2[k] then
                return false
            end
        end
    end
    for k, v in pairs(t2) do
        if (t1 :: {[string]: string?})[k] == nil then
            return false
        end
    end
    return true
end

--[[
Tests Module
]]
local tests = {}

function tests.test_parse_comments_basic()
    --local pp = require("./pp")
    local comments = {
        "@my_special_comment",
        "@my_special_comment my comment",
        "@my_special_comment my comment1 my comment2",
        "normal comment",
        "# my_special_comment",
        "This is a block comment \\",
        "with two lines",
        "and a normal comment again!",
        "# warning",
        "Too awesome!",
        "Too cool!",
        "# error",
        "Beep boop!",
    }
    local parsed = parsecomments(comments, false)
    --print(pp(parsed))
    --print(pp("\n"))
    assert(#parsed.comments == 9, "Expected 9 comments, got " .. tostring(#parsed.comments))
    assert(deepEqual(parsed.comments[1], InnerComment.Special("my_special_comment", "")), "Test 1 failed")
    assert(deepEqual(parsed.comments[2], InnerComment.Special("my_special_comment", "my comment")), "Test 2 failed")
    assert(deepEqual(parsed.comments[3], InnerComment.Special("my_special_comment", "my comment1 my comment2")), "Test 3 failed")
    assert(deepEqual(parsed.comments[4], InnerComment.Normal("normal comment")), "Test 4 failed")
    assert(deepEqual(parsed.comments[5], InnerComment.Special("my_special_comment", "This is a block comment \nwith two lines")), "Test 5 failed")
    assert(deepEqual(parsed.comments[6], InnerComment.Normal("and a normal comment again!")), "Test 6 failed")
    assert(deepEqual(parsed.comments[7], InnerComment.Special("warning", "Too awesome!")), "Test 7 failed")
    assert(deepEqual(parsed.comments[8], InnerComment.Normal("Too cool!")), "Test 8 failed")
    assert(deepEqual(parsed.comments[9], InnerComment.Special("error", "Beep boop!")), "Test 9 failed")
end

-- Run tests if executed as the main module
tests.test_parse_comments_basic()
--print("All tests passed!")

return {
    parsecomments = parsecomments,
    InnerComment = InnerComment,
    Comment = Comment,
}