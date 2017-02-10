--------------------------------------------------------------------------------
-- query.lua
--------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor
local timer = tengine.timer

local ERROR_MSG = tengine.ERROR_MSG
local DEBUG_MSG = tengine.DEBUG_MSG

local p = tengine.p

local service = require "service"

local  _M = {}

function _M.command(sid, conf, option)
    p("register game", sid, conf, option)
    return true
end

return _M
