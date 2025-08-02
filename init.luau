--!optimize 2
--!strict

-- Pure luau variant of the Rust full-moon based documentor
--local args: any = ...

local getrt = require("@self/cli/rtenhance/getrt")
local cli = require("@self/cli/cli")

local globals = getrt()

if globals.runtime == "UnknownRt" then 
    print("Warning: Unknown runtime used, filesystem operations may not be available") 
end

return cli(globals)
