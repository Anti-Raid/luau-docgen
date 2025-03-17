--!strict

local pp = require("../../documentor_core/pp")
local parser = require("./luaup/lossless/parse")
local types = require("../../documentor_core/types")

local function parseContentsToTypeset(contents: string): types.TypeSet
    error("Cannot actually create typesets yet")
end

return parseContentsToTypeset