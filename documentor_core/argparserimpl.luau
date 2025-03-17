--[[
    ArgParser: A simple argument parser for Lua
]]

--!strict

--- Contains a single parsed argument from globals.parsedocumentorargs
export type ParsedArg = {
    --- The name of the argument
    name: string,
    --- The values passed to the argument
    values: {string},
    --- Whether the argument is short (-a) or long (--abc) or a value (abc)
    arg_type: "Short" | "Long" | "Value",
}

--- Contains a parsed list of arguments from globals.parsedocumentorargs
export type ParsedArgs = {
    --- List of arguments (in order of appearance)
    args: {ParsedArg},

    --- Upsert an argument into the list of arguments
    upsert: (self: ParsedArgs, arg: ParsedArg) -> (),
}

local ParsedArg = {}
ParsedArg.__index = ParsedArg

--[[
    Creates a new ParsedArg
    @param name The name of the argument
    @param values The values passed to the argument
    @param arg_type The type of the argument (Short, Long, Value)
    @return A new ParsedArg
]]
function ParsedArg:new(name: string, values: {string}, arg_type: "Short" | "Long" | "Value"): ParsedArg
    self = setmetatable({}, ParsedArg)
    self.name = name
    self.values = values or {}
    self.arg_type = arg_type
    return self
end

--#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
local ParsedArgs = {}
ParsedArgs.__index = ParsedArgs

function ParsedArgs:new(): ParsedArgs
    self = setmetatable({}, ParsedArgs)
    self.args = {}
    return self :: ParsedArgs
end

-- Upsert an argument into the list of arguments
function ParsedArgs:upsert(arg: ParsedArg)
    for _, pot_arg in ipairs(self.args :: {string}) do
        if pot_arg.name == arg.name then
            for _, v in ipairs(arg.values) do
                table.insert(pot_arg.values, v)
            end
            return
        end
    end
    table.insert(self.args, arg)
end

-- Parses a list of arguments into a ParsedArgs structure
--
-- Note that repeated arguments are upserted into the same argument without duplication
function parsedocumentorargs(args: {string})
    local parsed_args = ParsedArgs:new()

    -- First normalize args with equal signs by splitting them into two
    local normalized_args: {string} = {} 
    for _, x in ipairs(args) do
        local s = tostring(x)
        local splits = string.split(s, "=")
        
        if #splits >= 2 then
            local name = splits[1]
            local value = table.concat(splits, "=", 2)
            -- Normalize the name to start with --
            if string.sub(name, 1, 2) == "--" then
                name = name
            else
                name = "--" .. name
            end
            table.insert(normalized_args, name)
            table.insert(normalized_args, value)
        else
            table.insert(normalized_args, s)
        end
    end

    local i = 1
    while i <= #normalized_args do
        local arg = normalized_args[i]

        -- Try for long argument first
        if string.sub(arg, 1, 2) == "--" then
            local arg_name = string.sub(arg, 3)
            local values = {}
            if i + 1 <= #normalized_args and string.sub(normalized_args[i + 1], 1, 1) ~= '-' then
                i = i + 1 :: any
                values = string.split(normalized_args[i], "=")
            end
            parsed_args:upsert(ParsedArg:new(arg_name, values, "Long"))
        elseif string.sub(arg, 1, 1) == "-" then
            local arg_name = string.sub(arg, 2)
            local values = {}
            if i + 1 <= #normalized_args and string.sub(normalized_args[i + 1], 1, 1) ~= '-' then
                i = i + 1
                values = string.split(normalized_args[i], "=")
            end
            parsed_args:upsert(ParsedArg:new(arg_name, values, "Short"))
        else
            parsed_args:upsert(ParsedArg:new(arg, {}, "Value"))
        end

        i = i + 1
    end

    return parsed_args
end

--[cfg(test)]
-- Tests module
local tests = {}

