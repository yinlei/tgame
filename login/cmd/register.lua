--------------------------------------------------------------------------------
-- register.lua
--------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local db = require "db"

local  _M = {}

function _M.register()
    -- 1. 查找玩家
    local ret = db.check_account(args.username)
    -- 如果失败直接返回
    if ret > 0 then
        return ret
    end

    return ret
end

return _M
