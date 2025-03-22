--!strict
local fs = require"@lune/fs"
local process = require"@lune/process"
local serde = require"@lune/serde"
local types = require"../types"
local defaults = require"./defaults"

local fsOps: types.FsOps = {
    fs_readfile = function(path: string): string
        return fs.readFile(path)
    end,
    fs_writefile = function(path: string, contents: string): ()
        return fs.writeFile(path, contents)
    end,
    fs_fileexists = function(path: string): boolean
        local ok, res = pcall(fs.isFile, path)
        if not ok then
            return false
        end
        
        return res
    end
}

local procOps: types.ProcOps = {
    run = function(command: string, args: {string}): string
        local result = process.exec(command, args)
        if not result.ok then
            error("Failed to run " .. command .. "\n" .. result.stdout .. "\n" .. result.stderr)
        end
        print(result.stderr)
        return result.stdout
    end,
    json_parse = function(jsonStr: string): any
        local ok, result = pcall(serde.decode, "json", jsonStr)
        if not ok then
            error("Failed to parse JSON from process: " .. tostring(result))
        end
        return result
    end,
}

local globals: types.Globals = {
    runtime = "lune",
    fs_ops = fsOps,
    proc_ops = procOps,
    documentor_args = process.args,
    parsetotypeset = defaults.defaultParseToTypeSet,
}

return globals