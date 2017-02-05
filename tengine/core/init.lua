--------------------------------------------------------------------------------
-- core
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local require, xpcall, coroutine, debug = require, xpcall, coroutine, debug

local ERROR_MSG = tengine.ERROR_MSG

tengine = tengine or {}

--  coroutine start
tengine.start = function(f, ...)
	coroutine.wrap(function(...)
            local success, failure = xpcall(f, debug.traceback, ...)
            if not success then
                ERROR_MSG(failure)
            end
	end)(...)
end

-- coroutine wrap
tengine.wrap = function(f)
    return coroutine.wrap(function(...)
            local succ, err = xpcall(f, debug.traceback, ...)
            if not succ then
                ERROR_MSG(err)
            end
    end)
end

return {
    actor = require (_PACKAGE.."/actor"),
    server = require(_PACKAGE.."/server"),
    channel = require(_PACKAGE.."/channel"),
    http = require(_PACKAGE.."/http"),
    web = require(_PACKAGE.."/web"),
    mysql = require(_PACKAGE.."/mysql"),
    redis = require(_PACKAGE.."/redis"),
    timer = require(_PACKAGE.."/timer"),
    watcher = require(_PACKAGE.."/watcher"),
}
