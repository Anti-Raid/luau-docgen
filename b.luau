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