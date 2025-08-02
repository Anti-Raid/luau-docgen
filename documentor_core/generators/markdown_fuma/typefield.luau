--!strict

local types = require("../../types")
local markdown = require("./markdownir/markdown")
local convertComments = require("./convertcomments")
local tableext = require("../../table")
local parseAnonymousArgData = require("../../parseanonymousargdata").parseAnonymousArgData
local istate = require("./istate")
local transformRepr = require("../../transformrepr")

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
            type = "CodeBlock" :: "CodeBlock",
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
                    headingText = markdown.NewMarkdownText_FromUnstyled(generic.name or ("generic" .. tostring(i)))
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
                tableext.extend(baseNodes, parseTypeFieldType({
                    istate = istate, 
                    originRepr = transformRepr.transformTypedArgumentRepr(generic, true, false), 
                    typ = typ, 
                    convertedComments = convertedComments,
                    depth = 1
                }))
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
                    headingText = markdown.NewMarkdownText_FromUnstyled(arg.name or ("arg" .. tostring(i)))
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
                tableext.extend(baseNodes, parseTypeFieldType({
                    istate = istate, 
                    originRepr = transformRepr.transformTypedArgumentRepr(arg), 
                    typ = typ, 
                    convertedComments = convertedComments,
                    depth = 1
                }))
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
        if ret.type == "Tuple" then 
            -- Special case for tuples
            local baseNodes: {markdown.MarkdownNode} = {}
            for i, retdata in ret.data do 
                -- Returns have special constraints
                local retName, retComment = parseAnonymousArgData(`ret{i}`, convertedComments.returns, i)

                baseNodes[#baseNodes + 1] = {
                    type = "Heading" :: "Heading",
                    headingText = markdown.NewMarkdownText_FromRaw(retName)
                }  :: markdown.MarkdownNode

                if retComment ~= "" then
                    baseNodes[#baseNodes + 1] = {
                        type = "Text" :: "Text",
                        text = markdown.NewMarkdownText_FromRaw(retComment)
                    } :: markdown.MarkdownNode
                end

                tableext.extend(baseNodes, parseTypeFieldType({
                    istate = istate, 
                    originRepr = transformRepr.transformTypeFieldTypeRepr(retdata), 
                    typ = retdata, 
                    convertedComments = convertedComments,
                    depth = 1
                }))
            end

            if #baseNodes > 0 then
                blockNodes[#blockNodes + 1] = {
                    type = "Heading" :: "Heading",
                    level = nil :: number?, -- Bug in luau new type solver needs this (for now)
                    headingText = markdown.NewMarkdownText_FromRaw("Returns")
                } :: markdown.MarkdownNode

                blockNodes[#blockNodes + 1] = {
                    type = "Block" :: "Block",
                    nodes = baseNodes
                }       
            end 
        else 
            -- Returns have special constraints
            local retName, retComment = parseAnonymousArgData(`ret1`, convertedComments.returns, 1)

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

            tableext.extend(baseNodes, parseTypeFieldType({
                istate = istate, 
                originRepr = transformRepr.transformTypeFieldTypeRepr(ret), 
                typ = ret, 
                convertedComments = convertedComments, 
                inline = true,
                depth = 1
            }))

            if #baseNodes > 0 then
                blockNodes[#blockNodes + 1] = {
                    type = "Heading" :: "Heading",
                    level = nil :: number?, -- Bug in luau new type solver needs this (for now)
                    headingText = markdown.NewMarkdownText_FromRaw("Returns")
                } :: markdown.MarkdownNode

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
    generics: {types.TypedArgument},
    args: {types.TypedArgument},
    ret: types.TypeFieldType?
): markdown.MarkdownText
    -- Special code for inline functions
    local parsedFields: {markdown.MarkdownTextNode} = {}

    -- Add in the generics
    if #generics > 0 then 
        parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw("<")
        for i, generic in generics do 
            local genericNodes = {markdown.NewMarkdownTextNode_Raw(generic.name or "generic1")}

            if generic.typ then 
                local typNodes = parseTypeFieldTypeInline(istate, generic.typ)

                if #typNodes.nodes > 0 then 
                    genericNodes[#genericNodes + 1] = markdown.NewMarkdownTextNode_Raw("=")
                end

                tableext.extend(genericNodes, typNodes.nodes)
            end

            if i < #generics then
                parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw(", ")
            end
        end

        parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw(">")
    end

    -- Add in the arguments
    parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw("(")

    for i, argument in args do 
        if argument.name == "self" then
            -- Handle self in inline functions
            parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw("self")

            if i < #args then
                parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw(", ")
            end

            continue
        end

        if argument.name then
            parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw(argument.name)

            if argument.typ then
                parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw(": ")
            end
        end

        if argument.typ then 
            local typNodes = parseTypeFieldTypeInline(istate, argument.typ)

            tableext.extend(parsedFields, typNodes.nodes)
        end

        if i < #args then
            parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw(", ")
        end
    end

    parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw(")")

    if ret then
        parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw(" -> ")

        local retNodes = parseTypeFieldTypeInline(istate, ret)
        tableext.extend(parsedFields, retNodes.nodes)
    end

    return markdown.NewMarkdownText_FromNodeArray(parsedFields)
end

--- Parses a TypeFieldType (number or () -> number etc.) to a MarkdownText
---
--- Used for type tables and inline types
---
--- TODO: Move all inline typefieldtype's to use this API instead
function parseTypeFieldTypeInline(istate: istate.IState, type: types.TypeFieldType): markdown.MarkdownText 
    if type.type == "Function" then
        return parseFunctionInline(
            istate,
            type.data.generics,
            type.data.args,
            type.data.ret
        )
    elseif type.type == "String" or type.type == "Boolean" then  
        return markdown.NewMarkdownText_FromUnstyled(tostring(type.data))
    elseif type.type == "Basic" then 
        local irNodes: {markdown.MarkdownTextNode} = {} 

        irNodes[#irNodes + 1] = markdown.NewMarkdownTextNode_Link(
            {markdown.NewMarkdownTextNode_Unstyled(transformRepr.transformTypeFieldTypeRepr(type))},
            istate.plugin.resolveTypeToUrl(type.type, type.data)
        )

        return markdown.NewMarkdownText_FromNodeArray(irNodes)     
    elseif type.type == "Table" then
        -- Special code for inline tables
        local parsedFields: {markdown.MarkdownTextNode} = {}

        -- Start with the opening bracket
        parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw("{")

        for i, field in type.data do 
            tableext.extend(parsedFields, parseTypeFieldInline(istate, field))
            if i < #type.data then
                parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw(", ")
            end
        end

        -- End with the closing bracket
        parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw("}")

        return markdown.NewMarkdownText_FromNodeArray(parsedFields)
    elseif type.type == "Array" then
        -- Special code for inline array types
        local parsedFields: {markdown.MarkdownTextNode} = {}

        tableext.extend(parsedFields, parseTypeFieldTypeInline(istate, type.data).nodes)

        if #parsedFields > 0 then
            local blockNodes: {markdown.MarkdownTextNode} = {}
            blockNodes[#blockNodes + 1] = markdown.NewMarkdownTextNode_Raw("{")

            tableext.extend(blockNodes, parsedFields)

            blockNodes[#blockNodes + 1] = markdown.NewMarkdownTextNode_Raw("}")

            return markdown.NewMarkdownText_FromNodeArray(blockNodes)
        end

        return markdown.NewMarkdownText_FromNodeArray(parsedFields)
    elseif type.type == "Optional" then 
        -- Special code for inline optional types
        local parsedFields: {markdown.MarkdownTextNode} = {}

        tableext.extend(parsedFields, parseTypeFieldTypeInline(istate, type.data).nodes)

        if #parsedFields > 0 then
            parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw("?")
        end

        return markdown.NewMarkdownText_FromNodeArray(parsedFields)    
    elseif type.type == "Tuple" then
        if #type.data == 0 then
            return markdown.NewMarkdownText_FromRaw("()")
        elseif #type.data == 1 then 
            -- Special case for single element tuples
            return parseTypeFieldTypeInline(istate, type.data[1])
        end

        local parsedFields: {markdown.MarkdownTextNode} = {}

        parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw("(")
        for i, field in type.data do 
            tableext.extend(parsedFields, parseTypeFieldTypeInline(istate, field).nodes)
            if i < #type.data then
                parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw(", ")
            end
        end
        parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw(")")

        return markdown.NewMarkdownText_FromNodeArray(parsedFields)
    elseif type.type == "Union" or type.type == "Intersection" then
        -- Special code for inline unions/intersections separated by | or &
        local parsedFields: {markdown.MarkdownTextNode} = {}

        if #type.data > 0 then 
            -- Add parenthesis before
            parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw("(")
        end

        for i, field in type.data do 
            tableext.extend(parsedFields, parseTypeFieldTypeInline(istate, field).nodes) 

            if i < #type.data then
                local separator = if type.type == "Union" then "|" else "&"
                parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw(" " .. separator .. " ")
            end
        end

        if #type.data > 0 then 
            -- Add parenthesis after
            parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw(")")
        end

        return markdown.NewMarkdownText_FromNodeArray(parsedFields)
    elseif type.type == "Module" then
        local irNodes: {markdown.MarkdownTextNode} = {} 

        local urls = istate.plugin.resolveModuleToUrl(type.type, type.data.module, type.data.base)

        irNodes[#irNodes + 1] = markdown.NewMarkdownTextNode_Link(
            {markdown.NewMarkdownTextNode_Unstyled(type.data.module)},
            urls.moduleUrl
        )

        irNodes[#irNodes + 1] = markdown.NewMarkdownTextNode_Raw(".")

        irNodes[#irNodes + 1] = markdown.NewMarkdownTextNode_Link(
            {markdown.NewMarkdownTextNode_Unstyled(type.data.base)},
            urls.typeUrl
        )

        if type.data.generics then
            local hasAddedBracket = false
            for _, generic in type.data.generics do 
                local genericNodes = parseTypeFieldTypeInline(istate, generic).nodes

                if #genericNodes > 0 then
                    if not hasAddedBracket then
                        irNodes[#irNodes + 1] = markdown.NewMarkdownTextNode_Raw("<")
                    end
                    tableext.extend(irNodes, genericNodes)
                    if not hasAddedBracket then
                        irNodes[#irNodes + 1] = markdown.NewMarkdownTextNode_Raw(">")
                        hasAddedBracket = true
                    end
                end
            end
        end

        return markdown.NewMarkdownText_FromNodeArray(irNodes) 
    elseif type.type == "Generic" then
        local nodes: {markdown.MarkdownTextNode} = {
            markdown.NewMarkdownTextNode_Link(
                {markdown.NewMarkdownTextNode_Unstyled(type.data.base)},
                istate.plugin.resolveTypeToUrl(type.type, type.data.base)
            )
        }

        if #type.data.generics > 0 then
            nodes[#nodes + 1] = markdown.NewMarkdownTextNode_Raw("<")
        end

        for i, generic in type.data.generics do 
            local genericNodes = parseTypeFieldTypeInline(istate, generic).nodes

            tableext.extend(nodes, genericNodes)

            if i < #type.data.generics then
                -- Add a comma between generics
                nodes[#nodes + 1] = markdown.NewMarkdownTextNode_Raw(", ")
            end
        end

        if #type.data.generics > 0 then
            nodes[#nodes + 1] = markdown.NewMarkdownTextNode_Raw(">")
        end

        return markdown.NewMarkdownText_FromNodeArray(nodes)
    elseif type.type == "GenericPack" then 
        -- T...
        local nodes: {markdown.MarkdownTextNode} = {
            markdown.NewMarkdownTextNode_Link(
                {markdown.NewMarkdownTextNode_Unstyled(type.data)},
                istate.plugin.resolveTypeToUrl(type.type, type.data)
            )
        }
        nodes[#nodes + 1] = markdown.NewMarkdownTextNode_Raw("...")

        return markdown.NewMarkdownText_FromNodeArray(nodes)
    elseif type.type == "TypeOf" then 
        return markdown.NewMarkdownText_FromRaw("typeof(" .. type.data .. ")") -- Not much we can do with a general typeof
    elseif type.type == "TypeOfSetMetatable" then 
        -- This one is tricky, we can chain fields and metatable_fields into one and then treat it like a table
        local fields = {}
        for _, field in type.data.fields do 
            fields[#fields + 1] = field
        end
        for _, field in type.data.metatable_fields do 
            fields[#fields + 1] = field
        end

        local parsedFields: {markdown.MarkdownTextNode} = {}

        -- Start with the opening bracket
        parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw("{")

        for i, field in fields do 
            tableext.extend(parsedFields, parseTypeFieldInline(istate, field))
            if i < #fields then
                parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw(", ")
            end
        end

        -- End with the closing bracket
        parsedFields[#parsedFields + 1] = markdown.NewMarkdownTextNode_Raw("}")

        return markdown.NewMarkdownText_FromNodeArray(parsedFields)
    elseif type.type == "UnknownModule" then
        -- This is a special case where we don't know the module, so we just return the name
        return markdown.NewMarkdownText_FromRaw(type.data)
    elseif type.type == "Variadic" then
        local nodes: {markdown.MarkdownTextNode} = {
            markdown.NewMarkdownTextNode_Raw("...")
        }
        
        -- Add the nodes in inline format here
        tableext.extend(nodes, parseTypeFieldTypeInline(istate, type.data).nodes)

        return markdown.NewMarkdownText_FromNodeArray(nodes)
    elseif type.type == "VariadicPack" then 
        local nodes: {markdown.MarkdownTextNode} = {
            markdown.NewMarkdownTextNode_Raw("...")
        }

        -- Add a link to the type
        nodes[#nodes + 1] = markdown.NewMarkdownTextNode_Link(
            {markdown.NewMarkdownTextNode_Unstyled(type.data)},
            istate.plugin.resolveTypeToUrl(type.type, type.data)
        )

        return markdown.NewMarkdownText_FromNodeArray(nodes)
    else
        -- Unknown type, just return the raw representation
        return markdown.NewMarkdownText_FromRaw(transformRepr.transformTypeFieldTypeRepr(type))
    end
end

--- Parses a TypeFieldType (number or () -> number etc.) in a table
function parseTypeFieldType(data: istate.ParseTypeFieldTypeData): {markdown.MarkdownNode} 
    local fieldtype = data.typ
    data.istate.plugin.onParseTypeFieldType(data)
    if data.inline then 
        -- Redirect to inline parser
        local text = parseTypeFieldTypeInline(data.istate, fieldtype)
        return {
            {
                type = "Text" :: "Text",
                text = text,
                inline = true
            } :: markdown.MarkdownNode
        }
    end
    if fieldtype.type == "Function" then
        return parseFunction(
            data.istate,
            data.originRepr,
            data.convertedComments,
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
            text = transformRepr.transformTypeFieldTypeRepr(data.typ)
        } :: any
        
        return irNodes
    elseif fieldtype.type == "Basic" then
        -- TODO: make this look nicer
        local irNodes: {markdown.MarkdownNode} = {} 

        irNodes[#irNodes + 1] = {
            type = "Link" :: "Link",
            url = data.istate.plugin.resolveTypeToUrl(fieldtype.type, fieldtype.data),
            text = markdown.NewMarkdownText_FromUnstyled(transformRepr.transformTypeFieldTypeRepr(data.typ)),
            inline = data.inline
        } :: any
        
        return irNodes        
    elseif fieldtype.type == "Table" then
        -- First seperate out the data as either methods or fields (which are everything outside of methods)
        local methods: {types.TypeField} = {}
        local fields: {types.TypeField} = {}
        for _, field in fieldtype.data do 
            if field.field_type.type == "Function" then
                methods[#methods + 1] = field
            else
                fields[#fields + 1] = field
            end
        end

        -- Ensure methods come first before fields
        local finalFields: {types.TypeField} = {}
        for _, method in methods do 
            finalFields[#finalFields + 1] = method
        end

        for _, field in fields do 
            finalFields[#finalFields + 1] = field
        end

        -- FUMA-SPECIFIC
        -- In fuma, we can use a type table if not inline
        local columns: {markdown.FumaTypeTableColumn} = {}

        for _, field in finalFields do 
            local convertedComments = convertComments.convertCommentsInline(field.comments, true);

            if convertedComments.skip then
                continue -- Skip this field if it is marked as skip
            end

            local column: markdown.FumaTypeTableColumn = {
                field = transformRepr.transformTypeFieldKey(field.field_name),
                typename = parseTypeFieldTypeInline(data.istate, field.field_type),
                description = markdown.NewMarkdownText_FromNodeArray(convertedComments.output) or markdown.NewMarkdownText_FromRaw("No description provided"),
                required = field.field_type.type ~= "Optional"
            }
            columns[#columns + 1] = column
        end
        return {markdown.MarkdownNode_FumaTypeTable(columns)}
    elseif fieldtype.type == "Array" then 
        local nodes: {markdown.MarkdownNode} = parseTypeFieldType({
            istate = data.istate, 
            originRepr = data.originRepr, 
            typ = fieldtype.data, 
            convertedComments = data.convertedComments, 
            inline = true,
            depth = data.depth+1
        })

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
            parseTypeFieldType({
                istate = data.istate, 
                originRepr = data.originRepr, 
                typ = fieldtype.data, 
                convertedComments = data.convertedComments, 
                inline = true,
                depth = data.depth -- For Optionals, the depth should remain the same 
            })
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
            return parseTypeFieldType({
                istate = data.istate, 
                originRepr = data.originRepr, 
                typ = fieldtype.data[1], 
                convertedComments = data.convertedComments, 
                inline = data.inline,
                depth = data.depth -- For tuples of length 1, keep same depth
            })
        end

        local pnodes = tableext.arraymap(
            fieldtype.data,
            function(typ: types.TypeFieldType): {markdown.MarkdownNode}
                return parseTypeFieldType({
                    istate = data.istate, 
                    originRepr = data.originRepr, 
                    typ = typ, 
                    convertedComments = data.convertedComments,
                    depth = data.depth + 1
                })
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
                local variantName, variantComment = parseAnonymousArgData(`Value {i}`, data.convertedComments.variantDocs, i)
                
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
        local pnodes = tableext.arraymap(
            fieldtype.data,
            function(typ: types.TypeFieldType): {markdown.MarkdownNode}
                return parseTypeFieldType({
                    istate = data.istate, 
                    originRepr = data.originRepr, 
                    typ = typ, 
                    convertedComments = data.convertedComments,
                    depth = data.depth + 1
                })
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
                local variantName, variantComment = parseAnonymousArgData(`Variant {i}`, data.convertedComments.variantDocs, i)
                
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
        -- Use inline repr
        local text = parseTypeFieldTypeInline(data.istate, fieldtype)

        local irNodes: {markdown.MarkdownNode} = {}

        irNodes[#irNodes + 1] = {
            type = "Text" :: "Text",
            text = text,
            inline = data.inline
        } :: markdown.MarkdownNode

        irNodes[#irNodes + 1] = {
            type = "Text" :: "Text",
            text = markdown.NewMarkdownText_FromRaw(""),
        } :: markdown.MarkdownNode

        return irNodes        
    elseif fieldtype.type == "Intersection" then
        local pnodes = tableext.arraymap(
            fieldtype.data,
            function(typ: types.TypeFieldType): {markdown.MarkdownNode}
                return parseTypeFieldType({
                    istate = data.istate, 
                    originRepr = data.originRepr, 
                    typ = typ, 
                    convertedComments = data.convertedComments,
                    depth = data.depth + 1
                })
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
                local variantName, variantComment = parseAnonymousArgData(`Variant {i}`, data.convertedComments.variantDocs, i)
                
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
                url = data.istate.plugin.resolveTypeToUrl(fieldtype.type, fieldtype.data.base),
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
            local genericNodes = parseTypeFieldType({
                istate = data.istate, 
                originRepr = transformRepr.transformTypeFieldTypeRepr(generic), 
                typ = generic, 
                convertedComments = data.convertedComments, 
                inline = true,
                depth = data.depth + 1
            })

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
        -- Use inline repr for T... type packs
        local text = parseTypeFieldTypeInline(data.istate, fieldtype)

        local irNodes: {markdown.MarkdownNode} = {}

        irNodes[#irNodes + 1] = {
            type = "Text" :: "Text",
            text = text,
            inline = data.inline
        } :: markdown.MarkdownNode

        irNodes[#irNodes + 1] = {
            type = "Text" :: "Text",
            text = markdown.NewMarkdownText_FromRaw(""),
        } :: markdown.MarkdownNode

        return irNodes        
    elseif fieldtype.type == "TypeOf" then 
        return {} -- Not much else we can say here for a complex generalized typeof 
    elseif fieldtype.type == "TypeOfSetMetatable" then 
        -- FUMA-SPECIFIC
        -- In fuma, we can use a type table if at top level and not inline
        local finalFields: {types.TypeField} = {}
        for _, field in fieldtype.data.fields do
            finalFields[#finalFields + 1] = field
        end
        for _, field in fieldtype.data.metatable_fields do
            finalFields[#finalFields + 1] = field
        end

        local columns: {markdown.FumaTypeTableColumn} = {}

        for _, field in finalFields do 
            local convertedComments = convertComments.convertCommentsInline(field.comments, true);

            if convertedComments.skip then
                continue -- Skip this field if it is marked as skip
            end

            local column: markdown.FumaTypeTableColumn = {
                field = transformRepr.transformTypeFieldKey(field.field_name),
                typename = parseTypeFieldTypeInline(data.istate, field.field_type),
                description = markdown.NewMarkdownText_FromNodeArray(convertedComments.output) or markdown.NewMarkdownText_FromRaw("No description provided"),
                required = field.field_type.type ~= "Optional"
            }
            columns[#columns + 1] = column
        end
        return {markdown.MarkdownNode_FumaTypeTable(columns)}
    elseif fieldtype.type == "UnknownModule" then
        return {
            {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromUnstyled(fieldtype.data),
                inline = data.inline
            } :: markdown.MarkdownNode
        }
    elseif fieldtype.type == "Variadic" then
        local nodes: {markdown.MarkdownNode} = {
            {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromRaw("..."),
                inline = data.inline
            } :: markdown.MarkdownNode
        }
        
        -- Add the nodes in inline format here
        tableext.extend(nodes, parseTypeFieldType({
            istate = data.istate, 
            originRepr = data.originRepr, 
            typ = fieldtype.data, 
            convertedComments = data.convertedComments, 
            inline = true,
            depth = data.depth + 1
        }))

        if not data.inline then
            nodes[#nodes + 1] = {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromRaw(""),
                inline = data.inline
            } :: markdown.MarkdownNode
        end

        return nodes
    elseif fieldtype.type == "VariadicPack" then
        return {
            {
                type = "Text" :: "Text",
                text = markdown.NewMarkdownText_FromRaw("..."),
                inline = data.inline
            } :: markdown.MarkdownNode,
            {
                type = "Link" :: "Link",
                text = markdown.NewMarkdownText_FromUnstyled(fieldtype.data),
                url = data.istate.plugin.resolveTypeToUrl(fieldtype.type, fieldtype.data),
                inline = data.inline
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

--- Parse a TypeField inline (foo: number or foo: () -> number etc.)
---
--- Note that inline TypeFields don't support most comments (and this shouldn't even be syntactically possible in Luau)
function parseTypeFieldInline(istate: istate.IState, typ: types.TypeField): {markdown.MarkdownTextNode}  
    local convertedComments = convertComments.convertComments(typ.comments, istate.ignorenondoc);

    local blockNodes: {markdown.MarkdownTextNode} = {}
    if convertedComments.skip then
        return blockNodes -- Ignore explicitly skipped type fields
    end
    
    local nodes: {markdown.MarkdownTextNode} = {}

    -- Insert type field name
    local fieldName = markdown.NewMarkdownTextNode_Unstyled(transformRepr.transformTypeFieldKey(typ.field_name))
    nodes[#nodes + 1] = fieldName
    nodes[#nodes + 1] = markdown.NewMarkdownTextNode_Raw(": ")
    
    tableext.extend(
        nodes, 
        parseTypeFieldTypeInline(istate, typ.field_type).nodes
    )

    return nodes 
end

--- Parses a TypeField (foo: number or foo: () -> number etc.)
function parseTypeField(istate: istate.IState, typ: types.TypeField, inline: boolean?, depth: number?): {markdown.MarkdownNode}    
    local convertedComments = convertComments.convertComments(typ.comments, istate.ignorenondoc);

    local blockNodes: {markdown.MarkdownNode} = {}
    if convertedComments.skip then
        return blockNodes -- Ignore explicitly skipped type fields
    end

    if inline then 
        local nodes: {markdown.MarkdownNode} = {}

        -- Insert type field name
        local fieldName = transformRepr.transformTypeFieldKey(typ.field_name)
        nodes[#nodes + 1] = {
            type = "Text" :: "Text",
            text = markdown.NewMarkdownText_FromUnstyled(fieldName),
            inline = true
        } :: markdown.MarkdownNode

        nodes[#nodes + 1] = {
            type = "Text" :: "Text",
            text = markdown.NewMarkdownText_FromRaw(": "),
            inline = true
        } :: markdown.MarkdownNode
        
        tableext.extend(
            nodes, 
            parseTypeFieldType(
                {
                    istate = istate,
                    originRepr = transformRepr.transformTypeFieldReprWithPat(typ, nil, "\n"),
                    typ = typ.field_type, 
                    convertedComments = convertedComments,
                    inline = true,
                    depth = if depth then depth + 1 else 1
                }
            )
        )

        return nodes
    end

    local fieldName = transformRepr.transformTypeFieldKey(typ.field_name)

    -- Add header node
    blockNodes[#blockNodes + 1] = {
        type = "Heading" :: "Heading",
        level = nil :: number?, -- Bug in luau new type solver needs this (for now)
        headingText = markdown.NewMarkdownText_FromUnstyled(fieldName)    
    }

    if #convertedComments.output > 0 then
        -- Add converted comments output as well
        blockNodes = tableext.extend(blockNodes, convertedComments.output)
    end    

    blockNodes[#blockNodes + 1] = {
        type = "Block" :: "Block",
        nodes = parseTypeFieldType(
            {
                istate = istate,
                originRepr = transformRepr.transformTypeFieldReprWithPat(typ, nil, "\n"),
                typ = typ.field_type, 
                convertedComments = convertedComments,
                inline = if convertedComments.inlineFields[fieldName] then true else false,
                depth = if depth then depth + 1 else 1
            }
        )
    }

    return blockNodes
end

return {
    parseFunction = parseFunction,
    parseTypeField = parseTypeField,
    parseTypeFieldType = parseTypeFieldType
}