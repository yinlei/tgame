--------------------------------------------------------------------------------
-- server.lua
--------------------------------------------------------------------------------
local c 	= tengine.c
local actor = tengine.actor
local server = tengine.server

local agent = require "agent"

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local listener

local function command(command, ...)
    if type(command) ~= 'string' then
        ERROR_MSG("command is error !!!")
    end

    local f = assert(cmd[command])
    return f(...)
end

local function on_accept(session)
    DEBUG_MSG("on_accept session %d %d", session, agent.count())
    agent.new(listener, session)
end

local function on_read(session, data, size)
    DEBUG_MSG("on_read session %d data size %d %d", session, size, agent.count())
    local a = agent.find(session)
    if not a then
        ERROR_MSG("can't find agent !!!")
        return
    end

    a:handler(data, size)
end

local function on_closed(session, err)
    DEBUG_MSG("on_closed session %d, error %s %d", session, err, agent.count())
    local a = agent.find(session)
    if a then
        a:lost(session, err)
    end
end

local function listen(port)
    listener = server.new(port or 0, on_accept, on_read, on_closed)
    return listener
end

local function close(session)
    if not listener then
        return
    end

    listener:close(session)
end

local function address()
    if not listener then
        return
    end

    return listener:localaddress()
end

return {
    listen = listen,
    address = address,
    close = close,
}
