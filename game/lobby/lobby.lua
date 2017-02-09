--------------------------------------------------------------------------------
-- lobby.lua
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local actor = tengine.actor

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local table = require('game.table')

local class = require 'lib.middleclass'
local stateful = require 'lib.stateful'

local _M = class("lobby")

_M:include(stateful)

function _M:initialize()
    self.tables = {}
    INFO_MSG("lobby initialize ok ...")
end

function _M:get_conf()
    return self.__conf
end

function _M:get_option()
    return self.__option
end

function _M:on_player_enter(kind, player)
    -- TODO
    return true
end

function _M.on_player_leave(player)
    
end

return _M