function tests.test_parse_args()
    --local pp = require("./pp")

    local args = {
        "--include-nonexported-types",
        "-e",
        "true",
        "--documentor",
        "documentor.luau",
        "-d",
        "true",
        "-e",
        "false",
        "helloworld",
        "cat=dog",
        "--cats=dog",
    }

    local parsed_args = parsedocumentorargs(args)

    --print(pp(parsed_args))

    assert(#parsed_args.args == 7, "Expected 7 arguments")

    assert(parsed_args.args[1].name == "include-nonexported-types", "arg 1 name mismatch")
    assert(#parsed_args.args[1].values == 0, "arg 1 values should be empty")
    assert(parsed_args.args[1].arg_type == "Long", "arg 1 type mismatch")

    assert(parsed_args.args[2].name == "e", "arg 2 name mismatch")
    do
        local expected = {"true", "false"}
        assert(#parsed_args.args[2].values == #expected, "arg 2 values length mismatch")
        for i, v in expected do
            assert(parsed_args.args[2].values[i] == v, "arg 2 value mismatch at index " .. tostring(i))
        end
    end
    assert(parsed_args.args[2].arg_type == "Short", "arg 2 type mismatch")

    assert(parsed_args.args[3].name == "documentor", "arg 3 name mismatch")
    do
        local expected = {"documentor.luau"}
        assert(#parsed_args.args[3].values == #expected, "arg 3 values length mismatch")
        for i, v in expected do
            assert(parsed_args.args[3].values[i] == v, "arg 3 value mismatch at index " .. tostring(i))
        end
    end
    assert(parsed_args.args[3].arg_type == "Long", "arg 3 type mismatch")

    assert(parsed_args.args[4].name == "d", "arg 4 name mismatch")
    do
        local expected = {"true"}
        assert(#parsed_args.args[4].values == #expected, "arg 4 values length mismatch")
        for i, v in expected do
            assert(parsed_args.args[4].values[i] == v, "arg 4 value mismatch at index " .. tostring(i))
        end
    end
    assert(parsed_args.args[4].arg_type == "Short", "arg 4 type mismatch")

    assert(parsed_args.args[5].name == "helloworld", "arg 5 name mismatch")
    assert(parsed_args.args[5].arg_type == "Value", "arg 5 type mismatch")

    assert(parsed_args.args[6].name == "cat", "arg 6 name mismatch")
    do
        local expected = {"dog"}
        assert(#parsed_args.args[6].values == #expected, "arg 6 values length mismatch")
        for i, v in expected do
            assert(parsed_args.args[6].values[i] == v, "arg 6 value mismatch at index " .. tostring(i))
        end
    end
    assert(parsed_args.args[6].arg_type == "Long", "arg 6 type mismatch")

    assert(parsed_args.args[7].name == "cats", "arg 7 name mismatch")
    do
        local expected = {"dog"}
        assert(#parsed_args.args[7].values == #expected, "arg 7 values length mismatch")
        for i, v in expected do
            assert(parsed_args.args[7].values[i] == v, "arg 7 value mismatch at index " .. tostring(i))
        end
    end
    assert(parsed_args.args[7].arg_type == "Long", "arg 7 type mismatch")

    local t2 = parsedocumentorargs({"--help", "-h"})

    --print(pp(t2))

    assert(#t2.args == 2, "Expected 2 arguments")
    assert(t2.args[1].name == "help", "arg 1 name mismatch")
    assert(#t2.args[1].values == 0, "arg 1 values should be empty")
    assert(t2.args[1].arg_type == "Long", "arg 1 type mismatch")

    assert(t2.args[2].name == "h", "arg 2 name mismatch")
    assert(#t2.args[2].values == 0, "arg 2 values should be empty")
    assert(t2.args[2].arg_type == "Short", "arg 2 type mismatch")
end

tests.test_parse_args()
--print("ArgParser: Power-on self test - All tests passed!")


return {
    parsedocumentorargs = parsedocumentorargs,
    ParsedArgs = ParsedArgs,
    ParsedArg = ParsedArg,
}