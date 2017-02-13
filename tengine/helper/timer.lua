--------------------------------------------------------------------------------
--- timer.lua
--------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local c = tengine.c
local now = c.now
local timer = tengine.timer
local priority_queue = require (_PACKAGE.."/priority_queue")

local function _compare(t1, t2)
    return t1.timeout < t2.timeout
end

local function _update(self)
    if self.stop > 0 then
        return
    end

    local now_tick = now()

    while self:min() ~= 0 and self:min() <= now_tick do
        local t = self:pop()

        if not self.deleted[t.id] then

            local ret, err = pcall(t.f, t.id, table.unpack(t.args))
            if not ret then
                ERROR_MSG(err)
            end

            t.do_count = t.do_count + 1

            if t.count > 0 and t.count ~= t.do_count then
                t.timeout = now() + t.interval

                self:insert(t)
            end

            if t.count == 0 then
                t.timeout = now() + t.interval
                self:insert(t)
            end
        end
    end

    timer.callback(self.interval, _update, self)
end

local add = function(self, start, interval, count, f, ...)
    if start <= 0 then
        return 0
    end

    if type(f) ~= "function" then
        return 0
    end

    self.id = self.id + 1

    count = count or 1

    local t = {}
    t.id = self.id
    t.index = 0
    t.interval = interval
    t.count = count
    t.do_count = 0
    t.timeout = now() + start
    t.f = f
    t.args = {...}

    self:insert(t)

    return self.id
end

local del = function(self, id)
    self.deleted[id] = 1
end

local min = function(self)
    local  t = self.queue:peek()
    if t then
        return t.timeout
    end

    return 0
end

local insert = function(self, t)
    self.queue:equeue(t)
end

local pop = function(self)
    return self.queue:dequeue()
end

local stop = function(self)
    self.stop = 1
end

local methods = {
    add = add,
    del = del,
    min = min,
    insert = insert,
    pop = pop,
    stop = stop,
}

local new = function(t)
    local self = setmetatable({}, {__index = methods})
    self.queue = priority_queue.new(_compare)
    self.size = 0
    self.id = 0
    self.deleted = {}
    self.stop = 0
    self.interval = t
    timer.callback(t, _update, self)
    return self
end

return {
    new = new,
}