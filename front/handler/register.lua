-------------------------------------------------------------------------------
-- register.lua
-------------------------------------------------------------------------------
local tostring = tostring

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = {
    ID = 'RegisterAccount'
}

function _M.handle(agent, message)
    p("login", message)

    INFO_MSG("RegisterAccount ok !!!")
end

return _M
