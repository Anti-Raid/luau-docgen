--- My favorite type
export type a = typeof(setmetatable({} :: {
  nanos: number
}, {} :: {
   __add: (a: a, a: a) -> a
}))