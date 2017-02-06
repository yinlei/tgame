-------------------------------------------------------------------------------
-- action.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local table_insert, string_len = table.insert, string.len

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = require (_PACKAGE.."/table")

--- 起立
function _M:standup(player)

end

--- 旁观
function _M:lookon(chair, player)

end

--- 坐下
function _M:sitdown(chair, player, ...)

end

--- 准备
function _M:ready(chair, player)

end