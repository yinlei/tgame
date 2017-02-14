-------------------------------------------------------------------------------
-- check.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local table_insert, string_len = table.insert, string.len

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local sm = require("framework").start_mode
local ps = require("frmaework").player_status

local _M = require (_PACKAGE.."/table")

--- 检测开始游戏
function _M:check_startgame( ... )
    if self.__gamestarted then return false end

    if self.__startmode == sm.START_MODE_TIME_CONTROL then
        return false
    end

    if self.__startmode == sm.START_MODE_MASTER_CONTROL then
        return false
    end    

    local _ready_count = 0

    for i =1, self.__chair do
        local _player = self:player(i)
        if _player then
            if _player:status() ~= ps.PLAYER_STATUS_READY then
                return false
            end

            _ready_count = _ready_count + 1
        end
    end

    if self.__startmode == sm.START_MODE_ALL_READY then

    elseif self.__startmode == sm.START_MODE_FULL_READY then
    elseif self.__startmode == sm.START_MODE_PAIR_READY then
    else
        return false
    end
end

--- 客户端地址检测
function _M:check_clientaddress(player)

end

--- 积分检测
function _M:check_scorerule(player)

end