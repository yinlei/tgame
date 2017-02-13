-------------------------------------------------------------------------------
-- action.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local table_insert, string_len = table.insert, string.len

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = require (_PACKAGE.."/table")

--- 玩家起立
function _M:standup(player)
    if not player then return end

    local chair = player:chair()

    
end

--- 玩家旁观
function _M:lookon(chair, player)

end

--- 玩家坐下
function _M:sitdown(chair, player, ...)
    if not player then return false end
    if chair < self.__chair then return false end

    if player:table() ~= 0 or player:chair() ~= 0 then 
        return false 
    end

    if self.__gamestart then 
        return false
    end

    local _player = self:player(chair)

    -- 如果给定的座位有人 重新查找新的位置
    if _player then
        for i = 1, self.__chair do
            if not self:player(i) then
                chair = i
                _player = nil
                break
            end
        end

        if _player then
            return false
        end
    end

    -- 是否有密码

    -- 一些检测

    -- 设置座位
    self.__players[chair] = player

    self.__loigc:on_sitdown()
end

--- 玩家准备
function _M:ready(chair, player)
    
end