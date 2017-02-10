-------------------------------------------------------------------------------
-- 登录
-------------------------------------------------------------------------------
local unpack = unpack or table.unpack

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local BT = require('lib/behaviourtree') 

local _M = BT.Task:new()

function _M:start(args)
    -- 登录
    --[[
    local LoginGameAccount = {
        version = 0,
        machine = "pc",
        account = 'test',
        password = 'test',
        flag = 0,
    }

    client:send('LoginGameAccount', LoginGameAccount)
    --]]

    -- 游客登陆
    local VisitorLogin = {
        face = 1,
        gender = 1,
        version = 0,
        flag = 0,
        name = 'test',
        password = 'test',
    }

    local client = args[2]

    client:send('VisitorLogin', VisitorLogin)    
end

function _M:run(args)
    if type(args) ~= 'table' then
        return
    end
    
    local action = args[1]
    local client = args[2]

    if action == 'net' then
        local name = args[3]
        local message = args[4]

        if message.result == 'kLoginSuccess' then
            INFO_MSG("login success ...")
            success()
        else
            ERROR_MSG("login failed ...")
            fail()
        end
    else
        running()
    end
end

function _M:finish()
    INFO_MSG("login finish ...")
end

return _M
