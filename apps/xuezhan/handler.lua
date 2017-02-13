--------------------------------------------------------------------------------
-- handler.lua
--------------------------------------------------------------------------------
local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local ps = require("framework").player_status

local _M = {}

--- 玩家出牌
function _M:C_OutCard(player, message)
    -- TODO 处理出牌
    if player:status() ~= ps.PLAYER_STATUS_PLAYING then
        return true
    end

    if self.__table:gamestatus() ~= self.class.GAME_STATUS_MJ_PLAY then
        return true
    end

    self.__table:destory_timer(self.__chupai_timer)

end

return _M