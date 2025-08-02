local argparser = require("./argparser")
local istatemod = require("../documentor_core/istate")
local markdownDocumentor = require("../documentor_core/generators/markdown/typeset")
local typeparser = require("../documentor_core/typeparser")
local types = require("./rtenhance/base")

local function cli(globals: types.Globals) 
    -- Parse arguments at top-level
    local md = argparser.parseArguments(globals.documentor_args)

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
        ignorenondoc = md.ignorenondoc,
        plugin = istatemod.DefaultPlugin, 
    }

    -- Load all plugins
    istate.plugin = istatemod.loadAllPlugins(istate, md.plugins)
  
    -- Initialize the plugin system
    istate.plugin.onInitialize(istate) 

    --- Document the typeset
    for _, file in md.files do
        local contents = globals.fs_ops.fs_readfile(file)
        if not contents then
            error("Failed to read file: " .. file)
        end

        local data = typeparser.parseContents({
            contents = contents,
            useFullMoon = md.useFullMoon,
            include_nonexported_types = md.include_nonexported_types,
            erroronunsupported = md.erroronunsupported,
            json_parse = if globals.proc_ops then globals.proc_ops.json_parse else nil,
            run = if globals.proc_ops then globals.proc_ops.run else nil,
        })

        local ast = data.typeset
        local output = markdownDocumentor.documentTypeSet(istate, ast, md.modname)

        if md.output == "stdout" then
            print(output)
        end

        globals.fs_ops.fs_writefile(md.output, output)
        print("Documentation generated successfully at " .. md.output)
    end
end

return cli