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

-- 返回值说明
-- 0 成功
-- 1 账号检测失败
-- 2 账号被封停
-- 3 游戏中
-- 4 系统错误

function _M.login(src, args)
    -- 1. 查找玩家
    local ret = db.check_account(args.username)
    -- 如果失败直接返回
    if ret > 0 then
        return ret
    end



    return ret
end

return _M
