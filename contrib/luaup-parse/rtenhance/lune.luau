--!strict
local fs = require"@lune/fs"
local process = require"@lune/process"
local types = require"./types"

local fsOps: types.FsOps = {
    fs_readfile = function(path: string): string
        return fs.readFile(path)
    end,
    fs_writefile = function(path: string, contents: string): ()
        return fs.writeFile(path, contents)
    end,
}

local rte: types.RtEnhance = {
    kind = "lune",
    fsOps = fsOps,
    args = process.args
}

return rte