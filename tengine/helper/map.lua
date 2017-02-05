--------------------------------------------------------------------------------
-- map
--------------------------------------------------------------------------------

local map = {}

--- size
local map_size = {}
setmetatable(map_size, {__mode = 'kv'})

function map:new()
    local o = {}
    setmetatable(o, {__index = map})
    map_size[o] = 0
    return o
end

--- 拷贝
function map:clone()
    local m = map:new()
    for k, v in pairs(self) do
        m:insert(k, v)
    end

    return m
end

--- 获取第一个
function map:begin()
    return self:next(nil)
end

--- 获取下一个元素
function map:next(k)
    local func, t = pairs(self)

    return func(t, k)
end

--- 插入元素 如果元素返回false
function map:insert(k, v)
    if not k or not v then
        return false
    end

    if self[k] then
        return false
    end

    map_size[self] = map_size[self] + 1
    self[k] = v
    return true
end

--- 更新或者插入新的元素
function map:replace(k, v)
    if not k or not v then
        return false
    end

    if not self[k] then
        map_size[self] = map_size[self] + 1
    end

    self[k] = v

    return true
end

--- 删除
function map:erase(k)
    if not self[k] then
        return false
    end

    self[k] = nil

    map_size[self] = map_size[self] - 1

    return true
end

--- 获取元素数量
function map:size()
    return map_size[self]
end

--- 是否空
function map:empty()
    return map_size[self] == 0
end

--- 清空
function map:clear()
    self = map:new()
end

--- 查找元素
function map:find(k)
    return self[k]
end

return map
