--------------------------------------------------------------------------------
-- snapshot
--------------------------------------------------------------------------------
local table_remove = table.remove
local assert = assert

local snapshot = require "snapshot"

local snapshots = {}

local function make()
    snapshots[#snapshots + 1] = snapshot()

    while #snapshots > 2 do
        table_remove(snapshots, 1)
    end

end

local function check()
    assert(#snapshots >= 2, "Debug snapshot need least 2 snapshot")

    local s1 = snapshots[1]
    local s2 = snapshots[2]
    for k, v in ipairs(s2) do
        if s1[k] == nil then
            p(k, v)
        end
    end
end

return {
    make = make,
    check = check,
}
