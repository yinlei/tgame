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
local c2m_move = require("packet.c2m_move")
local c2m_move_end = require("packet.c2m_move_end")
local c2m_recv_msg = require("packet.c2m_recv_msg")

local m2c_recv_msg_key = require("packet.m2c_recv_msg_key")

local handlers = require("gate.handler")

local agents = {}

local no_need_check_key_ids = {
    [c2m_ask_login.C_ID] = 1, 
    [c2m_ask_ping.C_ID] = 1,
    [c2m_move.C_ID] = 1,
    [c2m_move_end.C_ID] = 1,
    [c2m_recv_msg.C_ID] = 1,
}

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

    if not no_need_check_key_ids[id] then
        self.need_check_count = self.need_check_count - 1
        if self.need_check_count <= 0 then
            self.need_check_count = 0
            self:update_key()
            do_hander()
            self.recv_msg_key = 0
        end
    else
        do_hander()
    end
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

    if self.object then
        self.object:on_client_lost()
    end
end

local bind = function(self, object)
    assert(object)
    self.object = object
end

local update_key = function(self)
    self.last_key = ((self.last_key + math.random(1, 500))%61007) + 1
    --DEBUG_MSG("update key %d", self.last_key)
    self:send(m2c_recv_msg_key, self.last_key)
end

local methods = {
    handler = handler,
    send = send,
    lost = lost,
    bind = bind,
    update_key = update_key,
}

local new = function(owner, session)
    local self = setmetatable({}, {__index=methods})
    self.owner = owner
    self.session = session
    self.last_key = math.random(100, 2000)
    self.recv_msg_key = 0
    self.need_check_count = 0

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
