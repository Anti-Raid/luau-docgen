local ok, _ = pcall(require, "./doesnotexist")
assert(not ok, "Should not be able to require a non-existent module")
ok, _ = pcall(require, "./dne/doesnotexist")
assert(not ok, "Should not be able to require a non-existent module")
ok, _ = pcall(require, "./dne/a")
assert(not ok, "Should not be able to require a module thats failed to load")
local d = require"./d"
assert(d.d == 3)
return {c=2}