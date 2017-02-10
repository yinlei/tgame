-------------------------------------------------------------------------------
-- agent.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local _M = require (_PACKAGE.."/player")

function _M:agent()
    return self.__agent
end

function _M:set_agent(agent)
    self.__agent = agent
end

function _M:send(name, message)
    if self.__agent then
        self.__agent.send(name, message)
    end
end