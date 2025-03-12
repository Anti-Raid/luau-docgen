--!strict
export type array<T> = {T}
export type dictionary<T> = {[string]: T}

local function arraymap<A, B>(table: {A}, f: (A) -> B): {B}
    local new = {}

    for k, v in table do
        new[k] = f(v)
    end

    return new
end

local function map<K, A, B>(table: {[K]: A}, f: (A) -> B): {[K]: B}
    local new = {}

    for k, v in table do
        new[k] = f(v)
    end

    return new
end

local function filter<K, V>(table: {[K]: V}, predicate: (V) -> boolean): {[K]: V}
    local new = {}

    for k, v in table do
        if predicate(v) then
            new[k] = v
        end
    end

    return new
end

local function fold<K, V, A>(table: {[K]: V}, f: (A, V) -> A, initial: A): A
    local acc = initial

    for _, v in table do
        acc = f(acc, v)
    end

    return acc
end

--- Extends ``table`` with the contents of ``other`` returning ``table``
local function arrayextend<V>(target: {V}, ...: {V}): {V}
    for i, tab in ... do
        table.insert(target, tab)
    end

    return target
end

--- Extends ``target`` with the contents of ``other`` returning ``table``
local function extend<K, V>(target: {[K]: V}, ...: {[K]: V}): {[K]: V}
    for _, table in {...} do
        for k, v in table do
            target[k] = v
        end
    end

    return target
end

return table.freeze({
    -- std extension for table
    arraymap = arraymap,
    map = map,
    filter = filter,
    fold = fold,
    extend = extend,
    arrayextend = arrayextend,

    -- re-exports of the table library
    clear = table.clear,
    clone = table.clone,
    concat = table.concat,
    create = table.create,
    find = table.find,
    freeze = table.freeze,
    insert = table.insert,
    isfrozen = table.isfrozen,
    maxn = table.maxn,
    move = table.move,
    pack = table.pack,
    remove = table.remove,
    sort = table.sort,
    unpack = table.unpack,
})