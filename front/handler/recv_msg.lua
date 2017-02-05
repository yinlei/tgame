-------------------------------------------------------------------------------
-- recv_msg.lua
-------------------------------------------------------------------------------
local tostring = tostring

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local manager = require("lib.object").manager

local c2m_recv_msg = require("packet.c2m_recv_msg")

local _M = {
    ID = c2m_recv_msg.C_ID
}

function _M.handle(agent, message)
    p("recv_msg", message)

    agent.recv_msg_key = message.key
    agent.need_check_count = message.continuous_msg_count

    if agent.need_check_count == 0 then
        agent.need_check_count = 1
    end
end

return _M
