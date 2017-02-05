--------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local manager = require("lib.object").manager

local  _M = {}

function _M.command(s)
    local id = s.id
    local entity = manager.entity(id)

    if not entity then
        ERROR_MSG("cann't find entity !!!")
        return
    end

    entity:on_get_game(s)
end

return _M
