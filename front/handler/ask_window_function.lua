-------------------------------------------------------------------------------
-- ask_window_function.lua
-------------------------------------------------------------------------------
local tostring = tostring

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local manager = require("lib.object").manager

local c2m_ask_window_function = require("packet.c2m_ask_window_function")

local window = require("gate.system").window

local _M = {
    ID = c2m_ask_window_function.C_ID
}

function _M.handle(agent, message)
    p("ask_window_function", message)

    local _object = agent.object
    if not _object then
        ERROR_MSG("ask_window_function object is nil !!!")
        return
    end

    window.execute(_object, message)

    INFO_MSG("ask_window_function ok !!!")
end

return _M
