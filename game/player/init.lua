-------------------------------------------------------------------------------
-- player
-------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local tlen = table.lenght

local _M = require(_PACKAGE.."/player")

local players = {}

local function create(...)
    local _player = _M:new(...)
    if not _player then
        return
    end
end

local function destory(id)
    players[id] = nil
end

local function find(id)
    return players[id]
end

local function count()
    return tlen(players)
end

return {
    create = create,
    destory = destory,
    find = find,
}