-------------------------------------------------------------------------------
-- private.lua
-------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local player =  require('game.player')

local lobby = require('game.lobby')

local  _M = {}

function _M.create_private_game(id, args)
    local _player = player.find(id)

    if not _player then
        return
    end

    
end

return _M