--!strict
--- My favorite type
export type c<U, T = string> = {}

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

    --- Hello
    f: {
      -- World
      g: boolean
    },

    --- G
    h: string
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

--Comment here
local function test(a: a, b: number) end

-- Hello normal function
function a<T>() 
  if 1 == 1 then 
    return 1
  end
  return 2 + 2
end

local n: {
  {[string]: number}
} = {
  {
    a = 1
  },
  {
    b = 2
  }
}
