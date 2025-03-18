-- Pure luau variant of the Rust full-moon based documentor
--!strict

local documentor = require("./documentor_core/documentor")
local types = require("./documentor_core/types")
local getrt = require("./contrib/luaup-parse/rtenhance/getrt")
local pp = require("./documentor_core/pp")
local parseContentsToTypeset = require("./contrib/luaup-parse/parse")

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
        return parseContentsToTypeset(opts.contents)
    end,
    --[[
    fs_readfile: (path: string) -> string, -- returns the contents of the file
    fs_writefile: (path: string, contents: string) -> (), -- writes the contents to the file
    fs_mkdirall: (path: string) -> (), -- creates the directory and all parent directories required
    fs_rmdirall: (path: string) -> (), -- removes the directory and all parent directories required
    fs_exists: (path: string) -> boolean, -- checks if the file exists
    fs_remove: (path: string) -> boolean, -- removes the file
    fs_stat: (path: string) -> {
    ]]
    fs_readfile = rtspecific.fsOps.fs_readfile,
    fs_writefile = rtspecific.fsOps.fs_writefile,
    fs_mkdirall = rtspecific.fsOps.fs_mkdirall,
    fs_rmdirall = rtspecific.fsOps.fs_rmdirall,
    fs_exists = rtspecific.fsOps.fs_exists,
    fs_remove = rtspecific.fsOps.fs_remove,
    fs_stat = rtspecific.fsOps.fs_stat
}

documentor(globals)