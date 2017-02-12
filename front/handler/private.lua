-------------------------------------------------------------------------------
-- private.lua
-------------------------------------------------------------------------------
local actor = tengine.actor

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = {
    ID = 'CreatePrivateGame'
}

function _M.handle(agent, message)
    p("CreatePrivateGame", message)

    local _account = agent:get_account()

    local _game = actor.sync("game")

    ok, ret = _game.create_private_game(_account, message)

    if not ok or not ret then
        ERROR_MSG("enter lobby failed !!!")
        return
    end

    INFO_MSG("CreatePrivateGame ok !!!")
end

function _M.JoinPrivateGame(agent, message)
    p("JoinPrivateGame", message)

    local _account = agent:get_account()

    local _game = actor.sync("game")

    ok, ret = _game.join_private_game(_account, message)

    if not ok or not ret then
        ERROR_MSG("enter lobby failed !!!")
        return
    end

    INFO_MSG("JoinPrivateGame ok !!!")   
end

return _M
