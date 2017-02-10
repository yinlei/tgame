--------------------------------------------------------------------------------
-- agent
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local table_length = table.length

local agent = require(_PACKAGE.."/agent")
require(_PACKAGE .. "/account")
require(_PACKAGE .. "/message")

-- 状态
require(_PACKAGE .. "/login")
require(_PACKAGE .. "/lobby")

local agents = {}

local create = function(listener, session)
    local _agent = agent:new(listener, session)
    if not _agent then
        return nil
    end

    agents[session] = _agent

    --_agent:gotoState('login', _agent)

    return _agent
end

local destory = function(session)
    local agent = agents[session]
    if agent then
    end
    agents[session] = nil
end

local find = function(session)
    return agents[session]
end

local count = function()
    return table_length(agents)
end

return {
    create = create,
    destory = destory,
    
    find = find,
    count = count,
}
