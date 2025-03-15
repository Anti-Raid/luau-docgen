--!strict

local types = require("../types")
local markdown = require("../markdownir/markdown")
local convertComments = require("../convertcomments")
local tableext = require("../table")
local arg = require("./arg.luau") 
local istate = require("../istate")

--- Helper method to process a function
local function parseFunction(
    istate: istate.IState,
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
        blockNodes[#blockNodes + 1] = {
            type = "Heading" :: "Heading",
            level = nil :: number?, -- Bug in luau new type solver needs this (for now)
            headingText = markdown.NewMarkdownText_FromRaw("Generics")
        } :: markdown.MarkdownNode

        for i, generic in generics do 
            local baseNodes: {markdown.MarkdownNode} = {
                {
                    type = "Heading" :: "Heading",
                    headingText = markdown.NewMarkdownText_FromRaw(generic.name or ("generic" .. tostring(i)))
                } :: markdown.MarkdownNode
            }

            if generic.name and convertedComments.genericDocs[generic.name] then
                baseNodes[#baseNodes + 1] = {
                    type = "Text" :: "Text",
                    text = markdown.NewMarkdownText_FromRaw(convertedComments.genericDocs[generic.name])
                } :: markdown.MarkdownNode
            end

            local typ = generic.typ
            if typ then
                tableext.extend(baseNodes, parseTypeFieldType(istate, generic:string_repr(false, true), typ, typ, convertedComments))
            else
                baseNodes[#baseNodes + 1] = {
                    type = "Text" :: "Text",
                    text = markdown.NewMarkdownText_FromRaw("This generic is unconstrained and can be any type")
                } :: markdown.MarkdownNode
            end

            blockNodes[#blockNodes + 1] = {
                type = "Block" :: "Block",
                nodes = baseNodes
            }                
        end
    end

    -- Add in the arguments
    local argCount = #args

    if argCount > 0 and args[argCount].name == "self" then
        -- Remove self from the argument list
        argCount = argCount - 1
    end

    if argCount > 0 then
        --blockNodes[#blockNodes + 1]

        blockNodes[#blockNodes + 1] = {
            type = "Heading" :: "Heading",
            level = nil :: number?, -- Bug in luau new type solver needs this (for now)
            headingText = markdown.NewMarkdownText_FromRaw("Arguments")
        } :: markdown.MarkdownNode

        for i, arg in args do 
            if arg.name == "self" then
                -- Skip self argument
                continue
            end

            local baseNodes: {markdown.MarkdownNode} = {
                {
                    type = "Heading" :: "Heading",
                    headingText = markdown.NewMarkdownText_FromRaw(arg.name or ("arg" .. tostring(i)))
                } :: markdown.MarkdownNode
            }

            if arg.name and convertedComments.fieldDocs[arg.name] then
                baseNodes[#baseNodes + 1] = {
                    type = "Text" :: "Text",
                    text = markdown.NewMarkdownText_FromRaw(convertedComments.fieldDocs[arg.name])
                } :: markdown.MarkdownNode
            end

            local typ = arg.typ
            if typ then
                tableext.extend(baseNodes, parseTypeFieldType(istate, arg:string_repr(), typ, typ, convertedComments))
            else
                baseNodes[#baseNodes + 1] = {
                    type = "Text" :: "Text",
                    text = markdown.NewMarkdownText_FromRaw("No type specified!!!")
                } :: markdown.MarkdownNode
            end

            blockNodes[#blockNodes + 1] = {
                type = "Block" :: "Block",
                nodes = baseNodes
            }
        end
    end

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
                for i, ret in extractedRet.data do 
                    -- Returns have special constraints
                    local retName, retComment = arg.parseAnonymousArgData(`ret{i}`, convertedComments.returns, i)

                    local baseNodes: {markdown.MarkdownNode} = {
                        {
                            type = "Heading" :: "Heading",
                            headingText = markdown.NewMarkdownText_FromRaw(retName)
                        } :: markdown.MarkdownNode
                    }

                    if retComment ~= "" then
                        baseNodes[#baseNodes + 1] = {
                            type = "Text" :: "Text",
                            text = markdown.NewMarkdownText_FromRaw(retComment)
                        } :: markdown.MarkdownNode
                    end

                    tableext.extend(baseNodes, parseTypeFieldType(istate, ret:string_repr(), ret, ret, convertedComments))

                    blockNodes[#blockNodes + 1] = {
                        type = "Block" :: "Block",
                        nodes = baseNodes
                    }        
                end
            else
                -- Returns have special constraints
                local retName, retComment = arg.parseAnonymousArgData(`ret1`, convertedComments.returns, 1)

                local baseNodes: {markdown.MarkdownNode} = {
                    {
                        type = "Heading" :: "Heading",
                        headingText = markdown.NewMarkdownText_FromRaw(retName)
                    } :: markdown.MarkdownNode
                }

                if retComment ~= "" then
                    baseNodes[#baseNodes + 1] = {
                        type = "Text" :: "Text",
                        text = markdown.NewMarkdownText_FromRaw(retComment)
                    } :: markdown.MarkdownNode
                end

                tableext.extend(baseNodes, parseTypeFieldType(istate, ret:string_repr(), ret, ret, convertedComments))

                blockNodes[#blockNodes + 1] = {
                    type = "Block" :: "Block",
                    nodes = baseNodes
                }        
            end
        end
    end

    return blockNodes
end

--- Parses a TypeFieldType (number or () -> number etc.) in a table
function parseTypeFieldType(
    istate: istate.IState,
    originRepr: string?,
    origType: types.TypeFieldType,
    typ: types.TypeFieldType, 
    convertedComments: convertComments.ConvertCommentResponse
): {markdown.MarkdownNode} 
    local blockNodes: {markdown.MarkdownNode} = {} 

    local fieldtype = typ:extract()
    if fieldtype.type == "Function" then
        return parseFunction(
            istate,
            originRepr,
            convertedComments,
            fieldtype.data.generics,
          fieldtype.data.args,
            fieldtype.data.ret
        )
    elseif fieldtype.type == "String" or fieldtype.type == "Boolean" then                                
        -- TODO: make this look nicer
        local irNodes: {markdown.MarkdownNode} = {} 

        irNodes[#irNodes + 1] = {
            type = "CodeBlock" :: "CodeBlock",
            language = "luau",
            text = origType:string_repr()
        } :: any
        
        return irNodes
    elseif fieldtype.type == "Basic" then
        -- TODO: make this look nicer
        local irNodes: {markdown.MarkdownNode} = {} 

        irNodes[#irNodes + 1] = {
            type = "Link" :: "Link",
            url = `#{fieldtype.data}`,
            text = markdown.NewMarkdownText_FromRaw(origType:string_repr())
        } :: any
        
        return irNodes        
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
            tableext.extend(parsedFields, parseTypeField(istate, field))
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
            parseTypeFieldType(istate, originRepr, origType, fieldtype.data, convertedComments)
        ) :: {markdown.MarkdownNode}

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
            parseTypeFieldType(istate, originRepr, origType, fieldtype.data, convertedComments)
        ) :: {markdown.MarkdownNode}

        return nodes  
    elseif fieldtype.type == "Union" then
        local pnodes = tableext.arraymap(
            fieldtype.data,
            function(typ: types.TypeFieldType): {markdown.MarkdownNode}
                return parseTypeFieldType(istate, originRepr, typ, typ, convertedComments)
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
                local variantName, variantComment = arg.parseAnonymousArgData(`Variant {i}`, convertedComments.variantDocs, i)
                
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
    elseif fieldtype.type == "Generic" then 
        local nodes: {markdown.MarkdownNode} = {
            {
                type = "Text" :: "Text",
                inline = true,
                text = markdown.NewMarkdownText_FromNodes(
                    markdown.NewMarkdownTextNode_Italics(
                        markdown.NewMarkdownTextNode_Unstyled("This field is a generic type with base")
                    )
                ),
            },
            {
                type = "Text" :: "Text",
                inline = true,
                text = markdown.NewMarkdownText_FromNodes(
                    markdown.NewMarkdownTextNode_Unstyled(" ")
                ),
            },
            {
                type = "Link" :: "Link",
                url = `#{fieldtype.data.base}`,
                text = markdown.NewMarkdownText_FromRaw(fieldtype.data.base),
            }
        } :: {markdown.MarkdownNode}

        for i, generic in fieldtype.data.generics do 
            local genericNodes = parseTypeFieldType(istate, generic:string_repr(), generic, generic, convertedComments)

            if #genericNodes > 0 then
                nodes[#nodes + 1] = {
                    type = "Block" :: "Block",
                    nodes = genericNodes
                } :: markdown.MarkdownNode
            end
        end

        return nodes
    elseif fieldtype.type == "Intersection" then
        local pnodes = tableext.arraymap(
            fieldtype.data,
            function(typ: types.TypeFieldType): {markdown.MarkdownNode}
                return parseTypeFieldType(istate, originRepr, typ, typ, convertedComments)
            end
        )

        local nodes: {markdown.MarkdownNode} = {
            {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromNodes(
                    markdown.NewMarkdownTextNode_Unstyled("Intersection of:")
                )    
            }
        } :: {markdown.MarkdownNode}

        for i, pnode in pnodes do 
            if #pnode > 0 then
                local variantName, variantComment = arg.parseAnonymousArgData(`Type {i}`, convertedComments.variantDocs, i)
                
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
        } :: markdown.MarkdownNode
    end

    return blockNodes
end

--- Parses a TypeField (foo: number or foo: () -> number etc.)
function parseTypeField(istate: istate.IState, typ: types.TypeField): {markdown.MarkdownNode}
    --print(globals.prettyprint(convertComments(globals, typ.comments)))
    local convertedComments = convertComments.convertComments(istate.globals, typ.comments, istate.md.ignorenondoc);

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
        nodes = parseTypeFieldType(
            istate,
            typ:string_repr_with_pats("\n"), 
            typ.field_type, 
            typ.field_type, 
            convertedComments
        )
    }

    return blockNodes
end

return {
    parseFunction = parseFunction,
    parseTypeField = parseTypeField,
    parseTypeFieldType = parseTypeFieldType
}