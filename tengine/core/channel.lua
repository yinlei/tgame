-------------------------------------------------------------------------------
-- wrap for c.channel
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local assert, type, setmetatable, string = assert, type, setmetatable, string
local coroutine_running = coroutine.running
local coroutine_resume = coroutine.resume
local coroutine_yield = coroutine.yield

local c = tengine.c

local actor = require(_PACKAGE .. "/actor")
local co_pool = require(_PACKAGE .. "/pool")

local close = function(self)
    if self.channel then
        self.channel:close()
    end
end

local send = function(self, data, size)
    if self.channel then
        self.channel:send(data, size)
    end
end

local methods = {
    send = send,
    close = close,
}

local connect = function(address, read, closed)
    assert(type(address) == 'string', "channel address type error")
    assert(type(read) == "function" and type(closed) == 'function', "channel param error")

    local address = string.split(address, ":")

    local co = coroutine_running()

    local self = setmetatable({}, {__index = methods})

    local channel

    channel = c.channel(address[1], tonumber(address[2]), {
                                  on_connected = function()
                                      self.channel = channel
                                      actor.suspend(co, coroutine_resume(co, self, nil))
                                  end,

                                  on_read = function(data, size)
                                      local co = co_pool.new(read)
                                      local succ, err = coroutine_resume(co, data, size)
                                      if not succ then
                                          error(err)
                                      end
                                  end,

                                  on_closed = function(err)
                                      if not self.channel then
                                          actor.suspend(co, coroutine_resume(co, nil, err))
                                      else
                                          local co = co_pool.new(closed)
                                          local succ, myerr = coroutine_resume(co, err)
                                          if not succ then
                                              error(myerr)
                                              self.channel = nil
                                          end

                                          self.channel = nil
                                      end
                                  end
     })

     return coroutine_yield("CHANNEL")
end

return {
    connect = connect
}
