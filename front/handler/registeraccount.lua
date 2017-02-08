-------------------------------------------------------------------------------
-- login.lua
-------------------------------------------------------------------------------
local tostring = tostring

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = {
    ID = 'RegisterAccount'
}

function _M.handle(agent, message)
    p("RegisterAccount", message)

    -- 直接转到login
    local _login = actor.sync("login")

    local ok, ret = _login.register_account(message)

    if not ok or not ret then
        -- TODO 登录失败
        return
    end

    INFO_MSG("RegisterAccount ok !!!")
end

return _M
