--!strict

--- Helper function to parse anonymous argument data from converted comments
---
--- Used in function return values and unions
local function parseAnonymousArgData(
    defaultRetName: string,
    docsMap: {[string]: string}, 
    i: number
): (string, string)
    local retName: string = defaultRetName -- e.g. ret1 etc
    local retComment: string = ""

    local potComment: string? = nil

    if docsMap[tostring(i)] then 
        potComment = docsMap[tostring(i)]
    else
        -- Last chance, check if there is a single return comment
        local potRetName: string? = nil
        for k in pairs(docsMap) do 
            potRetName = k
            break
        end

        if potRetName then
            return potRetName, docsMap[potRetName]
        end
    end

    if potComment then 
        -- Split by space, first part is the name, second part is the comment
        local split = potComment:split(" ")
        if #split == 1 then
            retName = split[1]
        else
            retName = split[1]
            retComment = table.concat(split, " ", 2)
        end
    end 

    return retName, retComment
end

return {
    parseAnonymousArgData = parseAnonymousArgData
}