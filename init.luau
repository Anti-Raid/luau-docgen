--!optimize 2
--!strict

-- Pure luau variant of the Rust full-moon based documentor
--local args: any = ...

local documentor = require("./documentor_core/documentor")
local getrt = require("./documentor_core/rtenhance/getrt")

local globals = getrt()

if globals.runtime == "UnknownRt" then 
    print("Warning: Unknown runtime used, filesystem operations may not be available") 
end

return documentor(globals)
