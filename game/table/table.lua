-------------------------------------------------------------------------------
-- table.lua
-------------------------------------------------------------------------------
local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local class = require "lib.middleclass"

local _M = class("table")

--- 初始化
function _M:initialize(id, ...)
    self.id = id
    
    self.players = {}

    self.logic = nil
end

--- 获取桌子编号
function _M:get_id()
    return self.id
end

--- 获取玩家数量
function _M:get_player_count()
end


return _M