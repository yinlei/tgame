-------------------------------------------------------------------------------
-- message.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local table_insert, string_len = table.insert, string.len

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = require (_PACKAGE.."/table")

---
