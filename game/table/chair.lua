-------------------------------------------------------------------------------
-- chair.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local table_insert, string_len = table.insert, string.len

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = require (_PACKAGE.."/table")

--- 获取椅子数
function _M:chair_count()
    return self.__chair
end

--- 获取空座位数
function _M:free_count()
    return self.__chair - tlen(self.__players)
end