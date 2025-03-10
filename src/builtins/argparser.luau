--!strict
local types = require("types.luau")

type ParsedArgumentResult = {
    --- Name of module being documented
    modname: string,
}

-- Modify this function to change how special comments are converted to markdown
local argmap = {
    modname = function(output: ParsedArgumentResult, values: {string}, short: boolean) 
        output.modname = table.concat(values, "|")
    end
}

-- Parses arguments from globals.documentor_args into a set of parsed arguments 
local function parseArguments(globals: types.Globals): ParsedArgumentResult
    local parsedArgs = globals.parsedocumentorargs(globals.documentor_args)

    local output: ParsedArgumentResult = {
        modname = "",
    }

    for _, arg in parsedArgs.args do
        if argmap[arg.name] then
            argmap[arg.name](output, arg.values, arg.short)
        end
    end

    return output
end

return parseArguments