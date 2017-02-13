--------------------------------------------------------------------------------
-- init.lua
--------------------------------------------------------------------------------
local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local class = require "lib.middleclass"

local protocol = require "framework.protocol"

local _M = class("logic")

function _M:initialize(table, conf)
	self.__table = table

    -- 注册游戏协议
    protocol.register("protocol.pb", "apps/" .. conf.service)

    if type(self.on_initialize) == 'function' then
        self:on_initialize(table)
    end
end

--- 获取桌子
function _M:table()
    return self.__table
end

--- 逻辑消息
function _M:on_game_message(...)
    -- TODO
end

--- 游戏开始
function _M:on_game_start()
    -- TODO
end

--- 游戏结束
function _M:on_game_end()
    -- TODO
end

--- 游戏场景
function _M:on_game_scene()
    -- TODO
end

--- 玩家进入
function _M:on_player_enter(chairid, player)
    -- TODO
end

--- 玩家离开
function _M:on_player_left(chairid, player)
    -- TODO
end

--- 玩家坐下
function _M:on_player_sitdown(chairid, player, looker)
    -- TODO
end

--- 玩家起立
function _M:on_player_standup(chairid, player, looker)
    -- TODO
end

--- 玩家准备
function _M:on_player_ready(chairid, player, ...)
    -- TODO
end

return _M
