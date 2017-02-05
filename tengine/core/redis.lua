-------------------------------------------------------------------------------
-- wrap for c.redis
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local assert, pcall, setmetatable = assert, pcall, setmetatable
local table_insert = table.insert

local setmetatable,string = setmetatable,string

local coroutine_running = coroutine.running
local coroutine_resume = coroutine.resume
local coroutine_yield = coroutine.yield

local c = tengine.c
local actor = require(_PACKAGE .. "/actor")

--[[
local call = function(self, ...)
    assert(self.redis)

    local thread = coroutine.running()

    self.redis:call(function(...)
        actor.suspend(thread, coroutine.resume(thread, ...))
    end, ...)

    return coroutine.yield("CONTINUE")
end
--]]

local call = function(self, ...)
    assert(self.redis)

    local thread = coroutine_running()

    self.redis:callv(function(...)
                        actor.suspend(thread, coroutine_resume(thread, ...))
    end, ...)

    return coroutine_yield("CONTINUE")
end

local queue = function(self, ...)
    table_insert(self.buff, {...})
end

local commit = function(self, ...)
    assert(self.redis)

    if #self.buff == 0 then
        return true, {}
    end

    local thread = coroutine_running()

    self.redis:commit(function(...)
            actor.suspend(thread, coroutine_resume(thread, ...))
    end, self.buff)

    self.buff = {}

    return coroutine_yield("CONTINUE")
end

local quit = function(self)
    if self.redis then
        call(self, "QUIT")
        self.redis = nil
    end
end

local _wrap_in_pcall = function(...)
    local success, res, ret = pcall(...)
    if success then
        return ret, nil
    else
        return nil, res
    end
end

local methods = {
    call = function(self, ...)
        return _wrap_in_pcall(call, self, ...)
    end,

    queue = function(self, ...)
        return _wrap_in_pcall(queue, self, ...)
    end,

    commit = function(self, ...)
        return _wrap_in_pcall(commit, self, ...)
    end,

    quit = function(self, ...)
        return _wrap_in_call(quit, self, ...)
    end,
}

local new = function(conf)
    local self = setmetatable({}, {__index = methods})

    self.redis = c.redis(conf or 'redis')
    self.buff = {}

    return self
end

return {
    new = new
}
