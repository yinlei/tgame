-------------------------------------------------------------------------------
-- leave.lua
-------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local player =  require('game.player')

local lobby = require('game.lobby')

local  _M = {}

function _M.command(id)
    local _player = player.find(id)

    if not _player then
        return
    end

    lobby.on_player_leave(_player)
end

return _M