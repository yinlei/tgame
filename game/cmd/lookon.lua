-------------------------------------------------------------------------------
-- lookon.lua
-------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local player =  require('game.player')

local lobby = require('game.lobby')

local rpc = function()
end

local  _M = {}

function _M.command(id, agent, kind, info)
    --p("enter", id, agent, kind, info)

    return true
end

return _M
