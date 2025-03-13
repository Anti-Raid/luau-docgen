--!strict
local types = require("types.luau")
local convertComments = require("convertcomments.luau")
local argparser = require("argparser.luau")
local markdown = require("markdown.luau")
local fmt = require("markdownformatter.luau")
local transformRepr = require("transformrepr.luau")
local tableext = require("table.luau")
local functionDocumentor = require("./documentors/function.luau")

-- Begin of documentation generation actual code
local ast: types.TypeSet, globals: types.Globals = ...

local p1 = tableext.extend({2}, {4})
assert(p1[1] == 2, "Inconsistent state: tableext.arrayextend failed to copy over 1")
assert(p1[2] == 4, "Inconsistent state: tableext.arrayextend failed to copy over 2")

-- Parse arguments at top-level
local md = argparser.parseArguments(globals)

print("Running reqtest self-test for requires")
local a = require"reqtest/a.luau"
assert(a.a == 1) -- Ensure stable requires


--- Parses a TypeFieldType (number or () -> number etc.)
local function parseTypeFieldType(originField: types.TypeField?, typ: types.TypeFieldType, convertedComments: convertComments.ConvertCommentResponse): {markdown.MarkdownNode} 
    local blockNodes: {markdown.MarkdownNode} = {} 

    local fieldtype = typ:extract()
    if fieldtype.type == "Function" then
        local originRepr = nil
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
    elseif fieldtype.type == "Array" then 
        return parseTypeFieldType(originField, fieldtype.data, convertedComments)
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
local function parseTypeField(typ: types.TypeField): {markdown.MarkdownNode}
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
        nodes = parseTypeFieldType(typ, typ.field_type, convertedComments)
    }

    return blockNodes
end

