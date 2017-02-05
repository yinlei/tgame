-------------------------------------------------------------------------------
-- wrap for c.web
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local string, setmetatable = string, setmetatable

local coroutine_running = coroutine.running
local coroutine_resume = coroutine.resume
local coroutine_yield = coroutine.yield

local c = tengine.c

local co_pool = require(_PACKAGE .. "/pool")

local get = function(self, path, handler)
    local _methods = self.router["GET"] or {}
    
    _methods[path] = handler

    self.router["GET"] = _methods
end

local post = function(self, path, handler)
    local _methods = self.router["POST"] or {}
    
    _methods[path] = handler

    self.router["POST"] = _methods
end

local handle = function(self, type, path, content)
    local handler = self.router[type][path]
    if handler then
        local succ, ret = pcall(handler, content)
        coroutine_yield(ret)
    end

    coroutine_yield('')
end

local methods = {
    get = get,
    post = post,
}

local new = function(port)
    local self = setmetatable({}, {__index = methods})

    self.port = port

    self.router = {}

    self.web = c.web()

    if self.web then
        self.web:start(port, function(type, path, content)
            local co = co_pool.new(handle)
            local succ, ret = coroutine_resume(co, self, type, path, content)
            if not succ then
                error(err)
            end

            return ret
        end)
    else
        error("create web failed !!!")
    end

    return self
end

return {
    new = new
}
