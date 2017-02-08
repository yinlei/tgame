--------------------------------------------------------------------------------
-- lobby.lua
--------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local table = require('game.table')

local _M = {}

local gameconf = {
    game = 'xuezhan',
    table = 20,
    chair = 4,
}

function _M.init(self, conf)
    self.tables = {}

    for i = 1, gameconf.table do
        local _table = table:new(i, gameconf)
        self.tables[i] = _table
    end

    local _global = actor.sync("global")

    local succ, ret = _global.register_game(actor.self(), gameconf)
    if succ and ret == 0 then
        INFO_MSG("register to global success ...")
    else
        ERROR_MSG("register to global failed !!!")
    end
end

--- 创建桌子
function _M.create_table()
end

function _M.on_player_enter(player)
    -- TODO
end

function _M.on_player_leave(player)
    
end

return _M
