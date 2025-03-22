--!strict

local types = require("./types")
local argparser = require("./argparser")
local tableext = require("./table")
local istatemod = require("./istate")
local typesetDocumentor = require("./documentors/typeset")
local pp = require("./pp")

local function init(globals: types.Globals)
    print("Using runtime " .. globals.runtime .. " with args: " .. pp(globals.documentor_args))

    local p1 = tableext.extend({2}, {4})
    assert(p1[1] == 2, "Inconsistent state: tableext.arrayextend failed to copy over 1")
    assert(p1[2] == 4, "Inconsistent state: tableext.arrayextend failed to copy over 2")

    -- Parse arguments at top-level
    local md = argparser.parseArguments(globals)


    if #md.files == 0 then
        print("No files to document. Please provide at least one file.")
        md.help = true
    end

    if md.help then 
        print("Usage:")

        for name, opt in argparser.argmap do
            if opt.opts ~= "" then
                print("  --" .. name .. " " .. opt.opts .. ": " .. opt.description)
            else
                print("  --" .. name .. ": " .. opt.description)
            end 
        end

        return
    end

    -- Create istate
    local istate: istatemod.IState = {
        globals = globals,
        md = md,
        plugin = istatemod.DefaultPlugin, 
    }

    -- Load all plugins
    istate.plugin = istatemod.loadAllPlugins(istate, istate.md.plugins)
  
    -- Read files, document and save
    istate.plugin.onInitialize(istate) 

    for _, fileIn in md.files do  
        -- Parse the file  
        local resultTab: types.ParseToTypeSetResponse
        if md.useFullMoon then 
            if not globals.fs_ops then 
                error("Filesystem operations not available. Cannot use full-moon extension.")
            end 

            if not globals.proc_ops then 
                error("Process spawn operations not available. Cannot use full-moon extension.")
            end

            for _, file in {"target/release/luau-docgen", "target/release/luau-docgen.exe", "target/debug/luau-docgen", "target/debug/luau-docgen.exe", "luau-docgen", "luau-docgen.exe"} do
                if globals.fs_ops.fs_fileexists(file) then 
                    local jsonOut = globals.proc_ops.run(file, {"file://" .. fileIn, tostring(md.ignorenonexportedtypes)})
                    resultTab = globals.proc_ops.json_parse(jsonOut)
                    break
                end
            end
        else          
            local contents: string

            -- Check if the file starts with inline:
            if string.sub(fileIn, 1, 7) == "inline:" then
                contents = string.sub(fileIn, 8)
            else
                if not globals.fs_ops then 
                    error("Filesystem operations not available. Cannot read files")
                end
    
                contents = globals.fs_ops.fs_readfile(fileIn)
                if not contents then 
                    error("Failed to read file: " .. fileIn)
                end        
            end    
            
            resultTab = globals.parsetotypeset({
                contents = contents,
                include_nonexported_types = md.ignorenonexportedtypes
            })    
        end

        if resultTab.unsupported_count > 0 and md.erroronunsupported then
            error("Error: Found " .. tostring(resultTab.unsupported_count) .. " unsupported types")
        elseif resultTab.unsupported_count > 0 then
            print("Warning: Found " .. tostring(resultTab.unsupported_count) .. " unsupported types")
        end

        local ast = resultTab.typeset

        local documentedFile = typesetDocumentor.documentTypeSet(istate, ast)

        if md.output == "stdout" then
            print(documentedFile)
        else
            if not globals.fs_ops then 
                error("Filesystem operations not available. Cannot write files")
            end

            globals.fs_ops.fs_writefile(md.output, documentedFile)
        end
    end
end

return init