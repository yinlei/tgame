-------------------------------------------------------------------------------
-- table.lua
-------------------------------------------------------------------------------
local tlen = table.lenght

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local class = require "lib.middleclass"

local _M = class("table")

--- 初始化
function _M:initialize(id, conf)
    self.__id = id

    if not conf.chair then
        error('conf no chair count !!!')
    end
    
    self.__chair = conf.chair
    
    self.__players = {}

    self.__logic = require('apps.'.. conf.service):new(self)

    INFO_MSG("table[%d] initialize ok ...", id)
end

--- 获取桌子编号
function _M:id()
    return self.__id
end

--- 获取椅子数
function _M:chair_count()
    return self.__chair
end

--- 获取玩家数量
function _M:get_player_count()

end

--- 获取空座位数
function _M:get_free_count()
    return self.__chair - tlen(self.__players)
end

return _M