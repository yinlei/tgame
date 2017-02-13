--------------------------------------------------------------------------------
-- game.lua
--------------------------------------------------------------------------------
local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local sm = require("framework").start_mode

local _M = {}

--- 游戏状态

function _M:on_initialize(table)
    -- 初始化
    self.__game_type = 0
    self.__table:set_startmode(sm.START_MODE_FULL_READY)

    return true
end

--- 游戏开始
function _M:on_game_start()
    -- 洗牌
    self.__dice = {}
end

--- 游戏结束
function _M:on_game_end()

end

--- 游戏场景
function _M:on_game_scene()

end

return _M
