--- My favorite type
export type c = {}

-- Meow
export type a = typeof(setmetatable({} :: {
  -- Nanos
  nanos: number
}, {} :: {
    __add: (
        a: a, b: a
    ) -> a
}))

local function test(a: a, b: number) --[[Comment here]] end

-- Hello normal function
function a() end