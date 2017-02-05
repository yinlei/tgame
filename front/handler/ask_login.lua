-------------------------------------------------------------------------------
-- ask_login.lua
-------------------------------------------------------------------------------
local tostring = tostring

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local manager = require("lib.object").manager
local key = require("gate.core").key

local c2m_ask_login = require("packet.c2m_ask_login")
local m2c_ret_login = require("packet.m2c_ret_login")

local _M = {
    ID = c2m_ask_login.C_ID
}

function _M.handle(agent, message)
    p("ask_login", message)

    -- 客户端登陆验证
    local _key = key.get(tonumber(message.key))

    if not _key then
        ERROR_MSG("can't find login key !!!")
        agent:send(client_login, 1)
        return
    end

    local _object = manager.object(_key[4])
    if not _object then
        INFO_MSG("can't find object %d", _key[4])
        return
    end

    agent:bind(_object)

    _object:give_client(agent)

    -- 开始游戏
    local db_id = _key[2]
    local ret = _object:start_game(db_id)
    if not ret then
        ERROR_MSG("start game failed !!!")
        agent:send(m2c_ret_login, -1, 0, "", 0, 0, 0)
        return
    end

    agent:update_key()

    INFO_MSG("c2m_ask_login ok !!!")
end

return _M
