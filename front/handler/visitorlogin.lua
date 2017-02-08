-------------------------------------------------------------------------------
-- login.lua
-------------------------------------------------------------------------------
local tostring = tostring

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = {
    ID = 'VisitorLogin'
}

function _M.handle(agent, message)
    p("login", message)

    INFO_MSG("VisitorLogin ok !!!")
end

return _M
