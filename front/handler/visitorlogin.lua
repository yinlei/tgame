-------------------------------------------------------------------------------
-- login.lua
-------------------------------------------------------------------------------
local tostring = tostring

local actor = tengine.actor

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = {
    ID = 'VisitorLogin'
}

function _M.handle(agent, message)
    p("VisitorLogin", message)

    -- 直接转到login
    local _login = actor.sync("login")

    local ok, ret = _login.visitor_login(message)

    if not ok then
        error("VisitorLogin failed !!!")
        return
    end

    local LoginResult = {
        result = 'kLoginSuccess',
    }

    if not ret then
        ERROR_MSG("visitor login failed !!!")
        LoginResult.result = 'kLoginFailed'
        LoginResult.error = "account existed"
        agent:send("LoginResult", LoginResult)
        return
    end

    LoginResult.info = {}

    agent:send("LoginResult", LoginResult)
    -- 登录成功后直接进入大厅状态

    agent:attach_account(ret)

    INFO_MSG("visitor login ok ...")
end

return _M
