-------------------------------------------------------------------------------
-- entity_call.lua
-------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local manager = require ("lib.object").manager

local  _M = {}

function _M.command(func, service, ...)

    local id = service.id
    local _object = manager.get(id)
 
    if not _object then
        ERROR_MSG("cann't find object !!!")
    end

    local f = assert(_object[func])
     
    return f(_object, ...)
end

return _M
