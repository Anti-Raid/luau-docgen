--- My favorite type
export type c = {}

-- Meow
export type a = typeof(setmetatable({} :: {
  -- Nanos
  nanos: number,
  -- Table
  a: {
    --- My favorite type
    b: string, 
    --- Meow
    c: string,
    d: string, 
    e: string,
  },

  -- Catnip
  __meow: string
}, {} :: {
    __add: (
        a: a, b: a
    ) -> a,
    __sub: (
        a: a, b: a
    ) -> a
}))

local function test(a: a, b: number) --[[Comment here]] end

-- Hello normal function
function a() end