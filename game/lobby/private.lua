--------------------------------------------------------------------------------
-- privatestate.lua
--------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local ps = require("framework").player_status

local _M = require (_PACKAGE.."/lobby"):addState('private')

local tableinfo = {
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
    local _tableinfo = self:find_from_table(table)
    if not _tableinfo then
        return
    end

    _tableinfo.started = true
    _tableinfo.count = _tableinfo.count + 1

    --self:send_
end

--- 游戏结束
function _M:on_game_end(table, )
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

--- 