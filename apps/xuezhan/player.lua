--------------------------------------------------------------------------------
-- player.lua
--------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local _M = {}

--- 玩家进入
function _M:on_player_enter(chair, player)

end

--- 玩家离开
function _M:on_player_left(chair, player)

end

--- 玩家坐下
function _M:on_player_sitdown(chair, player, looker)

end

--- 玩家起立
function _M:on_player_standup(chair, player, looker)

end

--- 玩家准备
function _M:on_player_ready(chair, player, ...)

end

--- 玩家掉线
function _M:on_player_offline(chair, player)

end

return _M