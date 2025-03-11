--!strict
local types = require("types.luau")
local convertComments = require("convertcomments.luau")
local parseArguments = require("argparser.luau")
local mdutils = require("mdutils.luau")
local transformRepr = require("transformrepr.luau")

-- Begin of documentation generation actual code
local ast: types.TypeSet, globals: types.Globals = ...

--- Intermediary data used when parsing a type field
type TypeFieldIData = {
    previous_fields: {types.TypeField}
}

--- Parses a TypeField (foo: number or foo: () -> number etc.)
local function parseTypeField(depth: number, typ: types.TypeField, idata: TypeFieldIData?): string 
    if not idata then
        idata = {
            previous_fields = {}
        }
    end

    --print(globals.prettyprint(convertComments(globals, typ.comments)))
    local convertedComments = convertComments(globals, typ.comments);

    if convertedComments.skip then
        return "" -- Ignore explicitly skipped type fields
    end

    local fieldtype = typ.field_type:extract()

    local args = {
        mdutils.createHeading(depth, typ.field_name),
    }

    -- Function type
    if convertedComments.output ~= "" then
        args[#args + 1] = convertedComments.output
    end    

    if fieldtype.type == "Function" then
        args[#args + 1] = mdutils.createCodeBlock("luau", typ:string_repr_with_pats("\n"), "Function Signature")

        if #fieldtype.data.args > 0 then
            args[#args + 1] = mdutils.createHeading(depth+1, "Arguments")
            local argLists: {string} = {}
            for i, arg in fieldtype.data.args do 
                if arg.name == "self" then
                    -- Skip self argument
                    continue
                end

                local stringRepr = "any"
                if arg.typ then
                    stringRepr = arg.typ:string_repr()
                end
                local farg = mdutils.bold(arg.name or ("arg" .. tostring(#argLists))) .. " (" .. mdutils.italic(stringRepr) .. ") "
                if arg.name and convertedComments.fieldDocs[arg.name] then
                    farg ..= "- " .. convertedComments.fieldDocs[arg.name]
                end

                argLists[#argLists + 1] = farg
            end

            args[#args + 1] = mdutils.createList(argLists)
        end

    end

    return table.concat(args, mdutils.nlseperate()) .. mdutils.nlseperate()
end

local function parseTypeDef(depth: number, typ: types.TypeDef): string 
    local convComments = convertComments(globals, typ.type_comments)

    if convComments.skip then
        return "" -- Ignore explicitly skipped types
    end

    -- Initial content/prelude
    local output = table.concat({
        mdutils.createHeading(depth, typ.name),
        convComments.output,
        mdutils.createCodeBlock("luau", typ:string_repr_with_pats(",\n\n\t", ", "), "Raw Type")
    }, mdutils.nlseperate()) .. mdutils.nlseperate()

    local extractedType = typ.type_def_type:extract()

    if extractedType.type == "Table" then 
        -- Simple table type

        -- First seperate out the data as either methods or fields (which are everything outside of methods)
        local methods: {types.TypeField} = {}
        local fields: {types.TypeField} = {}
        for _, field in extractedType.data do 
            print("RustReprP", field:string_repr_with_pats("\n\t", depth))
            print("LuauTransformReprP", transformRepr.transformTypeFieldReprWithPat(field, depth, "\n\t", function(_, typ) return typ end))
            assert(transformRepr.transformTypeFieldReprWithPat(field, depth, "\n\t", function(_, typ): string return typ end) == field:string_repr_with_pats("\n\t", depth), "Inconsistent state: transformTypeField and string_repr_with_pats return differing results?")

            print("RustRepr", field.field_type:string_repr(1))
            print("LuauTransformRepr", transformRepr.transformRepr(field.field_type, 1, function(_: string, a: string) return a end))
            assert(transformRepr.transformRepr(field.field_type, 1, function(_: string, a: string) return a end) == field.field_type:string_repr(1), "Inconsistant state: transformRepr and string_repr(1) return differing results?")

            if field.field_type:extract().type == "Function" then
                methods[#methods + 1] = field
            else
                fields[#fields + 1] = field
            end
        end

        -- Parse fields
        if #fields > 0 then
            output ..= mdutils.createHeading(depth+1, "Fields") .. mdutils.nlseperate()
            for _, field in fields do 
                output ..= parseTypeField(depth+1, field)
            end
        end
        -- Parse methods
        if #methods > 0 then
            output ..= mdutils.createHeading(depth+1, "Methods") .. mdutils.nlseperate()
            for _, field in methods do 
                output ..= parseTypeField(depth+1, field)
            end    
        end
    end

    return output
end

local function parseTypeFunction(depth: number, typ: types.TypeFunction): string 
    return ""
end

local output = "" -- Final output string

-- First insert module name
local md = parseArguments(globals)

--- Global header depth to use as the basis in the markdown generation
local globalHeaderDepth = 1
if md.modname ~= "" then
    output ..= mdutils.createHeading(globalHeaderDepth, md.modname) .. mdutils.nlseperate()
    globalHeaderDepth += 1
end

-- First add in the typedefs
for typ in ast:iter_typedefs() do
    local typedef = typ:extract()
    assert(typedef.type == "TypeDef")
    output ..= parseTypeDef(globalHeaderDepth, typedef.data)
end

output ..= mdutils.sectionSeparator() .. mdutils.nlseperate()

--- Then add in the functions
for typ in ast:iter_functions() do
    local typedef = typ:extract()
    assert(typedef.type == "Function")
    output ..= parseTypeFunction(globalHeaderDepth+1, typedef.data)
end

return output