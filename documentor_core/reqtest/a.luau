local l = require"./b"
assert(l.b == 1)

-- Ensure caching behaviour
l.b = 2
local ll = require"./b"
assert(ll.b == 2)

ll.b = 3
local lll = require"./b"
assert(lll.b == 3)
assert(l.b == 3)

return {a=1}