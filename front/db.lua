--------------------------------------------------------------------------------
-- db.lua
--------------------------------------------------------------------------------
local string_format = string.format

local c = tengine.c
local redis = tengine.redis

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local store = require("lib.store")

local _M = {}

local db

function _M.init(conf)
    db = redis.new(conf.redis or 'redis')

    if not db then
        ERROR_MSG("create db failed !!!")
    end
end

function _M.driver()
    return db
end

function _M.data(name, key)
    local _define = define.get(name)

    if not _define then
        ERROR_MSG("cann't find define %s", type)
        return
    end

    local model = store.model(name, _define)

    if not model then
        ERROR_MSG("cann't get %s model !!!", name)
        return
    end

    local data = model:fetch(db, tostring(key))

    -- p("db data", name, key,  data)

    return data, model
end


return _M
