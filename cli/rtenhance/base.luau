--- Process op support (needed for accelerated/custom parser runtime support)
export type ProcOps = {
    --- Run a command and return the output
    run: (command: string, args: {string}, stdin: string?) -> string, -- returns the output of the command
    --- JSON parse a string
    json_parse: (json: string) -> any, -- returns the parsed JSON object
}

--- Filesystem operations
export type FsOps = {
    fs_readfile: (path: string) -> string, -- returns the contents of the file
    fs_writefile: (path: string, contents: string) -> (), -- writes the contents to the file
    fs_fileexists: (path: string) -> boolean, -- checks if the file exists
}

--- Globals
export type Globals = {
    --- Documentor args
    read documentor_args: {string},
    
    --- Parse to typeset
    parsetotypeset: (opts: ParseToTypeSetArgs) -> ParseToTypeSetResponse,

    runtime: string, -- Runtime being used
    fs_ops: FsOps?, -- filesystem operations
    proc_ops: ProcOps?, -- optional proc ops
}

return {}