local function parseTypeDef(typ: types.TypeDef): {markdown.MarkdownNode} 
    local convComments = convertComments.convertComments(globals, typ.type_comments, md.ignorenondoc)

    if convComments.skip then
        return {} -- Ignore explicitly skipped types
    end

    -- Initial content/prelude
    local blockNodes: {markdown.MarkdownNode} = {}

    -- Add header node
    blockNodes[#blockNodes + 1] = {
        type = "Heading" :: "Heading",
        level = nil :: number?, -- Bug in luau new type solver needs this (for now)
        headingText = markdown.NewMarkdownText_FromRaw(typ.name)    
    }

    if #convComments.output > 0 then
        -- Add converted comments output as well
        tableext.extend(blockNodes, convComments.output)
    end

    -- Add code block of the type
    blockNodes[#blockNodes + 1] = {
        type = "CodeBlock" :: "CodeBlock",
        description = "Raw Type",
        language = "luau",
        text = typ:string_repr_with_pats(",\n\n\t", ", ")
    }

    local extractedType = typ.type_def_type:extract()

    if extractedType.type == "Table" then 
        -- Simple table type

        -- First seperate out the data as either methods or fields (which are everything outside of methods)
        local methods: {types.TypeField} = {}
        local fields: {types.TypeField} = {}
        for _, field in extractedType.data do 
            --print("RustReprP", field:string_repr_with_pats("\n\t", depth))
            --print("LuauTransformReprP", transformRepr.transformTypeFieldReprWithPat(field, depth, "\n\t", function(_, typ) return typ end))
            assert(transformRepr.transformTypeFieldReprWithPat(field, 1, "\n\t", function(_, typ): string return typ end) == field:string_repr_with_pats("\n\t", 1), "Inconsistent state: transformTypeField and string_repr_with_pats return differing results?")

            --print("RustRepr", field.field_type:string_repr(1))
            --print("LuauTransformRepr", transformRepr.transformRepr(field.field_type, 1, function(_: string, a: string) return a end))
            assert(transformRepr.transformRepr(field.field_type, 1, function(_: string, a: string) return a end) == field.field_type:string_repr(1), "Inconsistant state: transformRepr and string_repr(1) return differing results?")

            if field.field_type:extract().type == "Function" then
                methods[#methods + 1] = field
            else
                fields[#fields + 1] = field
            end
        end

        -- Parse fields
        if #fields > 0 then            
            local parsedFields: {markdown.MarkdownNode} = {}
            for _, field in fields do 
                tableext.extend(parsedFields, parseTypeField(field))
            end

            if #parsedFields > 0 then
                blockNodes[#blockNodes + 1] = {
                    type = "Block" :: "Block",
                    nodes = parsedFields
                }
            end
        end

        -- Parse methods
        if #methods > 0 then
            local parsedFields: {markdown.MarkdownNode} = {}
            for _, field in methods do 
                tableext.extend(parsedFields, parseTypeField(field))
            end

            if #parsedFields > 0 then
                blockNodes[#blockNodes + 1] = {
                    type = "Block" :: "Block",
                    nodes = parsedFields
                }
            end
        end
    end

    return blockNodes
end

local function parseTypeFunction(typ: types.TypeFunction): {markdown.MarkdownNode} 
    local convComments = convertComments.convertComments(globals, typ.type_comments, md.ignorenondoc)

    if convComments.skip then
        return {} -- Ignore explicitly skipped types
    end

    -- Initial content/prelude
    local blockNodes: {markdown.MarkdownNode} = {}

    -- Add header node
    blockNodes[#blockNodes + 1] = {
        type = "Heading" :: "Heading",
        level = nil :: number?, -- Bug in luau new type solver needs this (for now)
        headingText = markdown.NewMarkdownText_FromRaw(typ.name)    
    }

    if #convComments.output > 0 then
        -- Add converted comments output as well
        tableext.extend(blockNodes, convComments.output)
    end

    tableext.extend(blockNodes, functionDocumentor.parseFunction(
        typ:string_repr(),
        convComments,
        typ.generics,
        typ.args,
        typ.ret
    ))


    return blockNodes
end

-- First add in the typedefs
local typedefsBlock: {{markdown.MarkdownNode}} = {}
for typ in ast:iter_typedefs() do
    local typedef = typ:extract()
    assert(typedef.type == "TypeDef")
    print("Processing " .. typedef.data.name)
    local td = parseTypeDef(typedef.data)

    typedefsBlock[#typedefsBlock + 1] = td -- Add to typedefsblock
end

--- Then add in the functions
local functionsBlock: {{markdown.MarkdownNode}} = {} -- Final output string
for typ in ast:iter_functions() do
    local typedef = typ:extract()
    assert(typedef.type == "Function")
    print("Processing " .. typedef.data.name)
    local td = parseTypeFunction(typedef.data)

    functionsBlock[#functionsBlock + 1] = td -- Add to functionsBlock
end

-- Finally, combine the two
if md.modname ~= "" then
    local nodes: {markdown.MarkdownNode} = {
        {
            type = "Heading" :: "Heading",
            headingText = markdown.NewMarkdownText_FromRaw(md.modname)
        }, 
    } :: {markdown.MarkdownNode}

    if #typedefsBlock > 0 then
        nodes[#nodes + 1] = {
            type = "Heading" :: "Heading",
            level = 2, -- Special case is needed here because yeah
            headingText = markdown.NewMarkdownText_FromRaw("Types")
        } :: markdown.MarkdownNode
    end

    for _, typedefBlock in typedefsBlock do
        nodes[#nodes + 1] = {
            type = "Block" :: "Block",
            nodes = typedefBlock
        }
    end

    if #functionsBlock > 0 then
        nodes[#nodes + 1] = {
            type = "Heading" :: "Heading",
            headingText = markdown.NewMarkdownText_FromRaw("Functions")
        } :: markdown.MarkdownNode
    end

    for _, functionBlock in functionsBlock do
        nodes[#nodes + 1] = {
            type = "Block" :: "Block",
            nodes = functionBlock
        }
    end

    local block = {
        type = "Block" :: "Block",
        nodes = nodes
     } :: markdown.MarkdownNode

    if md.debugmode then
        print(globals.prettyprint(block))
    end
    return fmt.MarkdownNode_String(globals, block, true, 0, "Root") -- Convert to markdown
else
    local nodes: {markdown.MarkdownNode} = {} :: {markdown.MarkdownNode}

    if #typedefsBlock > 0 then
        nodes[#nodes + 1] = {
            type = "Heading" :: "Heading",
            headingText = markdown.NewMarkdownText_FromRaw("Types")
        } :: markdown.MarkdownNode
    end

    for _, typedefBlock in typedefsBlock do
        nodes[#nodes + 1] = {
            type = "Block" :: "Block",
            nodes = typedefBlock
        }
    end

    if #functionsBlock > 0 then
        nodes[#nodes + 1] = {
            type = "Heading" :: "Heading",
            headingText = markdown.NewMarkdownText_FromRaw("Functions")
        } :: markdown.MarkdownNode
    end

    for _, functionBlock in functionsBlock do
        nodes[#nodes + 1] = {
            type = "Block" :: "Block",
            nodes = functionBlock
        }
    end

    local block = {
        type = "Block" :: "Block",
        nodes = nodes
     } :: markdown.MarkdownNode

    if md.debugmode then
        print(globals.prettyprint(block))
    end
    return fmt.MarkdownNode_String(globals, block, true, 0, "Root") -- Convert to markdown
end