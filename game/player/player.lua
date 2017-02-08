-------------------------------------------------------------------------------
-- player.lua
-------------------------------------------------------------------------------
local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local class = require "lib.middleclass"

local _M = class("player")

function _M:initialize(...)
    self.id = 0
end

return _M