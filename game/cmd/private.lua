-------------------------------------------------------------------------------
-- private.lua
-------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local player =  require('game.player')

local lobby = require('game.lobby')

local  _M = {}

function _M.create_private_game(id, ...)
    local _player = player.find(id)

    if not _player then
        return
    end

    
end

function _M.join_private_game(account, args)
    local _player = player.find(id)

    if not _player then
        return
    end

    local _tableinfo = lobby:find_from_number(args.number)
    if not _tableinfo then
        _player:send_system_message("对不起，没有找到该房间，可能房主已经退出。", 0)
        return
    end

    local _table = _tableinfo.table
    if not _table then
        return
    end

    if _table:free_count() <= 0 then
        _player:send_system_message("对不起，游戏人数已满，无法加入。", 0)
        return
    end

    if _tableinfo.started or _tableinfo.inend then
        _player:send_system_message("对不起，游戏已经开始，无法加入。", 0)
        return
    end

    if not lobby:join(_player, _table) then
        _player:send_system_message("加入房间失败。", 0)
    end
return _M