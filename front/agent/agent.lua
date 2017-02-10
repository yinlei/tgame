--------------------------------------------------------------------------------
-- agent.lua
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local class = require 'lib.middleclass'
local stateful = require 'lib.stateful'

local _M = class("agent")

_M:include(stateful)

function _M:initialize(listener, session)
    self.__session = session
    self.__listener = listener
end

function _M:session()
    return self.__session
end

function _M:listener()
    return self.__listener
end

function _M:client_address()
    if self.__listener then
        return self.__listener:remoteaddress(self.__session)
    end

    return ""
end

return _M

