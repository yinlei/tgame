-------------------------------------------------------------------------------
-- register_service.lua
-------------------------------------------------------------------------------
local world = require "world"
local service = require "service"

local INFO_MSG = tengine.INFO_MSG

local  _M = {}

function _M.command(type, id)
    service.register(type, id)

    INFO_MSG("registered service %s:%d", type, id)

    if type == 'gate' then
        world:trigger("register_service", type, id)
    end

    return 0
end

return _M
