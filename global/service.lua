-------------------------------------------------------------------------------
-- service.lua
-------------------------------------------------------------------------------
local balance = tengine.balance

local _M = {}

local service_ids = {}
local balances = {}

function _M.register(type, service)
    local ids = service_ids[type] or {}
    local balance = balances[type] or balance:new()

    ids[#ids+1] = service
    balance:add(#ids)

    service_ids[type] = ids
    balances[type] = balance
end

function _M.low(type)
    local balance = balances[type]

    if not balance then
        return 0
    end

    local ids = service_ids[type]

    return ids[balance:min()]
end

function _M.random(type)
    local balance = balances[type]

    if not balance then
        return 0
    end

    return balance:random()
end

function _M.services(t)
    if type(t) == 'string' then
        return service_ids[t]
    else
        return service_ids
    end
end

function _M.info()
    -- body
end

return _M
