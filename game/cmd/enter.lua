-------------------------------------------------------------------------------
-- enter.lua
-------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local player =  require('game.player')

local lobby = require('game.lobby')

local  _M = {}

function _M.command(id, info)

    local _player = player.find(id)
    if not _player then
        ERROR_MSG("player has enter game !!!")
        return
    end

    _player = player.create(id, info)

    lobby.on_player_enter(_player)

    return true
end

return _M
