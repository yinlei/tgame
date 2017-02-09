--------------------------------------------------------------------------------
-- privatestate.lua
--------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = require (_PACKAGE.."/lobby"):addState('private')

function _M:on_player_enter()
    
end

function _M:on_player_leave()
    
end

