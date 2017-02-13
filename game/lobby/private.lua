--------------------------------------------------------------------------------
-- privatestate.lua
--------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local ps = require("framework").player_status
local gs = require("framework").game_status

local _M = require (_PACKAGE.."/lobby"):addState('private')

local tableinfo = {
    type = 0,
    creater = 1,
    number = 2,
    started = false,
    table = nil,
}

function _M:enteredState(lobby)
    self.__lobby = lobby

    self.__tableinfos = {}

    local _tables = lobby.__tables

    for i = 1, #_tables do
        local _info = {
            type = 0,
            creater = 0,
            nubmer = 0,
            started = false,
            inend = false,
            count = 0,
            table = _tables[i]
        }
        self.__tableinfos[i] = _info
    end

end

function _M:send_info(player, info)
end

function _M:clear(info)
    if not info then
        return
    end

    local _table = info.table

    if not _table then return end

    -- 该桌玩家全部离开
    for i = 1 , _table:chair() do
        local _player  = _table.player(i)
        if _player and _player:table() ~= 0 then
            _table:standup(_player)
        end
    end

    info:reset()
end

function _M:__dismiss(info)
    if not info then return end

    local _table = info.table
    if not _table then return end

    if info.started then
        -- TODO 通知游戏结束
    end

    -- 强制解散游戏
    if _table.__gamestarted then
        local ret = _table:dismiss_game()
        if not ret then
            return
        end
    end

    if info.started then
        info.inend = true
        info.creater = 0

        info.started = false
        self:send_info(nil, info)
    else
        self:clear(info)
    end
end

function _M:on_enter()
    p('private on_enter')
    return true
end

function _M:after_enter()
    p("private after_enter")
end

function _M:on_leave()
    
end

--- 游戏开始
function _M:on_game_start(table)
    local _info = self:find_from_table(table)
    if not _info then
        return
    end

    _info.started = true
    _info.count = _info.count + 1

    self:send_info(nil, _info)
end

--- 游戏结束
function _M:on_game_end(table, chair, player, code)
    if not table then
        return false
    end

    local _info = self:find_from_table(table)
    if not _info then
        return true
    end

    if _info.type == TYPE_PRIVATE then

    elseif _info.type == TYPE_PUBLIC then
    end
end

--- 用户进去游戏
function _M:on_game_ready(chair, player)
    if not player then
        return
    end

    local _info = self:find_from_table(player:table())
    if not _info then
        return
    end

    self:send_info(player, _info)

    local _table = _info.table

    if _info.table:status() == gs.GAEM_STATUS_FREE then
        player:set_status(ps.PLAYER_STATUS_READY, _table:id(), chair)
    end

    -- TODO
end

--- 通过房间号获取房间信息
function _M:find_from_number(number)
    for _, info in ipairs(self.__tableinfos) do
        if info.number == number then
            return info
        end
    end

    return nil
end

--- 通过桌子获取房间信息
function _M:find_from_table(table)
    for _, info in ipairs(self.__tableinfos) do
        if info.table == table then
            return info
        end
    end

    return nil
end

--- 创建私人场
function _M:create(player, args)    
    -- 房卡是否足够

    -- 寻找桌子
    local _tables = self.__lobby.__tables
    local _table
    for _, v in ipairs(_tables) do
        if v:chair_count() == v:free_count() then
            _table = v
            break
        end
    end

    if not _table then
    end

    if not self:join(player, _table) then
        player:send_system_message("房间创建失败 !!!")
        return
    end
    -- 生成房间号
    local _number = 1000 + math.rand() % 8900
    while self:find_from_number(_number) do
        _number = 1000 + math.rand() % 8900
    end

    -- 回复客户端创建成功
    local CreatePrivateGameResponse = {
        number = _number
    }
    player:send("CreatePrivateGameResponse", CreatePrivateGameResponse)

    -- 发送桌子信息
    
end

--- 加入房间
function _M:join(player, table)
    local _id
    for i = 1, table:chair() do
        if table:player(i) == player then
            _id = i
            break
        end
    end
    -- 更新玩家状态
    if _id then
        player:set_status(ps.PLAYER_STATUS_READY, table:id(), _id)
        return true
    end
    -- 寻找桌位
    for i = 1, table:chair() do
        if not table:player(i) then
            _id = i
            break
        end
    end

    if _id then
        if player:table() ~= 0 then
            return player:table() == table:id()
        end
        if not table:sitdown(id, player) then
            return false
        end
        -- 更新玩家状态
        player:set_status(ps.PLAYER_STATUS_READY, table:id(), _id)
        return true
    end

    return false
end

--- 解散
function _M:dismiss(player, ...)
    if not player then
        return false
    end

    local _info = self:find_from_table(player:table())
    if not _info then
        return false
    end

    if not _info.started and _info.creater ~= player:id() then
        return true
    end

    if _info.inend then
        return true
    end
    
end

--- 玩家断线
function _M:on_player_offline(chair, player)
    if not player then
        return false
    end

    local _info = self:find_from_table(player:table())
    if not _info then
        return false
    end

    if _info.creater == player:id() and not _info.inend then
        return true
    end

    if _info.inend then
        _info.table:standup(player)
    end

    return true
end

--- 玩家坐下
function _M:on_player_sitdown(table, chair, player, watcher)
    return
end

--- 玩家起立
function _M:on_player_standup(table, chair, player, watcher)
    return
end

--- 玩家准备
function _M:on_player_ready(table, chair, player, ...)
    if not player then
        return true
    end

    local _info = self:find_from_table(player:table())
    if not _info then
        return true
    end

    if _info.inend then
        return false
    end

    return true
end