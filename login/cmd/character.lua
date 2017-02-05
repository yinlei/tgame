--------------------------------------------------------------------------------
-- character.lua
--------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local db = require "db"

local  _M = {}

-- 角色列表
function _M.character_list(src, args)
    local ret = db.get_character_list(args.username)

    return ret
end

-- 创建角色
function _M.create_character(args)
    return 0
end

-- 删除角色
function _M.delete_character(id)
    return 0
end

return _M
