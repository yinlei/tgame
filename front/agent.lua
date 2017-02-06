--------------------------------------------------------------------------------
-- agent.lua
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local require, setmetatable, pcall = require, setmetatable, pcall

local string_pack = string.pack
local string_unpack = string.unpack
local string_len = string.len

local table_length = table.length

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local packets = require("packet")

local c2m_ask_login = require("packet.c2m_ask_login")
local c2m_ask_ping = require("packet.c2m_ask_ping")

local handlers = require("gate.handler")

local agents = {}

local handler = function(self, data, size)
    local id, pos = string_unpack('>H', data)
    local packet = packets[id]
    if not packet then
        ERROR_MSG("can't find packet %d", id)
        return
    end

    local succ, message = pcall(packet.decode, data:sub(pos, size), size)
    if not succ then
        ERROR_MSG(message)
        return
    end

    local handler = handlers[id]
    if not handler then
        ERROR_MSG("can't find handler %d", id)
        return
    end

    local do_hander = function()
        local succ, ret = pcall(handler.handle, self, message)
        if not succ then
            ERROR_MSG(ret)
        end
    end

    do_hander()
end

local send = function(self, packet, ...)
    if self.owner then
        local buff = string_pack('>H', packet.S_ID) .. packet.encode(...)
        self.owner:send(self.session, buff, string_len(buff))
    end
end

local lost = function(self, session, err)
    INFO_MSG("agent lost err %s", err)

    agents[session] = nil
end

local methods = {
    handler = handler,
    send = send,
    lost = lost,
}

local new = function(owner, session)
    local self = setmetatable({}, {__index=methods})
    self.owner = owner
    self.session = session

    agents[session] = self
    return self
end

local find = function(session)
    return agents[session]
end

local count = function()
    return table_length(agents)
end

return {
    new = new,
    find = find,
    count = count,
}
