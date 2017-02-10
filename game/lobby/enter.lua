--------------------------------------------------------------------------------
-- enter.lua
--------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local player =  require('game.player')

local _M = require (_PACKAGE.."/lobby")

function _M:enter(id, agent, info)
    -- 是否被踢
    local kick_time = self.__kicks[id] or 0
    if (kick_time+3600) > os.time() then
        INFO_MSG("您已被管理员请出房间,1小时之内不能进入！")
        return
    else
        self.__kicks[id] = nil
    end

    -- TODO
    -- 大厅的限制判定(最低分 最高分 会员 满人)
    
    local _player = player.create(id, agent, info)

    if not _player then
        ERROR_MSG("create player failed !!!")
        return
    end

    -- 大厅配置
    local LobbyServerInfo = {
        table = self.__option.table,
        chair = self.__conf.chair,
        type = self.__option.type,
        rule = self.__option.rule,
    }

    _player:send("LobbyServerInfo", LobbyServerInfo)

    -- 玩家数据

    return _player
end