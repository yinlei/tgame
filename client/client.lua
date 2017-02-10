--------------------------------------------------------------------------------
-- client
--------------------------------------------------------------------------------
local slen = string.len

local channel = tengine.channel

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local protocol = require('framework.protocol')

local behavior = require("client.behavior")

local connected = function(self)
    return self.channel ~= nil
end

local connect = function(self, address)
    local on_read = function(data, size)
        p("on_read", data, size)
        local err, type, name, message = protocol.decode(data, size)
        if err then
            ERROR_MSG(succ)
            return
        end
        p(name, message)
        self.behavior:run({'net', self, name, message})
    end

    local on_closed = function(err)
        self.channel  = nil
    end

    self.channel = channel.connect(address, on_read, on_closed)

    return self:connected()
end

local disconnect = function(self)
    if self.channel then
        self.channel:close()
        self.channel = nil
    end
end

local send = function(self, name, message)
    if self.channel then
        local buff = protocol.encode(name, message)
        self.channel:send(buff, slen(buff))
    end
end

local start = function(self, address)
    if not self:connect(address) then
        ERROR_MSG("client start failed !!!")
        return
    end

    self.behavior:run({'system', self})
end

local methods = {
    connect = connect,
    connected = connected,

    send = send,
    start = start,
}

local new = function(account, version)
    local self = setmetatable({}, {__index = methods})

    self.behavior = behavior.new()

    self.account = account

    self.version = version or 0

    return self
end

return {
    new = new
}
