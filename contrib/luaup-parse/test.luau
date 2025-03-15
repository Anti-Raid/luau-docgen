local args = ...
print(args)

local pp = require("./pp")
local parser = require("./luaup/lossless/parse")
local utils = require("./luaup/lossless/util")
local res = parser(args)

if not res.success then
    print("Failed to parse")
    print(res.error.message)
    print(res.error.span.x .. ":" .. res.error.span.y .. ":" .. res.error.span.z)
    print(string.sub(args, res.error.span.x - 10, res.error.span.y + 10))
else
    print("Parsed successfully")
    print(pp(res.cst))

    print(utils.tostring(res.cst))
end