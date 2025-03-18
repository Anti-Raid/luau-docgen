--!strict

local types = require("./types")
local argparser = require("./argparser")
local tableext = require("./table")
local istatemod = require("./istate")
local typesetDocumentor = require("./documentors/typeset")

local function init(globals: types.Globals)
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
 
    -- Before doing anything else, make sure we can safely require stuff
    print("Running reqtest self-test for requires")
    local a = require"./reqtest/a"
    assert(a.a == 1) -- Ensure stable requires
    print("Passed reqtest self-test for requires")
 
    -- Read files, document and save
    istate.plugin.onInitialize(istate) 

    for _, fileIn in md.files do 
        local contents = globals.fs_readfile(fileIn)
        if not contents then 
            error("Failed to read file: " .. fileIn)
        end 
    
        -- Parse the file  
        local resultTab = globals.parsetotypeset({
            contents = contents,
            include_nonexported_types = md.ignorenonexportedtypes
        })

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
            globals.fs_writefile(md.output, documentedFile)
        end
    end
end

return init