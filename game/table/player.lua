-------------------------------------------------------------------------------
-- player.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local table_insert, string_len = table.insert, string.len

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local ps = require("framework").player_status

local _M = require (_PACKAGE.."/table")

--- 获取玩家
function _M:player(chair)
    return self.__players[chair]
end

--- 通过账号查找
function _M:find_player(id)
    -- 先查找游戏玩家
    for i = 1, self.__chair do
        local _player = self:player(i)
        if _player and _player:id() == id then
            return _player
        end
    end

    -- 再查找旁观玩家
    for _, v in ipairs(self.__watchers) do
        if v:id() == id then
            return v
        end
    end

    return nil
end

--- 获取玩家数量
function _M:player_count()
    local count = 0
    for i = 1, self.__chair do
        local _player = self:player(i)
        if _player then
            count = count + 1
        end
    end

    return count
end

--- 获取掉线玩家数量
function _M:offline_count()
    local count = 0

    for i = 1, self.__chair do
        if self.__offlinetimes[i] ~= 0 then
            count = count + 1
        end
    end

    return count
end

--- 玩家掉线
function _M:on_offline(player)
    if not player then return end
    
    local _player = self:player(player:chair())

    local _chair = player:chair()
    local _status = player:status()
    -- 如果不是旁观玩家
    if _status ~= ps.PLAYER_STATUS_LOOKON then
        if player ~= self:player(_chair) then
            return false
        end

        -- TODO 特殊处理

        if _status == ps.PLAYER_STATUS_PLAYING and 
            self.__offlinecounts[_chair] < _M.MAX_OFFLINE_COUNT then
                player:set_clientready(false)
                player:set_status(ps.PLAYER_STATUS_OFFLINE, self:id(), _chair)

                -- 通知逻辑层
                self.__logic:on_player_offline(_chair, player)
                
                -- 掉线处理
                if not self.__offlinetimes[_chair] then
                    local _count = self.__offlinecounts[_chair] or 0
                    self.__offlinecounts[_chair] = _count + 1
                    
                    self.__offlinetimes[_chair] = os.time()

                    --if self:

                end
        end
    end

    self:standup(player)

    player:set_status(ps.PLAYER_STATUS_NULL, 0, 0)

    return true
end