-------------------------------------------------------------------------------
-- game.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local table_insert, string_len = table.insert, string.len

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = require (_PACKAGE.."/table")

--- 开始游戏
function _M:start_game()

end

--- 解散游戏
function _M:dismiss_game()

end

--- 结束游戏
function _M:end_game()

end
