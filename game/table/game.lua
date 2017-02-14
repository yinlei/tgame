-------------------------------------------------------------------------------
-- game.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local table_insert, string_len = table.insert, string.len

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local sm = require("framework").start_mode
local ps = require("framework").player_status

local _M = require (_PACKAGE.."/table")

--- 开始游戏
function _M:start_game()
    if self.__roundstarted then return false end

    local _gamestarted = self.__gamestarted
    local _tablestarted = self.__tablestarted

    self.__gamestarted = true
    self.__roundstarted = true
    self.__tablestarted = true

    if not _gamestarted then
        self.__offlinecounts = {}
        self.__offlinetimes = {}

        for i = 1, self.__chair do
            local _player  = self:player(i)
            if _player then
                -- 暂扣服务费用

                -- 设置玩家状态
                local _state = _player:status()
                if _state ~= ps.PLAYER_STATUS_OFFLINE and 
                    _state ~= ps.PLAYER_STATUS_PLAYING then
                    _player:set_status(ps.PLAYER_STATUS_PLAYING, self:id(), i)
                end
            end
        end

        -- 发送桌子状态
        if _tablestarted ~= self.__tablestarted then
            self:send_status()
        end
    end

    -- 状态机
    local ok = self:on_game_start()

    -- 逻辑
    if self.__logic and ok then
        self.__logic:on_game_start()
    end
end

--- 解散游戏
function _M:dismiss_game()
    -- 游戏还没开始
    if  not self.__tablestarted then return false end

    if self.__gamestarted and not self.__logic:on_game_end(0, nil, nil) then
        return false
    end

    -- 更新状态
    if not self.__gamestarted and self.__tablestarted then
        self.__tablestarted = false
        self:send_status()
    end
end

--- 结束游戏
function _M:end_game(status)
    if not self.__gamestarted then return false end

    local _roundstarted = self.__roundstarted

    self.__roundstarted = false

    self.__gamestatus = status

    -- TODO游戏记录

    -- 游戏结束处理
    if not self.__gamestarted then
        for i = 1, self.__chair do
            local _player  = self:player(i)
            if _player then
                -- 更新游戏结束时间
                _player.__endgame_time = os.time()

                -- TODO解锁游戏币

                -- 处理掉线玩家
                if _player:status() == ps.PLAYER_STATUS_OFFLINE then
  
                end
                
                _player:set_status(ps.PLAYER_STATUS_SITDOWN, self:id(), i);
            end
        end
    end

    -- 状态机处理
    self:on_game_end(self, 0, nil, status)
    
    -- 逻辑处理

    -- 处理是否要踢出不符合条件的玩家
    if not self.__gamestarted then
         for i = 1, self.__chair do
            local _player  = self:player(i)
            if _player then
                  
            end
        end       
    end

    self:end_table()

    -- 更新状态
    self:send_status()
end

--- 结束桌子
function _M:end_table()
    if not self.__gamestarted and self.__tablestarted then
        local _playercount =  self:player_count()
        if _playercount == 0 then self.__tablestarted = false end


        if self.__startmode == sm.START_MODE_ALL_READY or
            self.__startmode == sm.START_MODE_FULL_READY or
            self.__startmode == sm.START_MODE_PAIR_READY then
            self.__tablestarted = false
        end
    end

    return true
end