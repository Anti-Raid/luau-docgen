--!strict

local types = require("../types")
local markdown = require("../markdownir/markdown")
local functionDocumentor = require("./function")
local convertComments = require("../convertcomments")
local tableext = require("../table")
local argparser = require("../argparser")
local simplefieldDocumentor = require("./simplefield")
local args = require("./arg.luau") 

--- Parses a TypeFieldType (number or () -> number etc.)
local function parseTypeFieldType(
    globals: types.Globals, 
    md: argparser.ParsedArgumentResult,
    originField: types.TypeField?, 
    origType: types.TypeFieldType,
    typ: types.TypeFieldType, 
    convertedComments: convertComments.ConvertCommentResponse
): {markdown.MarkdownNode} 
    local blockNodes: {markdown.MarkdownNode} = {} 

    local fieldtype = typ:extract()
    if fieldtype.type == "Function" then
        local originRepr: string? = nil
        if originField then
            originRepr = originField:string_repr_with_pats("\n")
        end
        return functionDocumentor.parseFunction(
            originRepr,
            convertedComments,
            fieldtype.data.generics,
            fieldtype.data.args,
            fieldtype.data.ret
        )
    elseif fieldtype.type == "Basic" or fieldtype.type == "String" or fieldtype.type == "Boolean"  then
        local originRepr: string? = nil
        if originField then
            originRepr = originField:string_repr_with_pats("\n")
        end
        return simplefieldDocumentor.parseSimpleField(originRepr, fieldtype.type, tostring(fieldtype.data), convertedComments)
    elseif fieldtype.type == "Table" then
        local parsedFields: {markdown.MarkdownNode} = {
            {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromNodes(
                    markdown.NewMarkdownTextNode_Italics(
                        markdown.NewMarkdownTextNode_Unstyled("This is an inline table type with the following fields")
                    )
                )
            } :: markdown.MarkdownNode
        }
        for _, field in fieldtype.data do 
            tableext.extend(parsedFields, parseTypeField(globals, md, field))
        end
        if #parsedFields > 0 then
            blockNodes[#blockNodes + 1] = {
                type = "Block" :: "Block",
                nodes = parsedFields
            }
        end
        return blockNodes
    elseif fieldtype.type == "Array" then 
        local nodes: {markdown.MarkdownNode} = tableext.extend(
            {
                {
                    type = "Text" :: "Text",
                    text = markdown.NewMarkdownText_FromNodes(
                        markdown.NewMarkdownTextNode_Italics(
                            markdown.NewMarkdownTextNode_Unstyled("This field is an array type")
                        )
                    )
                },
            },
            parseTypeFieldType(globals, md, originField, origType, fieldtype.data, convertedComments)
        )

        return nodes
    elseif fieldtype.type == "Optional" then 
        local nodes: {markdown.MarkdownNode} = tableext.extend(
            {
                {
                    type = "Text" :: "Text",
                    text = markdown.NewMarkdownText_FromNodes(
                        markdown.NewMarkdownTextNode_Italics(
                            markdown.NewMarkdownTextNode_Unstyled("This field is optional and may not be specified")
                        )
                    )
                },
            },
            parseTypeFieldType(globals, md, originField, origType, fieldtype.data, convertedComments)
        )

        return nodes  
    elseif fieldtype.type == "Union" then
        local pnodes = tableext.arraymap(
            fieldtype.data,
            function(typ: types.TypeFieldType): {markdown.MarkdownNode}
                return parseTypeFieldType(globals, md, originField, origType, typ, convertedComments)
            end
        )

        local nodes: {markdown.MarkdownNode} = {
            {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromNodes(
                    markdown.NewMarkdownTextNode_Unstyled("Union with variants:")
                )    
            }
        } :: {markdown.MarkdownNode}

        for i, pnode in pnodes do 
            if #pnode > 0 then
                local variantName, variantComment = args.parseAnonymousArgData(`Variant ${i}`, convertedComments.variantDocs, i)
                
                if variantComment ~= "" then 
                    pnode = {
                        type = "InlineBlock" :: "InlineBlock",
                        nodes = tableext.extend(
                            {
                                {
                                    type = "Text" :: "Text",
                                    text = markdown.NewMarkdownTextNode_Raw(variantComment)
                                }
                            },
                            pnode
                        ),
                    }
                else 
                    pnode = {
                        type = "InlineBlock" :: "InlineBlock",
                        nodes = pnode,
                    }
                end
                
                nodes[#nodes + 1] = {
                    type = "Snippet",
                    detailsText = variantName,-- fieldtype.data[i]:string_repr(),
                    node = pnode :: markdown.MarkdownNode,
                }
            end
        end

        return nodes :: {markdown.MarkdownNode}
    else
        -- Fallback
        blockNodes[#blockNodes + 1] = {
            type = "Text" :: "Text",
            text = markdown.NewMarkdownText_FromRaw("[Documentor] Unsupported type: " .. fieldtype.type)
        }
    end

    return blockNodes
end

--- Parses a TypeField (foo: number or foo: () -> number etc.)
function parseTypeField(globals: types.Globals, md: argparser.ParsedArgumentResult, typ: types.TypeField): {markdown.MarkdownNode}
    --print(globals.prettyprint(convertComments(globals, typ.comments)))
    local convertedComments = convertComments.convertComments(globals, typ.comments, md.ignorenondoc);

    local blockNodes: {markdown.MarkdownNode} = {}
    if convertedComments.skip then
        return blockNodes -- Ignore explicitly skipped type fields
    end

    -- Add header node
    blockNodes[#blockNodes + 1] = {
        type = "Heading" :: "Heading",
        level = nil :: number?, -- Bug in luau new type solver needs this (for now)
        headingText = markdown.NewMarkdownText_FromRaw(typ.field_name)    
    }

    if #convertedComments.output > 0 then
        -- Add converted comments output as well
        blockNodes = tableext.extend(blockNodes, convertedComments.output)
    end    

    blockNodes[#blockNodes + 1] = {
        type = "Block" :: "Block",
        nodes = parseTypeFieldType(globals, md, typ, typ.field_type, typ.field_type, convertedComments)
    }

    return blockNodes
end

return {
    parseTypeField = parseTypeField,
    parseTypeFieldType = parseTypeFieldType
}