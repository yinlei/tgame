-------------------------------------------------------------------------------
-- enter.lua
-------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local player =  require('game.player')

local lobby = require('game.lobby')

local  _M = {}

function _M.command(id, agent, kind)
    -- 大厅类型是否一致
    if lobby:get_option().kind ~= kind then
        ERROR_MSG("lobby kind failed !!!")
        return
    end
    -- TODO 检测版本

    -- 玩家处理
    local _player = player.find(id)
    if not _player then
        ERROR_MSG("player has enter game !!!")
        -- TODO 是否掉线重入
        return
    end

    return lobby:on_player_enter(id)
end

return _M
