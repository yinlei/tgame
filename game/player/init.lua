-------------------------------------------------------------------------------
-- player
-------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local pcall, assert, table_copy = pcall, assert, table.copy

local tlen = table.lenght

local actor = tengine.actor

local _M = require(_PACKAGE.."/player")
require(_PACKAGE.."/agent")

local players = {}

local function create(...)
    local _player = _M:new(...)
    if not _player then
        return
    end

    players[_player:id()] = _player

    return _player
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

local _call_meta = {}

_call_meta.__index = function(t, key)
	local context = t
	local f = key
	return function(...)
        local succ, ret =
            actor.call(context[1], "call", f, context[2], ...)

        return succ, ret
	end
end

_call_meta.__newindex = function(t, key, value)

end

local function proxy(service)
	local _service = table_copy(service)
	return setmetatable(_service, _call_meta)
end

return {
    create = create,
    destory = destory,
    find = find,
    proxy = proxy,
}