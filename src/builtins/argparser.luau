--!strict
local types = require("types.luau")

export type ParsedArgumentResult = {
    --- Name of module being documented
    modname: string,
    --- Files to document
    files: {string},
    --- What plugin file (if any) to load
    plugin: string?,
    --- Ignore non exported types or not
    ignorenonexportedtypes: boolean,
    --- Whether or not to error on unsupported types
    erroronunsupported: boolean,
    --- Whether or not to ignore non doc comments
    ignorenondoc: boolean,
    --- Whether or not to enable debug mode
    debugmode: boolean,
    --- Target file to write to
    output: string,
    -- Options set by the user
    -- This is a table of the parsed arguments
    optionsSet: types.ParsedArgs,
}

-- Modify this function to change how special comments are converted to markdown
local argmap = {
    modname = function(output: ParsedArgumentResult, values: {string}, argtype: string) 
        output.modname = table.concat(values, "|")
    end,
    ignorenondoc = function(output: ParsedArgumentResult, values: {string}, argtype: string) 
        output.ignorenondoc = (values[1] == "true")
    end,
    debugmode = function(output: ParsedArgumentResult, values: {string}, argtype: string) 
        output.debugmode = (values[1] == "true")
    end,
    ignore_nonexported_types = function(output: ParsedArgumentResult, values: {string}, argtype: string) 
        output.ignorenonexportedtypes = (values[1] == "true")
    end,
    error_on_unsupported = function(output: ParsedArgumentResult, values: {string}, argtype: string) 
        output.erroronunsupported = values[1] ~= "false"
    end,
    output = function(output: ParsedArgumentResult, values: {string}, argtype: string) 
        output.output = values[1] or "stdout"
    end,
    plugin = function(output: ParsedArgumentResult, values: {string}, argtype: string) 
        output.plugin = values[1]
    end,
}

-- Parses arguments from globals.documentor_args into a set of parsed arguments 
local function parseArguments(globals: types.Globals): ParsedArgumentResult
    local parsedArgs = globals.parsedocumentorargs(globals.documentor_args)

    local output: ParsedArgumentResult = {
        modname = "",
        files = {},
        plugin = nil,
        ignorenondoc = false,
        debugmode = false,
        erroronunsupported = false,
        ignorenonexportedtypes = false,
        output = "stdout",
        optionsSet = parsedArgs
    }

    for _, arg in parsedArgs.args do
        -- Handle values as files to load and document
        if arg.arg_type == "Value" then
            output.files[#output.files + 1] = arg.name
        elseif argmap[arg.name] then
            argmap[arg.name](output, arg.values, arg.arg_type)
        end
    end

    return output
end

return {
    parseArguments = parseArguments,
    argmap = argmap
}