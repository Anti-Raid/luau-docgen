--!strict

--- This file is automatically generated. Do not edit it manually.
--- Edit at your own risk
--Comment here
export type a = {
  --- A
  b: number,

  --- B
  ---
  --- @field a Number of times to call ourselves
  c: (self: a, a: number) -> a,
  [string]: a,

  --- C
  d: <T>(self: a, a: number, b: string, c: a) -> (),

  --- A table
  a: {string}
}

--Comment here
local function foo(a, b: number) 
  local function shouldNotBeDocumented() 
    function shouldAlsoNotBeDocumentedI() end
  end

  function shouldAlsoNotBeDocumented() end

  export type abc = {
    c: "A",
    b: number
  } | {
    c: "B",
    d: string
  }
end

local function bar(a: string, b: number) 
  function shouldAlsoNotBeDocumented() end
end

-- Meow
---@field a Input string
---@field b Number of times to call ourselves
---@returns 1 sa String
---@returns 2 ri Numberz
local function baz(a: string, b: {number}): (string, number) return "", 0 end

local b = ""
for i = 1, 10 do 
  b = b .. tostring(i) .. "test"
end

type A = {
  c: "A",
  b: number
} | {
  c: "B",
  d: string
}

local b: {A} = {}
b[#b + 1] = {
  c = "A",
  b = 1,
} -- ok

if 1 == 0 then
b[#b + 1] = {
  c = "B",
  d = "n"
}
end