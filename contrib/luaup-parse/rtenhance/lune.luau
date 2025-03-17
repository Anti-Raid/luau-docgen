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
    fs_mkdirall = function(path: string): ()
        return fs.writeDir(path)
    end,
    fs_rmdirall = function(path: string): ()
        local split = path:split("/")

        for i = 1, #split do
            local pathToRemove = table.concat(split, "/", 1, #split - i + 1)
            fs.removeDir(pathToRemove) -- Untested
        end
    end,
    fs_exists = function(path: string): boolean 
        return fs.isDir(path) or fs.isFile(path)
    end,
    fs_remove = function(path: string): boolean 
        if fs.isDir(path) or fs.isFile(path) then
            fs.removeFile(path)
            return true
        end

        return false
    end,
    fs_stat = function(path: string): types.FsStat
        local md = fs.metadata(path)
        
        if not md.exists then error(`Path {path} does not exist`) end

        return {
            is_dir = md.kind == "dir",
            is_file = md.kind == "file",
            size = 0, -- Not supported on lune
            modified = md.modifiedAt.unixTimestamp,
            created = md.createdAt.unixTimestamp,
            permissions_readonly = md.permissions.readOnly
        }
    end
}

local rte: types.RtEnhance = {
    kind = "lune",
    fsOps = fsOps,
    args = process.args
}

return rte