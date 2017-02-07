--------------------------------------------------------------------------------
-- agent.lua
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local class = require('lib.middleclass')

local _M = class("agent")

function _M:initialize(listener, session)
    self.session = session
    self.listener = listener
end

function _M:get_session()
    return self.session
end

function _M:get_listener()
    return self.listener
end

return _M

