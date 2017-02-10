--------------------------------------------------------------------------------
-- login.lua
--------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local account = require('framework.model.account')

local db = require "db"

local  _M = {}

function _M.login_account(info)
    -- 1. 查找玩家
    local succ, ret = pcall(db.check_account, info.account)

    if not succ then
        ERROR_MSG("db check account failed !!! %s", succ)
        return
    end
    
    -- 如果失败直接返回
    if not ret then
        return
    end

    return ret
end

-- 游客登陆
function _M.visitor_login(message)
    p("visitor_login", message)

    local _driver = db.driver()

    message.account = "dotest"

    local _account = account:with(_driver, "account", 'dotest')
    if _account then
        return
    end

    local id = assert(account:save(_driver, message))

    _account = account:fetch(_driver, id)

    return _account
end

return _M
