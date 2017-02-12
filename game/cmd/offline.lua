-------------------------------------------------------------------------------
-- enter.lua
-------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local ps = require("framework").player_status

local player =  require('game.player')

local lobby = require('game.lobby')

local  _M = {}

function _M.command(account)
    local _player = player.find(account)
    if _player then
        return
    end

    local _table_id = player:table()
    if _table_id ~= 0 then
        local _table = lobby:table(_table_id)
        if _table then
            _table:on_offline(player)
        end
    else
        _player:set_status(ps.PLAYER_STATUS_NULL, 0, 0)
    end

end

return _M
