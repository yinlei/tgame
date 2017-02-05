-------------------------------------------------------------------------------
-- chat.lua
-------------------------------------------------------------------------------
local tostring = tostring

local unpack = table.unpack or unpack

local string_len = string.len
local string_byte = string.byte
local string_sub = string.sub
local string_split = string.split

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local manager = require("lib.object").manager

local c2m_chat = require("packet.c2m_chat")

local _M = {
    ID = c2m_chat.C_ID
}

function _M.handle(agent, message)
    p("chat", message)

    local _object = agent.object
    if not _object then
        return
    end

    local content = message.chat_content
    if string_len(content) > 1 and string_byte("/") == string_byte(content) then
        -- GM
        local cmd = string_sub(content, 2)
        local args = string_split(cmd, " ")
        local ret = _object:execute(unpack(args))
        INFO_MSG("do GM execute %s", cmd)
        return
    end

    -- chat

    INFO_MSG("chat ok !!!")
end

return _M
