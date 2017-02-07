--------------------------------------------------------------------------------
-- agent
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local table_length = table.length

local agent = require(_PACKAGE.."/agent")
require (_PACKAGE.."/message")

local agents = {}

local create = function(listener, session)
    return agent:new(listener, session)
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
