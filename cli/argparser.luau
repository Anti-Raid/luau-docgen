--!strict
local argparserimpl = require("./argparserimpl")

--- Contains a single parsed argument from globals.parsedocumentorargs
export type ParsedArg = {
    --- The name of the argument
    name: string,
    --- The values passed to the argument
    values: {string},
    --- Whether the argument is short (-a) or long (--abc) or a value (abc)
    arg_type: "Short" | "Long" | "Value",
}

--- Contains a parsed list of arguments from globals.parsedocumentorargs
export type ParsedArgs = {
    --- List of arguments (in order of appearance)
    args: {ParsedArg},
}

export type ParsedArgumentResult = {
    --- Name of module being documented
    modname: string,
    --- Files to document
    files: {string},
    --- What plugin file (if any) to load
    plugins: {string},
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
    optionsSet: ParsedArgs,
    --- Whether or not to use full-moon (if the Rust extension process has been compiled and is available)
    useFullMoon: boolean,
    --- Set a different generator
    generator: string?, -- If set, this will override the default generator
    -- Whether or not to show help
    help: boolean,
}

type ArgMap = {
    [string]: {
        fn: (output: ParsedArgumentResult, values: {string}, argtype: string) -> (),
        description: string,
        opts: string
    }
}

local argmap: ArgMap = {
    modname = {
        fn = function(output: ParsedArgumentResult, values: {string}, argtype: string) 
            output.modname = table.concat(values, "|")
        end,
        opts = "<module name>",
        description = "Sets the name of the module being documented",
    },
    ignorenondoc = {
        fn = function(output: ParsedArgumentResult, values: {string}, argtype: string) 
            output.ignorenondoc = (values[1] ~= "false")
        end,
        opts = "<true|false>",
        description = "Ignore non doc comments",
    },
    debugmode = {
        fn = function(output: ParsedArgumentResult, values: {string}, argtype: string) 
            output.debugmode = (values[1] ~= "false")
        end,
        opts = "<true|false>",
        description = "Enable debug mode",
    },
    ignore_nonexported_types = {
        fn = function(output: ParsedArgumentResult, values: {string}, argtype: string) 
            output.ignorenonexportedtypes = values[1] ~= "false"
        end,
        opts = "<true|false>",
        description = "Ignore non exported types",
    },
    error_on_unsupported = {
        fn = function(output: ParsedArgumentResult, values: {string}, argtype: string) 
            output.erroronunsupported = values[1] ~= "false"
        end,
        opts = "<true|false>",
        description = "Error on unsupported types",
    },
    output = {
        fn = function(output: ParsedArgumentResult, values: {string}, argtype: string) 
            output.output = values[1] or "stdout"
        end,
        opts = "<output file | stdout>",
        description = "Target file to write to",
    },
    plugin = {
        fn = function(output: ParsedArgumentResult, values: {string}, argtype: string) 
            for _, plugin in values do
                output.plugins[#output.plugins + 1] = plugin
            end
        end,
        opts = "<plugin files>",
        description = "Plugin files to load",
    },
    help = {
        fn = function(output: ParsedArgumentResult, values: {string}, argtype: string) 
            output.help = true
        end,
        opts = "",
        description = "Show help",
    },
    generator = {
        fn = function(output: ParsedArgumentResult, values: {string}, argtype: string) 
            assert(values[1] == "markdown" or values[1] == "markdown_fuma", "Invalid generator: " .. values[1])
            output.generator = values[1]
        end,
        opts = "<markdown|markdown_fuma>",
        description = "Use a different generator",
    },
    ["use-full-moon"] = {
        fn = function(output: ParsedArgumentResult, values: {string}, argtype: string) 
            output.useFullMoon = (values[1] ~= "false")
        end,
        opts = "<true|false>",
        description = "Use full-moon (if available)",
    },
}

-- Parses arguments from globals.documentor_args into a set of parsed arguments 
local function parseArguments(args: {string}): ParsedArgumentResult
    local parsedArgs = argparserimpl.parsedocumentorargs(args)

    local output: ParsedArgumentResult = {
        modname = "",
        files = {},
        plugins = {},
        ignorenondoc = false,
        debugmode = false,
        erroronunsupported = false,
        ignorenonexportedtypes = false,
        output = "stdout",
        optionsSet = parsedArgs,
        useFullMoon = false,
        help = false,
    }

    for _, arg in parsedArgs.args do
        -- Handle values as files to load and document
        if arg.arg_type == "Value" then
            output.files[#output.files + 1] = arg.name
        elseif argmap[arg.name] then
            argmap[arg.name].fn(output, arg.values, arg.arg_type)
        else
            local validArgs = {}
            for k in argmap do
                validArgs[#validArgs + 1] = k
            end
            error("Unknown argument: " .. arg.name .. ", choose from: " .. table.concat(validArgs, ", "))
        end
    end

    return output
end

return {
    parseArguments = parseArguments,
    argmap = argmap
}