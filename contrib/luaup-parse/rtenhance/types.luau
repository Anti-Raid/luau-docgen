export type FsOps = {
    --- Filesystem operations
    fs_readfile: (path: string) -> string, -- returns the contents of the file
    fs_writefile: (path: string, contents: string) -> (), -- writes the contents to the file
    fs_mkdirall: (path: string) -> (), -- creates the directory and all parent directories required
    fs_rmdirall: (path: string) -> (), -- removes the directory and all parent directories required
    fs_exists: (path: string) -> boolean, -- checks if the file exists
    fs_remove: (path: string) -> boolean, -- removes the file
    fs_stat: (path: string) -> {
        is_dir: boolean,
        is_file: boolean,
        size: number,
        modified: number,
        created: number,
        permissions_readonly: boolean
    }, -- stats the file for info about it    
}

return ""