--------------------------------------------------------------------------------
-- db.lua
--------------------------------------------------------------------------------
local string_format = string.format

local redis = tengine.redis

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

-- local account = require "account"

local _M = {}

local db

function _M.init(conf)
    db = redis.new(conf.redis or 'redis')

    assert(db)
end

function _M.check_account(name)
    --[[
    if not db then
        ERROR_MSG("db is invalid !!!")
        return
    end
    --]]
    --[[
    local _account = account:with(db, "name", name)
    p(_account)
    if not _account then
        -- 创建
        local temp = {
            name = name,
            plat_account = "",
            create_time = os.time(),
        }

        local id = account:save(db, temp)
        p("id")
        p(id)
    end
    --]]
    return 0
end

return _M
