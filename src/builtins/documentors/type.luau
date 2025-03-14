--!strict
local types = require("../types")
local markdown = require("../markdownir/markdown")
local functionDocumentor = require("./function")
local convertComments = require("../convertcomments")
local tableext = require("../table")
local argparser = require("../argparser")
local transformRepr = require("../transformrepr")
local typefieldDocumentor = require("./typefield")

local function parseTypeFieldListOfTypeDef(globals: types.Globals, md: argparser.ParsedArgumentResult, typefields: {types.TypeField}): {markdown.MarkdownNode}
    local blockNodes: {markdown.MarkdownNode} = {}

    -- First seperate out the data as either methods or fields (which are everything outside of methods)
    local methods: {types.TypeField} = {}
    local fields: {types.TypeField} = {}
    for _, field in typefields do 
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
            tableext.extend(parsedFields, typefieldDocumentor.parseTypeField(globals, md, field))
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
            tableext.extend(parsedFields, typefieldDocumentor.parseTypeField(globals, md, field))
        end

        if #parsedFields > 0 then
            blockNodes[#blockNodes + 1] = {
                type = "Block" :: "Block",
                nodes = parsedFields
            }
        end
    end

    return blockNodes
end

local function parseTypeDef(globals: types.Globals, md: argparser.ParsedArgumentResult, typ: types.TypeDef): {markdown.MarkdownNode} 
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
        tableext.extend(blockNodes, parseTypeFieldListOfTypeDef(globals, md, extractedType.data))
    elseif extractedType.type == "TypeOfSetMetatable" then
        tableext.extend(blockNodes, parseTypeFieldListOfTypeDef(globals, md, extractedType.data.fields))

        if #extractedType.data.metatable_fields then 
            local metaNodes = tableext.extend(
                {
                    {
                        type = "Heading" :: "Heading",
                        headingText = markdown.NewMarkdownText_FromRaw("Metatable Fields")
                    },
                },
                parseTypeFieldListOfTypeDef(globals, md, extractedType.data.metatable_fields)
            )

            blockNodes[#blockNodes + 1] = {
                type = "Block" :: "Block",
                nodes = metaNodes
            } :: markdown.MarkdownNode
        end
    end

    return blockNodes
end

local function parseTypeFunction(globals: types.Globals, md: argparser.ParsedArgumentResult, typ: types.TypeFunction): {markdown.MarkdownNode} 
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

return {
    parseTypeDef = parseTypeDef,
    parseTypeFunction = parseTypeFunction,
}