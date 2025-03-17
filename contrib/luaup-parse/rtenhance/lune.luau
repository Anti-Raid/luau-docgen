--!strict
local fs = require"@lune/fs"
local types = require"./types"

local fsOps: types.FsOps = {
    fs_readfile = function(path: string) 
        return fs.readFile(path)
    end,
    fs_writefile = function(path: string, contents: string) 
        return fs.writeFile(path, contents)
    end,
    fs_mkdirall = function(path: string, contents: string) 
        return fs.writeDir(path)
    end
}