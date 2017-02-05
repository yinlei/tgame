-------------------------------------------------------------------------------
-- wrap for c.http
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local coroutine_running = coroutine.running
local coroutine_resume = coroutine.resume
local coroutine_yield = coroutine.yield

local unpack = unpack or table.unpack

local c = tengine.c
local actor = tengine.actor
local http = c.http

local get = function(host, path, arg)
    local co = coroutine_running()

    http('get', host, path, arg, function(ret)
               actor.suspend(co, coroutine_resume(co, ret))
    end)

    return coroutine_yield("HTTP")
end

local post = function(host, path, arg)
    local co = coroutine_running()

    http('post', host, path, arg, function(ret)
               actor.suspend(co, coroutine_resume(co, ret))
    end)

    return coroutine_yield("HTTP")
end

return {
    get = get,
    post = post,
}
