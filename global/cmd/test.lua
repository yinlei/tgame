-------------------------------------------------------------------------------
-- register_service.lua
-------------------------------------------------------------------------------
local world = require "world"
local service = require "service"

local INFO_MSG = tengine.INFO_MSG

local  _M = {}

function _M.command(a, b)
    INFO_MSG("do test ")
    return a+b
end

return _M