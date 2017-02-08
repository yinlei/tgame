--------------------------------------------------------------------------------
-- login.lua
--------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local db = require "db"
-------------------------------------------------------------------------------
local  _M = {}

function _M.login_account(info)
    -- 1. 查找玩家
    local succ, ret = pcall(db.check_account, info.account)

    if not succ then
        ERROR_MSG("db check account failed !!! %s", succ)
        return
    end
    
    -- 如果失败直接返回
    if not ret then
        return
    end

    return ret
end

return _M
