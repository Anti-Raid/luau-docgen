--!strict

local types = require("./types")
local istatemod = require("./istate")

export type ParseContentsArg = {
    --- The file contents to parse
    contents: string,
    --- Whether or not full moon is being used
    useFullMoon: boolean,
    --- Whether or not to include non-exported types
    include_nonexported_types: boolean,
    --- Whether or not to error on unsupported types
    erroronunsupported: boolean,
    --- JSON parser
    json_parse: ((json: string) -> any)?,
    --- Run a command with args and stdin
    run: ((command: string, args: {string}, stdin: string?) -> string)?,
}

--- Parses the contents of a file and returns a typeset
local function parseContents(parseOpts: ParseContentsArg): types.ParseToTypeSetResponse
    -- Parse the file  
    local resultTab: types.ParseToTypeSetResponse
    if parseOpts.useFullMoon then 
        if not parseOpts.json_parse then 
            error("Process spawn operations not available. Cannot use full-moon extension.")
        end

        if not parseOpts.run then 
            error("Process spawn operations not available. Cannot use full-moon extension.")
        end

        for _, file in {"target/release/luau-docgen", "target/release/luau-docgen.exe", "target/debug/luau-docgen", "target/debug/luau-docgen.exe", "luau-docgen", "luau-docgen.exe"} do
            local jsonOut = parseOpts.run(file, {"-", tostring(parseOpts.include_nonexported_types)}, parseOpts.contents)
            resultTab = parseOpts.json_parse(jsonOut)
            break
        end
    else     
        local parseContentsToTypeset = require("../contrib/luaup-parse/parse")             
        resultTab = parseContentsToTypeset(parseOpts.contents, parseOpts.include_nonexported_types)    
    end

    if resultTab.unsupported_count > 0 and parseOpts.erroronunsupported then
        error("Error: Found " .. tostring(resultTab.unsupported_count) .. " unsupported types")
    elseif resultTab.unsupported_count > 0 then
        print("Warning: Found " .. tostring(resultTab.unsupported_count) .. " unsupported types")
    end

    return resultTab
end

return {
    parseContents = parseContents,
}