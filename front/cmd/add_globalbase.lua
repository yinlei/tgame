--------------------------------------------------------------------------------
-- add_global.lua
--------------------------------------------------------------------------------
local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local global = require("gate.core").global

local  _M = {}

function _M.command(type, object)
    p("add global ", type, object)
    global.add(type, object)

    return 0
end

return _M
