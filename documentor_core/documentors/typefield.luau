--!strict

local types = require("../types")
local markdown = require("../markdownir/markdown")
local convertComments = require("../convertcomments")
local tableext = require("../table")
local arg = require("./arg") 
local istate = require("../istate")
local transformRepr = require("../transformrepr")

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
                tableext.extend(baseNodes, parseTypeFieldType(istate, transformRepr.transformTypedArgumentRepr(generic, true, false), typ, typ, convertedComments))
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
                tableext.extend(baseNodes, parseTypeFieldType(istate, transformRepr.transformTypedArgumentRepr(arg), typ, typ, convertedComments))
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

                    tableext.extend(baseNodes, parseTypeFieldType(istate, transformRepr.transformTypeFieldTypeRepr(ret), ret, ret, convertedComments))

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

                tableext.extend(baseNodes, parseTypeFieldType(istate, transformRepr.transformTypeFieldTypeRepr(ret), ret, ret, convertedComments, true))

                blockNodes[#blockNodes + 1] = {
                    type = "Block" :: "Block",
                    nodes = baseNodes
                }        
            end
        end
    end

    return blockNodes
end

local function parseFunctionInline(
    istate: istate.IState,
    convertedComments: convertComments.ConvertCommentResponse,
    generics: {types.TypedArgument},
    args: {types.TypedArgument},
    ret: types.TypeFieldType?
): {markdown.MarkdownNode}
    -- Special code for inline functions
    local parsedFields: {markdown.MarkdownNode} = {}

    -- Add in the generics
    if #generics > 0 then 
        parsedFields[#parsedFields + 1] = {
            type = "Text" :: "Text",
            text = markdown.NewMarkdownText_FromRaw("<"),
            inline = true
        } :: any
        for i, generic in generics do 
            local genericNodes: {markdown.MarkdownNode} = {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromRaw(generic.name or "generic1"),
                inline = true    
            }

            if generic.typ then 
                local typNodes = parseTypeFieldType(istate, transformRepr.transformTypedArgumentRepr(generic, true, false), generic.typ, generic.typ, convertedComments, true)

                if #typNodes > 0 then 
                    genericNodes[#genericNodes + 1] = {
                        type = "Text" :: "Text",
                        text = markdown.NewMarkdownText_FromRaw(" = "),
                        inline = true
                    } :: markdown.MarkdownNode
                end

                tableext.extend(genericNodes, typNodes)
            end

            if i < #generics then
                parsedFields[#parsedFields + 1] = {
                    type = "Text" :: "Text",
                    text = markdown.NewMarkdownText_FromRaw(", "),
                    inline = true
                } :: markdown.MarkdownNode
            end
        end

        parsedFields[#parsedFields + 1] = {
            type = "Text" :: "Text",
            text = markdown.NewMarkdownText_FromRaw(">"),
            inline = true
        } :: any
    end

    -- Add in the arguments
    parsedFields[#parsedFields + 1] = {
        type = "Text" :: "Text",
        text = markdown.NewMarkdownText_FromRaw("("),
        inline = true
    } :: any

    for i, argument in args do 
        if argument.name == "self" then
            -- Handle self in inline functions
            parsedFields[#parsedFields + 1] = {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromRaw("self"),
                inline = true
            } :: markdown.MarkdownNode

            if i < #args then
                parsedFields[#parsedFields + 1] = {
                    type = "Text" :: "Text",
                    text = markdown.NewMarkdownText_FromRaw(", "),
                    inline = true
                } :: markdown.MarkdownNode
            end

            continue
        end

        if argument.name then
            parsedFields[#parsedFields + 1] = {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromRaw(argument.name),
                inline = true    
            } :: markdown.MarkdownNode

            if argument.typ then
                parsedFields[#parsedFields + 1] = {
                    type = "Text" :: "Text",
                    text = markdown.NewMarkdownText_FromRaw(": "),
                    inline = true    
                } :: any
            end
        end

        if argument.typ then 
            local typNodes = parseTypeFieldType(istate, transformRepr.transformTypeFieldTypeRepr(argument.typ), argument.typ, argument.typ, convertedComments, true)

            tableext.extend(parsedFields, typNodes)
        end

        if i < #args then
            parsedFields[#parsedFields + 1] = {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromRaw(", "),
                inline = true
            } :: markdown.MarkdownNode
        end
    end

    parsedFields[#parsedFields + 1] = {
        type = "Text" :: "Text",
        text = markdown.NewMarkdownText_FromRaw(")"),
        inline = true
    } :: any

    if ret then
        parsedFields[#parsedFields + 1] = {
            type = "Text" :: "Text",
            text = markdown.NewMarkdownText_FromRaw(" -> "),
            inline = true
        } :: any

        local retNodes = parseTypeFieldType(istate, transformRepr.transformTypeFieldTypeRepr(ret), ret, ret, convertedComments, true)
        tableext.extend(parsedFields, retNodes)
    end

    return parsedFields
