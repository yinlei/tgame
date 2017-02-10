-------------------------------------------------------------------------------
-- enterlobby.lua
-------------------------------------------------------------------------------
local actor = tengine.actor

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = {
    ID = 'EnterLobby'
}

function _M.handle(agent, message)
    p("EnterLobby", message)

    local kind = message.kind

    -- 获取指定游戏服务
    local _global = actor.sync("global")
    local ok, ret = _global.query(kind)
    
    --if not ok or not ret then
    --   ERROR_MSG("query game[%d] service failed !!!", kind)
    --    return
    --end

    -- 进入大厅
    local _game = actor.sync("game")

    local _account = agent:get_account()

    local _agent = {actor.self(), agent:session(), agent:client_address()}

    ok, ret = _game.enter(_account, _agent, kind, agent:get_accountinfo())

    if not ok or not ret then
        ERROR_MSG("enter lobby failed !!!")
        return
    end

    INFO_MSG("EnterLobby ok !!!")
end

return _M
