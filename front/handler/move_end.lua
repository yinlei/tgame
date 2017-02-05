-------------------------------------------------------------------------------
-- move_end.lua
-------------------------------------------------------------------------------
local tostring = tostring

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local manager = require("lib.object").manager

local c2m_move_end = require("packet.c2m_move_end")

local _M = {
    ID = c2m_move_end.C_ID
}

function _M.handle(agent, message)
    p("move_end", message)

    local _object = agent.object
    if not _object then
        return
    end

    INFO_MSG("move_end ok !!!")
end

return _M
