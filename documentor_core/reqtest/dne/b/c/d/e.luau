local f = require"./f"
local ok, _ = pcall(require, "../f")
assert(not ok, "Should not be able to require a module from a parent directory")
assert(f.f == 8)
return {e = 5}