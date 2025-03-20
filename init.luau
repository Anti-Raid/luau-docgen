--!optimize 2
--!strict

-- Pure luau variant of the Rust full-moon based documentor
local args: any = ...

local documentor = require("./documentor_core/documentor")
local types = require("./documentor_core/types")
local getrt = require("./contrib/luaup-parse/rtenhance/getrt")
local pp = require("./documentor_core/pp")
local parseContentsToTypeset = require("./contrib/luaup-parse/parse")

if type(args) == "userdata" and typeof(args) == "Globals" then
    return documentor(args) -- Fastpath is available
end

local rtspecific = getrt()

if rtspecific.kind == "UnknownRt" then 
    print("Warning: Unknown runtime used, filesystem operations may not be available")
else 
    print("Using runtime " .. rtspecific.kind .. " with args: " .. pp(rtspecific.args))
end

-- TODO: remove once stable
print("luaup (pure-luau docgen) is still a WIP, please run the Rust full-moon setup script instead.")

local globals: types.Globals = {
    documentor_args = rtspecific.args,
    require_builtins = true,
    parsetotypeset = function(opts: types.ParseToTypeSetArgs) : {
        unsupported_count: number,
        typeset: types.TypeSet,
    }
        return parseContentsToTypeset(opts.contents, opts.include_nonexported_types)
    end,
    fs_readfile = rtspecific.fsOps.fs_readfile,
    fs_writefile = rtspecific.fsOps.fs_writefile,
}

return documentor(globals)
