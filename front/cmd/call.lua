--------------------------------------------------------------------------------
-- call.lua
--------------------------------------------------------------------------------
local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local agent = require('front.agent')

local  _M = {}

function _M.command(f, id, ...)

    local _agent = agent.find(id)

    if not _agent then
        ERROR_MSG("cann't find agent[%d] !!!", id)
        return
    end

    local func = _agent[f]
    if not func or type(func) ~= 'function' then
        ERROR_MSG("cann't find func[%s] !!!", f)
        return
    end
    p({...})
    return func(_agent, ...)
end

return _M
