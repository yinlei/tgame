--------------------------------------------------------------------------------
-- state.lua
--------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local player =  require('game.player')

local _M = require (_PACKAGE.."/lobby")

function _M:after_enter()
    _player = player.create(id, info)

    _player:set_session(session)
    _player:set_clientaddr(clientaddr)
    _player:set_activetime(os.time())
end