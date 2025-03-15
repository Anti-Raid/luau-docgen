--!strict

local types = require("types.luau")
local argparser = require("argparser.luau")
local tableext = require("table.luau")
local istatemod = require("istate.luau")
local typesetDocumentor = require("documentors/typeset.luau")

local globals: types.Globals = ... -- Passed as arguments
assert(globals, "No globals passed to documentor")

local p1 = tableext.extend({2}, {4})
assert(p1[1] == 2, "Inconsistent state: tableext.arrayextend failed to copy over 1")
assert(p1[2] == 4, "Inconsistent state: tableext.arrayextend failed to copy over 2")

-- Parse arguments at top-level
local md = argparser.parseArguments(globals)

-- Create istate
local istate: istatemod.IState = {
    globals = globals,
    md = md,
    plugin = istatemod.DefaultPlugin, 
}

-- Load the plugin if it exists
if md.plugin then
    istate.plugin = istatemod.loadPlugin(istate, md.plugin)
end

-- Before doing anything else, make sure we can safely require stuff
print("Running reqtest self-test for requires")
local a = require"reqtest/a.luau"
assert(a.a == 1) -- Ensure stable requires
print("Passed reqtest self-test for requires")

-- Read files, document and save

if #md.files == 0 then
    error("No files to document")
end

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