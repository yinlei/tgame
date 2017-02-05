-------------------------------------------------------------------------------
-- wrap for c.server
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local coroutine_running = coroutine.running
local coroutine_resume = coroutine.resume
local coroutine_yield = coroutine.yield

local string = string

local c = tengine.c

local co_pool = require(_PACKAGE .. "/pool")

local localaddress = function(self)
    if self.server then
        return self.server:localaddress()
    end

    return "unknown"
end

local remoteaddress = function(self, ...)
    if self.server then
        return self.server:remoteaddress(...)
    end

    return "unknown"
end

local send = function(self, ...)
    if self.server then
        self.server:send(...)
    end
end

local close = function(self, session)
    if self.server then
        self.server:close(session)
    end
end

local methods = {
    localaddress = localaddress,
    remoteaddress = remoteaddress,
    send = send,
    close = close,
}

local new = function(port, accept, read, closed)
    local self = setmetatable({}, {__index = methods})

    self.port = port

    self.server = c.server(port, {
        on_accept =
            function(session)
                local co = co_pool.new(accept)
                local succ, err = coroutine_resume(co, session)
                if not succ then
                    error(err)
                end

            end,

        on_read =
            function(session, data, size)
                local co = co_pool.new(read)
                local succ, err = coroutine_resume(co, session, data, size)
                if not succ then
                    error(err)
                end
            end,

        on_closed =
            function(session, err)
                local co = co_pool.new(closed)
                local succ, err = coroutine_resume(co, session, err)
                if not succ then
                    error(err)
                end
            end
    })

    return self
end

return {
    new = new
}
