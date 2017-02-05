-------------------------------------------------------------------------------
-- wrap timer
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local coroutine_running = coroutine.running
local coroutine_resume = coroutine.resume
local coroutine_yield = coroutine.yield

local unpack = unpack or table.unpack

local c = tengine.c

local actor = tengine.actor
--local actor = require(_PACKAGE .. "/actor")
local co_pool = require(_PACKAGE .. "/pool")

local sleep = function(delay)
    local co = coroutine_running()

    c.timer(delay, function()
        actor.suspend(co, coroutine_resume(co))
    end, true)

    return coroutine_yield("SLEEP")
end

local timeout = function(delay, func, ...)
    local args = {...}
    c.timer(delay, function()
                local co = co_pool.new(func)
                local succ, err = coroutine_resume(co, unpack(args))
                if not succ then
                    error(err)
                end
    end)
end

local callback = function(delay, func, ...)
    local co = co_pool.new(func)
    local args = {...}

    c.timer(delay, function()
        local succ, err = coroutine_resume(co, unpack(args))
        if not succ then
            error(err)
        end
    end, true)

end

local cancel = function()
end

return {
    sleep = sleep,
    timeout = timeout,
    callback = callback,
    cancel = cancel,
}
