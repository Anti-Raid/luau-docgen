--!strict
local types = require("./base")
local parseContentsToTypeset = require("../../contrib/luaup-parse/parse")

return {
    defaultParseToTypeSet = function(opts: types.ParseToTypeSetArgs): types.ParseToTypeSetResponse
        return parseContentsToTypeset(opts.contents, opts.include_nonexported_types)
    end,
}