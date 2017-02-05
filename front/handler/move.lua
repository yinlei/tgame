-------------------------------------------------------------------------------
-- move.lua
-------------------------------------------------------------------------------
local tostring = tostring

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local manager = require("lib.object").manager

local c2m_move = require("packet.c2m_move")

local _M = {
    ID = c2m_move.C_ID
}

function _M.handle(agent, message)
    p("move", message)

    local _object = agent.object
    if not _object then
        return
    end

    local dst_pos = message.dst_pos

    _object:move(message.direction, dst_pos.x, dst_pos.y, 0)

    INFO_MSG("move ok !!!")
end

return _M
