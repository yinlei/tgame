-------------------------------------------------------------------------------
-- create_gate.lua
-------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local service = require "service"

local  _M = {}

function _M.create_object_anywhere(name, ...)
    ERROR_MSG("create_object_anywhere")
    p(service.services("gate"))
    local id = service.low("gate")
    ERROR_MSG("create_object_anywhere name:%s %d", name, id)
    if id == 0 then
        return
    end

    local _gate = actor.sync(id)
    local succ, ret = _gate.create_object_anywhere(name, ...)
    if not succ or ret ~= 0 then
        ERROR_MSG("gate create_object_anywhere " .. name .. " failed !!!")
        return
    end

    return ret
end

function _M.create_object_from_name(flag, type, key, login)
    local id = service.low("gate")
    if id == 0 then
        ERROR_MSG("cann't find a gate !!!")
        return
    end

    local store = actor.sync("store")
    local succ, ret = store.create_object_from_name(id, flag, type, key, login)
    if not succ then
        ERROR_MSG("stroe create_object_from_name failed !!!")
        return
    end

    p("create_object_from_name", ret)

    return ret
end

return _M
