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
    local err, type, name, message = protocol.decode(data, size)

    if err then
        ERROR_MSG(err)
        return
    end

    self:dispatch(name, message)
end

function _M:dispatch(name, message)
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
    --p("send", name, message)
    local listener = self.__listener
    if listener then
        local buff = protocol.encode(name, message)
        listener:send(self.__session, buff, string_len(buff))
    end
end