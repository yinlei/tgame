--------------------------------------------------------------------------------
-- register_globally.lua
--------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor
local timer = tengine.timer

local ERROR_MSG = tengine.ERROR_MSG
local DEBUG_MSG = tengine.DEBUG_MSG

local p = tengine.p

local service_manager = require "service"
local world = require "world"

local  _M = {}

function _M.command(sid, conf, option)
    return true
end

return _M
