--------------------------------------------------------------------------------
-- state.lua
--------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local table_insert, string_len = table.insert, string.len

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local handlers = require("front.handler")

local agent = require (_PACKAGE.."/agent")

local _M = agent:addState('login')

function _M:enteredState(owner)
    p('enteredState')
    self.__owner = owner
end

function _M:dispatch(name, message)
    p("login state ", name, message)
end

