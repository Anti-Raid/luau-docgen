--!strict

-- Forcefully drop typechecking for this require
local function requireNoTypecheck(path: string)
    return require(path) :: any
end


local cst = require("./luaup/lossless/cst")
local util = requireNoTypecheck("./luaup/lossless/util")

-- A hack to convert a statement to a string 
local function stmtToString(node: cst.Stat) 
    -- SAFETY: This is manually type checked
    local cst: cst.Cst = {
        block = {
            stats = {{node = node}}
        },
        eof = {
            kind = "eof",
            trivia = {},
            text = "",
            span = {
                x = 0,
                y = 0,
                z = 0,
            }
        }
    } :: any

    return util.tostring(cst)
end

-- A hack to convert an expression to a string
local function exprToString(node: cst.Expr): string
    -- Create a wrapper statement
    local wrapperStmt: cst.LastStat_Return = {
        kind = "return",
        return_tok = {
            kind = "return",
            text = "",
            span = {
                x = 0,
                y = 0,
                z = 0,
            },
            trivia = {},
        },
        exprs = {
            {
                node = node :: cst.Expr, 
                sep = {
                    kind = ",",
                    trivia = {},
                    text = ",",
                    span = {
                        x = 0,
                        y = 0,
                        z = 0,
                    }
                } :: cst.TokenKind<",">
            }     
        },
        sep = nil
    }

    -- SAFETY: This is manually type checked
    local cst: cst.Cst = {
        block = {
            stats = {},
            last_stat = {
                stat = wrapperStmt,
            }
        },
        eof = {
            kind = "eof",
            trivia = {},
            text = "",
            span = {
                x = 0,
                y = 0,
                z = 0,
            }
        }
    } :: any

    return util.tostring(cst) :: string
end

return {
    stmtToString = stmtToString,
    exprToString = exprToString,
}