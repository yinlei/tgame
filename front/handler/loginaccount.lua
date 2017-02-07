-------------------------------------------------------------------------------
-- login.lua
-------------------------------------------------------------------------------
local tostring = tostring

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = {
    ID = 'LoginGameAccount'
}

function _M.handle(agent, message)
    p("login", message)

    INFO_MSG("LoginGameAccount ok !!!")
end

return _M
