-------------------------------------------------------------------------------
-- player.lua
-------------------------------------------------------------------------------
local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local class = require "lib.middleclass"

local _M = class("player")

function _M:initialize(id, agent, info)
    self.__id = id
    self.__account = info
    self.__agent = agent

    -- 桌子信息
    self.__table = 0
    self.__chair = 0
end

function _M:id()
    return self.__id
end

function _M:table()
    return self.__table
end

function _M:set_table(table)
    self.__table = table
end

function _M:chair()
    return self.__chair
end

function _M:set_chair(chair)
    self.__chair = chair
end

return _M