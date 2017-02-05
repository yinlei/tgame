-------------------------------------------------------------------------------
-- wrap for c.mysql
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local setmetatable,string = setmetatable,string

local coroutine_running = coroutine.running
local coroutine_resume = coroutine.resume
local coroutine_yield = coroutine.yield

local c = tengine.c
local actor = tengine.actor

local query = function(self, ...)
    local mysql = self.mysql
    local co = coroutine_running()

    mysql:query(string.format(...), function(...)
        actor.suspend(co, coroutine_resume(co, ...))
    end)

    return coroutine_yield("CONTINUE")
end

local close = function(self)
    if self.mysql then
        self.mysql = nil
    end
end

local methods = {
    query = query,
    close = close,
}

local new = function(conf)
    local self = setmetatable({}, {__index = methods})

    self.mysql = c.mysql(conf)

    return self
end

return {
    new = new
}
