--!strict

local types = require("./types")

local dummyFsOps: types.FsOps = {
    fs_readfile = function(path: string): string
        print("No runtime detected, using path as file to read")
        return path
    end,
    fs_writefile = function(path: string, contents: string): ()
        error("Cannot write to files without any known runtime")
    end,
    fs_mkdirall = function(path: string): ()
        error("Cannot write to files without any known runtime")
    end,
    fs_rmdirall = function(path: string): ()
        error("Cannot remove directories without any known runtime")
    end,
    fs_exists = function(path: string): boolean 
        return false
    end,
    fs_remove = function(path: string): boolean 
        return false
    end,
    fs_stat = function(path: string): types.FsStat
        return {
            is_dir = false,
            is_file = true,
            size = 0, -- Not supported on lune
            modified = 0,
            created = 0,
            permissions_readonly = false
        }
    end
}

local function getrt(): types.RtEnhance
    local isLune, _ = pcall(require, "@lune/fs")
    
    if isLune then 
        return require("./lune")
    end

    return {
        kind = "UnknownRt",
        fsOps = dummyFsOps,
        args = {}
    }
end

return getrt