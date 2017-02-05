--------------------------------------------------------------------------------
-- register_globally.lua
--------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor
local timer = tengine.timer

local ERROR_MSG = tengine.ERROR_MSG
local DEBUG_MSG = tengine.DEBUG_MSG

local service_manager = require "service"
local world = require "world"

local  _M = {}

function _M.command(type, service)
    local object = world.get_global_object(type)

    if not object then
        world.add_global_object(type, service)

        local ss = service_manager.services("gate")
        for _, id in ipairs(ss) do
            local gate  = actor.sync(id)
            local succ, ret = gate.add_globalbase(type, service)
            if not succ or ret ~= 0 then
                ERRRO_MSG("add global " .. type .. " failed !!!")
            else
                DEBUG_MSG("add global " .. type .. " ok ...")
            end
        end

    end
    return 0
end

return _M
