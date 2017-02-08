-------------------------------------------------------------------------------
-- login.lua
-------------------------------------------------------------------------------
local tostring = tostring

local actor = tengine.actor
local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = {
    ID = 'LoginGameAccount'
}

function _M.handle(agent, message)
    p("LoginGameAccount", message)
    -- TODO 版本检测
    
    -- 直接转到login
    local _login = actor.sync("login")

    local ok, ret = _login.login_account(message)

    if not ok or not ret then
        -- TODO 登录失败
        INFO_MSG("LoginGameAccount failed !!!")
        return
    end

    -- TODO 

    INFO_MSG("LoginGameAccount ok !!!")
end

return _M
