--------------------------------------------------------------------------------
-- account.lua
--------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local table_insert, string_len = table.insert, string.len

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = require (_PACKAGE.."/agent")

function _M:attach_account(account)
    self.__account = account
end

function _M:get_accountinfo()
    return self.__account
end

function _M:get_account()
    return self.__account.id
end