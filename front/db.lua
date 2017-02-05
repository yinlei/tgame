--------------------------------------------------------------------------------
-- db.lua
--------------------------------------------------------------------------------
local string_format = string.format

local c = tengine.c
local redis = tengine.redis

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p


local define = require("lib.object").define
local manager = require("lib.object").manager
local store = require("lib.store")

local factory = require("gate.core").factory

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

function _M.create_object_with_key(type, key)
    local data, model = _M.data(type, key)

    local object
    if data and model then
        local db_id = data.id
        data.id = nil

        local id = 0
        object = factory.create_object_from_db_data(type, id, db_id, data, db, model)
    end

    if not object then
        ERROR_MSG("db create_object_with_key failed !!!")
    end

    return object
end

return _M
