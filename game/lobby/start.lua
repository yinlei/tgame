--------------------------------------------------------------------------------
-- start.lua
--------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local actor = tengine.actor

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = require (_PACKAGE.."/lobby")

function _M:start(conf, option)
    self.__conf = conf
    self.__option = option

    p(self.__conf, self.__option)

    -- 创建桌子
    for i = 1, option.table do
        local _table = table:new(i, conf)
        self.__tables[i] = _table
    end

    self:gotoState('private', self)
    
    -- 注册全局
    local _global = actor.sync("global")

    local succ, ret = _global.register_game(actor.self(), conf, option)
    if succ and ret then
        INFO_MSG("register to global success ...")
    else
        ERROR_MSG("register to global failed !!!")
    end
end