end

--- Parses a TypeFieldType (number or () -> number etc.) in a table
function parseTypeFieldType(
    istate: istate.IState,
    originRepr: string?,
    origType: types.TypeFieldType,
    typ: types.TypeFieldType, 
    convertedComments: convertComments.ConvertCommentResponse,
    inline: boolean?
): {markdown.MarkdownNode} 
    local fieldtype = typ:extract()
    if fieldtype.type == "Function" then
        if inline then 
            -- Special code for inline functions
            return parseFunctionInline(
                istate,
                convertedComments,
                fieldtype.data.generics,
                fieldtype.data.args,
                fieldtype.data.ret
            )
        end

        return parseFunction(
            istate,
            originRepr,
            convertedComments,
            fieldtype.data.generics,
            fieldtype.data.args,
            fieldtype.data.ret
        )
    elseif fieldtype.type == "String" or fieldtype.type == "Boolean" then     
        if inline then
            return {
                {
                    type = "Text" :: "Text",
                    text = markdown.NewMarkdownText_FromUnstyled(tostring(fieldtype.data)),
                    inline = true
                } :: markdown.MarkdownNode
            }
        end                           
        -- TODO: make this look nicer
        local irNodes: {markdown.MarkdownNode} = {} 

        irNodes[#irNodes + 1] = {
            type = "CodeBlock" :: "CodeBlock",
            language = "luau",
            text = transformRepr.transformTypeFieldTypeRepr(origType)
        } :: any
        
        return irNodes
    elseif fieldtype.type == "Basic" then
        -- TODO: make this look nicer
        local irNodes: {markdown.MarkdownNode} = {} 

        irNodes[#irNodes + 1] = {
            type = "Link" :: "Link",
            url = istate.plugin.resolveType(fieldtype.type, fieldtype.data),
            text = markdown.NewMarkdownText_FromRaw(transformRepr.transformTypeFieldTypeRepr(origType)),
            inline = inline
        } :: any
        
        return irNodes        
    elseif fieldtype.type == "Table" then
        if inline then 
            -- Special code for inline tables
            local parsedFields: {markdown.MarkdownNode} = {}

            for i, field in fieldtype.data do 
                tableext.extend(parsedFields, parseTypeField(istate, field, inline))
                if i < #fieldtype.data then
                    parsedFields[#parsedFields + 1] = {
                        type = "Text" :: "Text",
                        text = markdown.NewMarkdownText_FromRaw(", "),
                        inline = true
                    } :: markdown.MarkdownNode
                end
            end

            local blockNodes: {markdown.MarkdownNode} = {}
            if #parsedFields > 0 then
                blockNodes[#blockNodes + 1] = {
                    type = "Block" :: "Block",
                    nodes = parsedFields,
                    inline = true
                }
            end
            return blockNodes    
        end
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

        local blockNodes: {markdown.MarkdownNode} = {}
        if #parsedFields > 0 then
            blockNodes[#blockNodes + 1] = {
                type = "Block" :: "Block",
                nodes = parsedFields
            }
        end
        return blockNodes
    elseif fieldtype.type == "Array" then 
        if inline then 
            -- Special code for inline array types
            local parsedFields: {markdown.MarkdownNode} = {}

            tableext.extend(parsedFields, parseTypeFieldType(istate, originRepr, fieldtype.data, fieldtype.data, convertedComments, true))

            if #parsedFields > 0 then
                local blockNodes: {markdown.MarkdownNode} = {}
                blockNodes[#blockNodes + 1] = {
                    type = "Text" :: "Text",
                    text = markdown.NewMarkdownText_FromRaw("{"),
                    inline = true
                } :: markdown.MarkdownNode

                tableext.extend(blockNodes, parsedFields)

                blockNodes[#blockNodes + 1] = {
                    type = "Text" :: "Text",
                    text = markdown.NewMarkdownText_FromRaw("}"),
                    inline = true
                } :: markdown.MarkdownNode

                return blockNodes
            end

            return parsedFields
        end
        local nodes: {markdown.MarkdownNode} = parseTypeFieldType(istate, originRepr, fieldtype.data, fieldtype.data, convertedComments, true)

        if #nodes > 0 then
            local blockNodes: {markdown.MarkdownNode} = {}
            blockNodes[#blockNodes + 1] = {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromRaw("{"),
                inline = true
            } :: markdown.MarkdownNode

            tableext.extend(blockNodes, nodes)

            blockNodes[#blockNodes + 1] = {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromRaw("}"),
            } :: markdown.MarkdownNode

            return blockNodes
        end

        return nodes
    elseif fieldtype.type == "Optional" then 
        if inline then 
            -- Special code for inline optional types
            local parsedFields: {markdown.MarkdownNode} = {}

            tableext.extend(parsedFields, parseTypeFieldType(istate, originRepr, fieldtype.data, fieldtype.data, convertedComments, true))

            if #parsedFields > 0 then
                parsedFields[#parsedFields + 1] = {
                    type = "Text" :: "Text",
                    text = markdown.NewMarkdownText_FromRaw("?"),
                    inline = true
                } :: markdown.MarkdownNode
            end

            return parsedFields    
        end
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
            parseTypeFieldType(istate, originRepr, fieldtype.data, fieldtype.data, convertedComments, true)
        ) :: {markdown.MarkdownNode}

        if #nodes > 0 then
            nodes[#nodes + 1] = {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromRaw("?"),
            } :: markdown.MarkdownNode
        end

        return nodes  
    elseif fieldtype.type == "Tuple" then
        if #fieldtype.data == 0 then
            return {}
        elseif #fieldtype.data == 1 then 
            -- Special case for single element tuples
            return parseTypeFieldType(istate, originRepr, fieldtype.data[1], fieldtype.data[1], convertedComments, inline)
        end

        if inline then 
            -- Special code for inline unions separated by |
            local parsedFields: {markdown.MarkdownNode} = {}

            for i, field in fieldtype.data do 
                tableext.extend(parsedFields, parseTypeFieldType(istate, originRepr, field, field, convertedComments, true))
                if i < #fieldtype.data then
                    parsedFields[#parsedFields + 1] = {
                        type = "Text" :: "Text",
                        text = markdown.NewMarkdownText_FromRaw(", "),
                        inline = true
                    } :: markdown.MarkdownNode
                end
            end

            local blockNodes: {markdown.MarkdownNode} = {}
            if #parsedFields > 0 then
                blockNodes[#blockNodes + 1] = {
                    type = "Block" :: "Block",
                    nodes = parsedFields,
                    inline = true
                }
            end

            return blockNodes
        end

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
                    markdown.NewMarkdownTextNode_Unstyled("Tuple with values:")
                )    
            }
        } :: {markdown.MarkdownNode}

        for i, pnode in pnodes do 
            if #pnode > 0 then
                local variantName, variantComment = arg.parseAnonymousArgData(`Value {i}`, convertedComments.variantDocs, i)
                
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
                    detailsText = variantName,
                    node = pnode :: markdown.MarkdownNode,
                }
            end
        end

        return nodes :: {markdown.MarkdownNode}
    elseif fieldtype.type == "Union" then
        if inline then 
            -- Special code for inline unions separated by |
            local parsedFields: {markdown.MarkdownNode} = {}

            if #fieldtype.data > 0 then 
                -- Add parenthesis before
                parsedFields[#parsedFields + 1] = {
                    type = "Text" :: "Text",
                    text = markdown.NewMarkdownText_FromRaw("("),
                    inline = true
                } :: markdown.MarkdownNode
            end

            for i, field in fieldtype.data do 
                tableext.extend(parsedFields, parseTypeFieldType(istate, originRepr, field, field, convertedComments, true))
                if i < #fieldtype.data then
                    parsedFields[#parsedFields + 1] = {
                        type = "Text" :: "Text",
                        text = markdown.NewMarkdownText_FromRaw(" | "),
                        inline = true
                    } :: markdown.MarkdownNode
                end
            end

            if #fieldtype.data > 0 then 
                -- Add parenthesis after
                parsedFields[#parsedFields + 1] = {
                    type = "Text" :: "Text",
                    text = markdown.NewMarkdownText_FromRaw(")"),
                    inline = true
                } :: markdown.MarkdownNode
            end

            local blockNodes: {markdown.MarkdownNode} = {}
            if #parsedFields > 0 then
                blockNodes[#blockNodes + 1] = {
                    type = "Block" :: "Block",
                    nodes = parsedFields,
                    inline = true
                }
            end

            return blockNodes
        end

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
                    detailsText = variantName,
                    node = pnode :: markdown.MarkdownNode,
                }
            end
        end

        return nodes :: {markdown.MarkdownNode}
    elseif fieldtype.type == "Module" then
        local irNodes: {markdown.MarkdownNode} = {} 

        irNodes[#irNodes + 1] = {
            type = "Link" :: "Link",
            url = istate.plugin.resolveModule(fieldtype.data.module),
            text = markdown.NewMarkdownText_FromRaw(fieldtype.data.module),
            inline = true
        } :: any

        irNodes[#irNodes + 1] = {
            type = "Text" :: "Text",
            text = markdown.NewMarkdownText_FromRaw("."),
            inline = true
        } :: any

        irNodes[#irNodes + 1] = {
            type = "Link" :: "Link",
            url = istate.plugin.resolveType(fieldtype.type, fieldtype.data.base),
            text = markdown.NewMarkdownText_FromRaw(istate.plugin.resolveType(fieldtype.type, fieldtype.data.base)),
            inline = true
        } :: any

        if fieldtype.data.generics then
            local hasAddedBracket = false
            for _, generic in fieldtype.data.generics do 
                local genericNodes = parseTypeFieldType(istate, transformRepr.transformTypeFieldTypeRepr(generic), generic, generic, convertedComments, true)

                if #genericNodes > 0 then
                    if not hasAddedBracket then
                        irNodes[#irNodes + 1] = {
                            type = "Text" :: "Text",
                            text = markdown.NewMarkdownText_FromUnstyled("<"),
                            inline = true
                        } :: any
                    end
                    tableext.extend(irNodes, genericNodes)
                    if not hasAddedBracket then
                        irNodes[#irNodes + 1] = {
                            type = "Text" :: "Text",
                            text = markdown.NewMarkdownText_FromUnstyled(">"),
                            inline = true
                        } :: any
                        hasAddedBracket = true
                    end
                end
            end
        end

        if not inline then
            irNodes[#irNodes + 1] = {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromRaw(""),
            } :: any
        end

        return irNodes        
    elseif fieldtype.type == "Intersection" then
        if inline then 
            -- Special code for inline unions separated by |
            local parsedFields: {markdown.MarkdownNode} = {}

            if #fieldtype.data > 0 then 
                -- Add parenthesis before
                parsedFields[#parsedFields + 1] = {
                    type = "Text" :: "Text",
                    text = markdown.NewMarkdownText_FromRaw("("),
                    inline = true
                } :: markdown.MarkdownNode
            end

            for i, field in fieldtype.data do 
                tableext.extend(parsedFields, parseTypeFieldType(istate, originRepr, field, field, convertedComments, true))
                if i < #fieldtype.data then
                    parsedFields[#parsedFields + 1] = {
                        type = "Text" :: "Text",
                        text = markdown.NewMarkdownText_FromRaw(" & "),
                        inline = true
                    } :: markdown.MarkdownNode
                end
            end

            if #fieldtype.data > 0 then 
                -- Add parenthesis after
                parsedFields[#parsedFields + 1] = {
                    type = "Text" :: "Text",
                    text = markdown.NewMarkdownText_FromRaw(")"),
                    inline = true
                } :: markdown.MarkdownNode
            end

            local blockNodes: {markdown.MarkdownNode} = {}
            if #parsedFields > 0 then
                blockNodes[#blockNodes + 1] = {
                    type = "Block" :: "Block",
                    nodes = parsedFields,
                    inline = true
                }
            end

            return blockNodes
        end

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
                    markdown.NewMarkdownTextNode_Unstyled("Intersection with variants:")
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
                    detailsText = variantName,
                    node = pnode :: markdown.MarkdownNode,
                }
            end
        end

        return nodes :: {markdown.MarkdownNode}
    elseif fieldtype.type == "Generic" then 
        local nodes: {markdown.MarkdownNode} = {
            {
                type = "Link" :: "Link",
                url = istate.plugin.resolveType(fieldtype.type, fieldtype.data.base),
                text = markdown.NewMarkdownText_FromUnstyled(fieldtype.data.base),
                inline = true
            }
        } :: {markdown.MarkdownNode}

        if #fieldtype.data.generics > 0 then
            nodes[#nodes + 1] = {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromUnstyled("<"),
                inline = true
            } :: any
        end

        for i, generic in fieldtype.data.generics do 
            local genericNodes = parseTypeFieldType(istate, transformRepr.transformTypeFieldTypeRepr(generic), generic, generic, convertedComments, true)

            if #genericNodes > 0 then
                nodes[#nodes + 1] = {
                    type = "Block" :: "Block",
                    nodes = genericNodes,
                    inline = true
                } :: markdown.MarkdownNode
            end

            if i < #fieldtype.data.generics then
                nodes[#nodes + 1] = {
                    type = "Text" :: "Text",
                    text = markdown.NewMarkdownText_FromRaw(", "),
                    inline = true
                } :: markdown.MarkdownNode
            end
        end

        if #fieldtype.data.generics > 0 then
            nodes[#nodes + 1] = {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromUnstyled(">"),
                inline = true
            } :: any
        end

        return nodes
    elseif fieldtype.type == "GenericPack" then 
        -- T...
        return {
            {
                type = "Link" :: "Link",
                text = markdown.NewMarkdownText_FromRaw(fieldtype.data),
                url = istate.plugin.resolveType(fieldtype.type, fieldtype.data),
                inline = inline
            } :: markdown.MarkdownNode,
            {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromRaw("..."),
                inline = inline
            } :: markdown.MarkdownNode
        } 
    elseif fieldtype.type == "TypeOf" then 
        return {
            {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromRaw("typeof("),
                inline = inline
            } :: markdown.MarkdownNode,
            {
                type = "Link" :: "Link",
                text = markdown.NewMarkdownText_FromRaw(fieldtype.data),
                url = istate.plugin.resolveType(fieldtype.type, fieldtype.data),
                inline = inline
            } :: markdown.MarkdownNode,
            {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromRaw(")"),
                inline = inline
            } :: markdown.MarkdownNode
        } 
    elseif fieldtype.type == "UnknownModule" then
        return {
            {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromRaw(fieldtype.data),
                inline = inline
            } :: markdown.MarkdownNode
        }
    elseif fieldtype.type == "Variadic" then
        -- TODO: maybe rethink the inlining here later?
        local nodes: {markdown.MarkdownNode} = {
            {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromRaw("..."),
                inline = inline
            } :: markdown.MarkdownNode
        }
        
        -- Add the nodes in inline format here
        tableext.extend(nodes, parseTypeFieldType(istate, originRepr, fieldtype.data, fieldtype.data, convertedComments, true))

        if not inline then
            nodes[#nodes + 1] = {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromRaw(""),
                inline = inline
            } :: markdown.MarkdownNode
        end

        return nodes
    elseif fieldtype.type == "VariadicPack" then
        return {
            {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromRaw("..."),
                inline = inline
            } :: markdown.MarkdownNode,
            {
                type = "Link" :: "Link",
                text = markdown.NewMarkdownText_FromRaw(fieldtype.data),
                url = istate.plugin.resolveType(fieldtype.type, fieldtype.data),
                inline = inline
            } :: markdown.MarkdownNode
        }
    else
        -- Fallback
        local blockNodes: {markdown.MarkdownNode} = {}
        blockNodes[#blockNodes + 1] = {
            type = "Text" :: "Text",
            text = markdown.NewMarkdownText_FromUnstyled("[Documentor] Unsupported type: " .. fieldtype.type)
        } :: markdown.MarkdownNode
    end

    error("unsupported type [this error should not be reachable]: " .. fieldtype.type)
