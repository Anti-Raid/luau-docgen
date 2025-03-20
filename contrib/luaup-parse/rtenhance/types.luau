export type FsOps = {
    --- Filesystem operations
    fs_readfile: (path: string) -> string, -- returns the contents of the file
    fs_writefile: (path: string, contents: string) -> (), -- writes the contents to the file
}

export type RtEnhance = {
    kind: string,
    fsOps: FsOps,
    args: {string}
}

return {}