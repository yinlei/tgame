-------------------------------------------------------------------------------
-- actor
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local setmetatable,error, tostring = setmetatable,error, tostring
local table_unpack = unpack or table.unpack

local coroutine = coroutine
local coroutine_create = coroutine.create
local coroutine_yield = coroutine.yield
local coroutine_resume = coroutine.resume
local coroutine_running = coroutine.running
local coroutine_wrap = coroutine.wrap

local cmsgpack = require "cmsgpack"
local c = require "tengine.c"

local pool = require(_PACKAGE .. "/pool")

local send = c.send
local pack = cmsgpack.pack
local unpack = cmsgpack.unpack

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local actor = {}

local session_to_coroutine = {}
local coroutine_to_session = {}
local coroutine_to_service = {}

local raw_callback

function actor.suspend(co, succ, command, ...)
    if not succ then
        error(debug.traceback(co, tostring(command)))
    end

    if command  == "RETURN" then
        local session = coroutine_to_session[co]
        local service = coroutine_to_service[co]
        local ret
        if session > 0 then
            ret = send(service, session, pack({...}))
        else
            -- for send don't return
        end

        actor.suspend(co, coroutine_resume(co, ret))
    elseif command == "CONTINUE" then
    else
    end
end

function actor.rpc(service, ...)
	local session = send(service, -1,  pack({...}))
    return session
end

function actor.send(service, ...)
	local session = send(service, -1,  pack({...}))
    return session
end

function actor.callback(service, callback, ...)
	local session = send(service, 0, pack({...}))

	if callback then
		local co = pool.new(callback)
		session_to_coroutine[session] = co
	end
end

function actor.call(service, ...)
    local thread = coroutine_running()

    actor.callback(service, function(...)
                       actor.suspend(thread, coroutine_resume(thread, ...))
    end, ...)

    return coroutine_yield("CALL")
end

function actor.ret(...)
    coroutine_yield("RETURN", ...)
end


local function callback(type, service, self, session, data)
    if type == 13 then
        local co = session_to_coroutine[session]
        if co then
            coroutine_resume(co, table_unpack(unpack(data)))
            session_to_coroutine[session] = nil
        end
    else
        if raw_callback then
            local co = pool.new(function(...)
                    local r = raw_callback(table_unpack(unpack(...)))
                    actor.ret(true, r)
            end)

            coroutine_to_service[co] = service
            coroutine_to_session[co] = session

            actor.suspend(co, coroutine_resume(co, data))
		end
    end

end

function actor.start(func)
	c.dispatch(callback)

	raw_callback = func
end

function actor.newservice(name)
	return c.start(name)
end

function actor.self()
    return __Service__
end

function actor.wrap(id)
    return setmetatable({}, {__index = function(t, key)
        local id = id
        local func = key
        return function(...)
            return actor.call(id, key, ...)
        end
    end})
end

function actor.sync(id)
    return setmetatable({}, {__index = function(t, key)
        local id = id
        local func = key
        return function(...)
            return actor.call(id, key, ...)
        end
    end})
end

function actor.async(id)
    return setmetatable({}, {__index = function(t, key)
        local id = id
        local func = key
        return function(...)
            return actor.send(id, key, ...)
        end
    end})
end

return actor
