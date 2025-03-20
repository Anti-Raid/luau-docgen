--!strict
local visit = require("./luaup/lossless/visit")

local parser = require("./luaup/lossless/parse")
local cst = require("./luaup/lossless/cst")
local types = require("../../documentor_core/types")
local parseimpl = require("./parseimpl") 

local function parseCst(cst: cst.Cst, include_unexported_types: boolean?): {
    unsupported_count: number, 
    typeset: types.TypeSet,
}
    local ts: types.TypeSet = {
        types = {}
    }
    local unsupported_count = 0
    local function_depth = 0

    local visitor = visit.visitor() 

    function visitor.visit_stat_function(_, node: cst.Stat_Function) 
        if function_depth > 0 then
            function_depth += 1
            return;
        end

        function_depth += 1
        
        --[[
        let comments = get_comments_from_token_ref(node.function_token());
        let node_names = node.name().to_string();
        let typ =
            self.create_type_from_function(comments, node_names, node.body(), FunctionType::Normal);
        ]]
        local comments: {string} = {}
        comments = parseimpl.extractcommentsfromtrivia(comments, node.function_tok.trivia)
        local names = {}
        for _, name in node.names do
            names[#names + 1] = name.node.text
        end

        local name = table.concat(names, ".")

        local ok, typ = pcall(parseimpl.create_type_from_function, comments, name, node.body, "Normal")

        if not ok then
            print("Failed to parse function " .. name)
            unsupported_count += 1
            return;
        end

        if typ then
            ts.types[#ts.types + 1] = {
                type = "Function",
                data = typ
            } :: any
        end
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

        local comments: {string} = {}
        comments = parseimpl.extractcommentsfromtrivia(comments, node.local_tok.trivia)
        local name = node.name.text

        local ok, typ = pcall(parseimpl.create_type_from_function, comments, name, node.body, "Local" :: any)

        if not ok then
            print("Failed to parse local function " .. name)
            unsupported_count += 1
            return;
        end

        if typ then
            ts.types[#ts.types + 1] = {
                type = "Function",
                data = typ
            } :: any
        end
    end

    function visitor.visit_stat_local_function_end(_, node: cst.Stat_LocalFunction) 
        function_depth -= 1
    end

    function visitor.visit_stat_type(_, node: cst.Stat_Type) 
        if function_depth > 0 then
            return -- Don't parse types inside functions
        end

        if not include_nonexported_types and not node.export_tok then
            return -- Don't parse non-exported types
        end

        local ok, typ = pcall(parseimpl.create_type_from_type_declaration, node)

        if not ok then
            print("Failed to parse type " .. node.name.text .. " " .. typ)
            unsupported_count += 1
            return;
        end

        if typ then
            ts.types[#ts.types + 1] = {
                type = "TypeDef",
                data = typ
            } :: any
        end
    end

    visit.visit(visitor, nil, cst)

    return {
        unsupported_count = unsupported_count,
        typeset = ts, 
    } 
end

local function parseContentsToTypeset(contents: string, include_nonexported_types: boolean?): {
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