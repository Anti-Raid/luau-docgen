--!strict
local visit = require("./luaup/lossless/visit")

local parser = require("./luaup/lossless/parse")
local cst = require("./luaup/lossless/cst")
local types = require("../../documentor_core/types")
local parseimpl = require("./parseimpl") 

local function parseCst(cst: cst.Cst): {
    unsupported_count: number, 
    typeset: types.TypeSet,
}
    local ts = parseimpl.TypeSet.new()
    local unsupported_count = 0 
    local function_depth = 0

    local visitor = visit.visitor()

    function visitor.visit_stat_function(_, node: cst.Stat_Function) 
        if function_depth > 0 then
            function_depth += 1
            return;
        end

        function_depth += 1
        
        --print(node.names)
    end

    function visitor.visit_stat_function_end(_, node: cst.Stat_Function) 
        function_depth -= 1
    end

    function visitor.visit_stat_local_function(_, node: cst.Stat_LocalFunction) 
        if function_depth > 0 then
            function_depth += 1
            return;
        end

        function_depth += 1
        
        print(node.name.text)
    end

    function visitor.visit_stat_local_function_end(_, node: cst.Stat_LocalFunction) 
        function_depth -= 1
    end

    visit.visit(visitor, nil, cst)

    return {
        unsupported_count = unsupported_count,
        typeset = ts, 
    } 
end

local function parseContentsToTypeset(contents: string): {
    unsupported_count: number,
    typeset: types.TypeSet,
} 
    local res = parser(contents)

    if not res.success then
        print("Failed to parse")
        print(res.error.message)
        print(tostring(res.error.span.x) .. ":" .. tostring(res.error.span.y) .. ":" .. tostring(res.error.span.z))
        print(string.sub(contents, res.error.span.x - 10, res.error.span.y + 10))
        error("Parse failed")
    end    

    if #res.cst.block.stats == 0 then
        error("No statements could be parsed from file")
    end

    return parseCst(res.cst)
end

return parseContentsToTypeset