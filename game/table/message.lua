-------------------------------------------------------------------------------
-- message.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local table_insert, string_len = table.insert, string.len

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = require (_PACKAGE.."/table")

--- 发送所有玩家的消息
function _M:send(chair, ...)
    if chair == 0 then

    else
        local _player = self:player(chair)
        if not _player then
        end
    end
end

--- 

--- 桌子状态
function _M:send_status()

end