end

--- Parses a TypeField (foo: number or foo: () -> number etc.)
function parseTypeField(istate: istate.IState, typ: types.TypeField, inline: boolean?): {markdown.MarkdownNode}    
    --print(pp(convertComments(globals, typ.comments)))
    local convertedComments = convertComments.convertComments(istate.globals, typ.comments, istate.md.ignorenondoc);

    local blockNodes: {markdown.MarkdownNode} = {}
    if convertedComments.skip then
        return blockNodes -- Ignore explicitly skipped type fields
    end

    if inline then 
        return parseTypeFieldType(
            istate,
            transformRepr.transformTypeFieldReprWithPat(typ, nil, "\n"),
            typ.field_type, 
            typ.field_type, 
            convertedComments,
            true
        )
    end

    local fieldName = transformRepr.transformTypeFieldKey(typ.field_name)

    -- Add header node
    blockNodes[#blockNodes + 1] = {
        type = "Heading" :: "Heading",
        level = nil :: number?, -- Bug in luau new type solver needs this (for now)
        headingText = markdown.NewMarkdownText_FromRaw(fieldName)    
    }

    if #convertedComments.output > 0 then
        -- Add converted comments output as well
        blockNodes = tableext.extend(blockNodes, convertedComments.output)
    end    

    blockNodes[#blockNodes + 1] = {
        type = "Block" :: "Block",
        nodes = parseTypeFieldType(
            istate,
            transformRepr.transformTypeFieldReprWithPat(typ, nil, "\n"),
            typ.field_type, 
            typ.field_type, 
            convertedComments,
            if convertedComments.inlineFields[fieldName] then true else false
        )
    }

    return blockNodes
end

return {
    parseFunction = parseFunction,
    parseTypeField = parseTypeField,
    parseTypeFieldType = parseTypeFieldType
}