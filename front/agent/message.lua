--------------------------------------------------------------------------------
-- message.lua
--------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local table_insert, string_len = table.insert, string.len

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local protocol = require('framework.protocol')

local handlers = require("front.handler")

local _M = require (_PACKAGE.."/agent")

function _M:handler(data, size)
    local succ, type, name, message = protocol.decode(data, size)

    if not succ then
        ERROR_MSG(succ)
        return
    end

    local handler = handlers[name]
    if not handler then
        ERROR_MSG("can't find handler %s", name)
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

function _M:send(name, message)
    local listener = self.listener
    if listener then
        local buff = protocol.encode(name, message)
        listener:send(self.session, buff, string_len(buff))
    end
end