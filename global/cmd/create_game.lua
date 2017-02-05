--------------------------------------------------------------------------------
-- create_game.lua
--------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local service = require "service"

local  _M = {}

function _M.create_object_in_new_map(name, s, ...)
    p("create_object_in_new_map", name, s, ...)
    local id = service.low("game")
    if id == 0 then
        return
    end

    local _game = actor.sync(id)
    local succ, ret = _game.create_object_in_new_map(name, s, ...)
    if not succ then
        ERROR_MSG("global create_object_in_new_map failed !!! ")
        return
    end

    return ret
end

return _M
