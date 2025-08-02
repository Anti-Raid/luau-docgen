local argparser = require("./argparser")
local istatemod = require("../documentor_core/generators/markdown/istate")
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
        local contents = if md.useFullMoon then `file://{file}` else globals.fs_ops.fs_readfile(file)

        local data = typeparser.parseContents({
            contents = contents,
            usefullmoon = md.useFullMoon,
            includenonexportedtypes = md.include_nonexported_types,
            erroronunsupported = md.erroronunsupported,
            json_parse = if globals.proc_ops then globals.proc_ops.json_parse else nil,
            run = if globals.proc_ops then globals.proc_ops.run else nil,
            file_exists = if globals.fs_ops then globals.fs_ops.fs_fileexists else nil,
        })

        local ast = data.typeset
        local output = markdownDocumentor.documentTypeSet(istate, ast, md.modname)

        if md.output == "stdout" then
            print(output)
        else 
            globals.fs_ops.fs_writefile(md.output, output)
            print("Documentation generated successfully at " .. md.output)        
        end
    end
end

return cli