--!strict

local types = require("./types")

export type ParseContentsArg = {
    --- The file contents to parse
    ---
    --- If using full-moon, this should be a file://path
    --- If not using full-moon, this should be the raw contents of the file
    contents: string,
    --- Whether or not full moon is being used
    usefullmoon: boolean,
    --- Whether or not to include non-exported types
    includenonexportedtypes: boolean,
    --- Whether or not to error on unsupported types
    erroronunsupported: boolean,
    --- JSON parser
    json_parse: ((json: string) -> any)?,
    --- Run a command with args and stdin
    run: ((command: string, args: {string}) -> string)?,
    --- Returns if a file exists
    file_exists: ((path: string) -> boolean)?,
}

--- Parses the contents of a file and returns a typeset
local function parseContents(parseOpts: ParseContentsArg): types.ParseToTypeSetResponse
    -- Parse the file  
    local resultTab: types.ParseToTypeSetResponse
    if parseOpts.usefullmoon then 
        if not parseOpts.json_parse then 
            error("Process spawn operations not available. Cannot use full-moon extension.")
        end

        if not parseOpts.run then 
            error("Process spawn operations not available. Cannot use full-moon extension.")
        end

        for _, file in {"target/release/luau-docgen", "target/release/luau-docgen.exe", "target/debug/luau-docgen", "target/debug/luau-docgen.exe", "luau-docgen", "luau-docgen.exe"} do
            if parseOpts.file_exists and not parseOpts.file_exists(file) then
                continue
            end
            
            local jsonOut = parseOpts.run(file, {parseOpts.contents, tostring(parseOpts.includenonexportedtypes)})
            resultTab = parseOpts.json_parse(jsonOut)
            break
        end

        if not resultTab then
            error("Failed to parse contents with full-moon extension. No valid executable found.")
        end
    else     
        local parseContentsToTypeset = require("../contrib/luaup-parse/parse")             
        resultTab = parseContentsToTypeset(parseOpts.contents, parseOpts.includenonexportedtypes)    
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