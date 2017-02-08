-------------------------------------------------------------------------------
-- 登录
-------------------------------------------------------------------------------
local unpack = unpack or table.unpack

local BT = require('lib/behaviourtree') 

local _M = BT.Task:new()

function _M:start(client)
    -- 登录
    local LoginGameAccount = {
        version = 0,
        machine = "pc",
        account = 'test',
        password = 'test',
        flag = 0,
    }

    client:send('LoginGameAccount', LoginGameAccount)
end

function _M:run(args)
    if type(args) ~= 'table' then
        return
    end

    --local bot, packet, message = unpack(args)
    --fw.p(message)
    --[[
    if succ and ret == 1 then
        self:success()
    else
        self:fail()
        agent:send(packet, 1, 1)
    end
    --]]
end

function _M:finish()
    fw.p("finishhhhhhhhh")
end

return _M
