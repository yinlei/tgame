--------------------------------------------------------------------------------
-- monitor
--------------------------------------------------------------------------------
local assert, type, tostring, setmetatable, collectgarbage, pairs =
    assert, type, tostring, setmetatable, collectgarbage, pairs
local string_format = string.format
local table_insert = table.insert
local table_concat = table.concat
local table_length = table.length

local mem_leak = {}

setmetatable(mem_leak, {__mode = "kv"})

local function add(name, t)
    assert(type(name) == "string", "Invalid parameters")

    local name = string_format("%s@%s", name, tostring(t))

    if mem_leak[name] == nil then
        mem_leak[name] = t
    end
end

local function report()
    local strs = {}

    collectgarbage("collect")
    collectgarbage("collect")

    table_insert(strs,
                 string_format("Memory leak monitoring, \nrightnow these table is still valid: %d", table_length(mem_leak)))

    for k, v in pairs(mem_leak) do
        table_insert(strs, string_format("   \n%s = %s", tostring(k), tostring(v)))
    end

    return table_concat(strs)
end

return {
    add = add,
    report = report,
}
