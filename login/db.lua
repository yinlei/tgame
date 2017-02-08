--------------------------------------------------------------------------------
-- db.lua
--------------------------------------------------------------------------------
local string_format = string.format

local redis = tengine.redis

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local account = require('framework.model.account')

local _M = {}

local db

function _M.init(conf)
    db = redis.new(conf.redis or 'redis')

    assert(db)
end

function _M.check_account(name)
    if not db then
        ERROR_MSG("db is invalid !!!")
        return
    end

    INFO_MSG("check account [%s] ...", name)

    local _account = account:with(db, "account", name)

    if not _account then
        return nil
    end

    return _account
end

function _M.register_account(info)
    
end

return _M
