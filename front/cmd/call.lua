--------------------------------------------------------------------------------
-- entity call
--------------------------------------------------------------------------------
local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local server = require "server"
-------------------------------------------------------------------------------
local  _M = {}

function _M.command(f, context, ...)
    local id = context.id or 0
    local _object = manager.get(id)

    if not _object then
        ERROR_MSG("cann't find object !!!")
        return
    end

    local func = _object[f]
    if not func or type(func) ~= 'function' then
        ERROR_MSG("cann't find func(%s) !!!", f)
        return
    end

    return func(_object, ...)
end

return _M
