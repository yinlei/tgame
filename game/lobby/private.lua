--------------------------------------------------------------------------------
-- privatestate.lua
--------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = require (_PACKAGE.."/lobby"):addState('private')

function _M:enteredState(lobby)
    self.__lobby = lobby

    local _tables = lobby.__tables

    for i = 1, #_tables do

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

    self:join(player, _table)

    -- 生成房间号

    -- 下发消息
end

--- 加入房间
function _M:join(player, table)
end

