--!strict

local markdown = require("../markdownir/markdown.luau")
local convertComments = require("../convertcomments.luau")
local types = require("../types.luau")
local args = require("./arg.luau") 

--- Helper function to parse return data from converted comments
local function parseReturnData(convertedComments: convertComments.ConvertCommentResponse, i: number): (string, string)
    return args.parseAnonymousArgData(`ret{i}`, convertedComments.returns, i)
end

--- Helper method to process a function
local function parseFunction(
    originRepr: string?,
    convertedComments: convertComments.ConvertCommentResponse,
    generics: {types.TypedArgument},
    args: {types.TypedArgument},
    ret: types.TypeFieldType?
): {markdown.MarkdownNode} 
    local blockNodes: {markdown.MarkdownNode} = {}
    
    -- Code block of the function as a string
    if originRepr then
        blockNodes[#blockNodes + 1] = markdown.MarkdownNode_CreateSnippet("Function Signature", {
            type = "CodeBlock",
            language = "luau",
            text = originRepr,
        })
    end

    -- Add in the generics
    if #generics > 0 then 
        local genericlist: {markdown.MarkdownText} = {}
        for i, generic in generics do 
            local stringRepr = "any"
            if generic.typ then
                stringRepr = generic.typ:string_repr():gsub("<", "&lt;"):gsub(">", "&gt;")
            end

            -- Add in the argument properly
            local nodes: {markdown.MarkdownTextNode} = {
                markdown.NewMarkdownTextNode_Bold(
                    markdown.NewMarkdownTextNode_Unstyled(generic.name or ("generic" .. tostring(i)))
                ),
                markdown.NewMarkdownTextNode_Unstyled(" "),
                markdown.NewMarkdownTextNode_Italics(
                    markdown.NewMarkdownTextNode_Unstyled("(" .. stringRepr .. ")")
                )
            } :: {markdown.MarkdownTextNode}

            if generic.name and convertedComments.genericDocs[generic.name] then
                nodes[#nodes + 1] = markdown.NewMarkdownTextNode_Unstyled(" - " .. convertedComments.genericDocs[generic.name])
            end

            genericlist[#genericlist + 1] = markdown.NewMarkdownText_FromNodeArray(
                nodes
            )
        end

        blockNodes[#blockNodes + 1] = {
            type = "Heading" :: "Heading",
            level = nil :: number?, -- Bug in luau new type solver needs this (for now)
            headingText = markdown.NewMarkdownText_FromRaw("Generics")
        } :: markdown.MarkdownNode

        blockNodes[#blockNodes + 1] = {
            type = "List" :: "List",
            entries = genericlist
        }
    end

    -- Add in the arguments
    if #args > 0 then
        --blockNodes[#blockNodes + 1]

        local arglist: {markdown.MarkdownText} = {}
        for i, arg in args do 
            if arg.name == "self" then
                -- Skip self argument
                continue
            end

            local stringRepr = "any"
            if arg.typ then
                stringRepr = arg.typ:string_repr():gsub("<", "&lt;"):gsub(">", "&gt;")
            end

            -- Add in the argument properly
            local nodes: {markdown.MarkdownTextNode} = {
                markdown.NewMarkdownTextNode_Bold(
                    markdown.NewMarkdownTextNode_Unstyled(arg.name or ("arg" .. tostring(i)))
                ),
                markdown.NewMarkdownTextNode_Unstyled(" "),
                markdown.NewMarkdownTextNode_Italics(
                    markdown.NewMarkdownTextNode_Unstyled("(" .. stringRepr .. ")")
                )
            } :: {markdown.MarkdownTextNode}

            if arg.name and convertedComments.fieldDocs[arg.name] then
                nodes[#nodes + 1] = markdown.NewMarkdownTextNode_Unstyled(" - " .. convertedComments.fieldDocs[arg.name])
            end

            arglist[#arglist + 1] = markdown.NewMarkdownText_FromNodeArray(
                nodes
            )
        end

        blockNodes[#blockNodes + 1] = {
            type = "Heading" :: "Heading",
            level = nil :: number?, -- Bug in luau new type solver needs this (for now)
            headingText = markdown.NewMarkdownText_FromRaw("Arguments")
        } :: markdown.MarkdownNode

        blockNodes[#blockNodes + 1] = {
            type = "List" :: "List",
            entries = arglist
        }

        if ret then
            local extractedRet = ret:extract()
            if extractedRet.type ~= "Tuple" or #extractedRet.data > 0 then 
                blockNodes[#blockNodes + 1] = {
                    type = "Heading" :: "Heading",
                    level = nil :: number?, -- Bug in luau new type solver needs this (for now)
                    headingText = markdown.NewMarkdownText_FromRaw("Returns")
                } :: markdown.MarkdownNode

                if extractedRet.type == "Tuple" then 
                    -- Special case for tuples
                    local retlist: {markdown.MarkdownText} = {}

                    for i, ret in extractedRet.data do 
                        local stringRepr = "any"
                        if ret then
                            stringRepr = ret:string_repr():gsub("<", "&lt;"):gsub(">", "&gt;")
                        end

                        -- Returns have special constraints
                        local retName, retComment = parseReturnData(convertedComments, i)

                        local nodes: {markdown.MarkdownTextNode} = {
                            markdown.NewMarkdownTextNode_Bold(
                                markdown.NewMarkdownTextNode_Unstyled(retName)
                            ),
                            markdown.NewMarkdownTextNode_Unstyled(" "),
                            markdown.NewMarkdownTextNode_Italics(
                                markdown.NewMarkdownTextNode_Unstyled("(" .. stringRepr .. ")")
                            )
                        } :: {markdown.MarkdownTextNode}
        
                        if retComment ~= "" then
                            nodes[#nodes + 1] = markdown.NewMarkdownTextNode_Unstyled(" - " .. retComment)
                        end
        
                        retlist[#retlist + 1] = markdown.NewMarkdownText_FromNodeArray(
                            nodes
                        )        
                    end

                    blockNodes[#blockNodes + 1] = {
                        type = "List" :: "List",
                        entries = retlist
                    }
                else
                    -- Normal case
                    local stringRepr = "any"
                    if ret then
                        stringRepr = ret:string_repr():gsub("<", "&lt;"):gsub(">", "&gt;")
                    end

                    -- Returns have special constraints
                    local retName, retComment = parseReturnData(convertedComments, 1)

                    local nodes: {markdown.MarkdownTextNode} = {
                        markdown.NewMarkdownTextNode_Bold(
                            markdown.NewMarkdownTextNode_Unstyled(retName)
                        ),
                        markdown.NewMarkdownTextNode_Unstyled(" "),
                        markdown.NewMarkdownTextNode_Italics(
                            markdown.NewMarkdownTextNode_Unstyled("(" .. stringRepr .. ")")
                        )
                    } :: {markdown.MarkdownTextNode}

                    if retComment ~= "" then
                        nodes[#nodes + 1] = markdown.NewMarkdownTextNode_Unstyled(" - " .. retComment)
                    end

                    blockNodes[#blockNodes + 1] = {
                        type = "List" :: "List",
                        entries = {
                            markdown.NewMarkdownText_FromNodeArray(
                                nodes
                            )
                        }
                    } :: markdown.MarkdownNode
                end
            end
        end
    end

    return blockNodes
end

return {
    parseFunction = parseFunction,
    parseReturnData = parseReturnData,
}