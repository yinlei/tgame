-------------------------------------------------------------------------------
-- enter.lua
-------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local player =  require('game.player')

local lobby = require('game.lobby')

local rpc = function()
end

local  _M = {}

function _M.command(id, agent, kind, info)
    --p("enter", id, agent, kind, info)

    id = tonumber(id)
    local _agent = player.proxy(agent)

    -- 大厅类型是否一致
    if lobby:get_option().kind ~= kind then
        ERROR_MSG("lobby kind failed !!!")
        return
    end
    -- TODO 检测版本

    -- 玩家处理
    local _player = player.find(id)
    if _player then
        ERROR_MSG("player has enter game !!!")
        -- TODO 是否掉线重入
        return
    end

    if not lobby:on_enter(id) then
        ERROR_MSG("player on_enter failed !!!")
        return
    end

    _player = lobby:enter(id, _agent, info)
    if not _player then
        ERROR_MSG("player enter failed !!!")
        return
    end

    lobby:after_enter(_player)

    return true
end

return _M
