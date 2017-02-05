--------------------------------------------------------------------------------
-- coroutine pool
--------------------------------------------------------------------------------
local setmetatable, xpcall = setmetatable, xpcall
local table_remove = table.remove
local debug_traceback = debug.traceback
local coroutine_create = coroutine.create
local coroutine_yield = coroutine.yield
local coroutine_resume = coroutine.resume

local pool = setmetatable({}, {__mode= 'kv'})

local function co_create(f)
    local co = table_remove(pool)

    if co == nil then
        co = coroutine_create(function(...)
                xpcall(f, debug_traceback, ...)
                while true do
                    f = nil
                    pool[#pool + 1] = co
                    f = coroutine_yield()
                    xpcall(f, debug_traceback, coroutine_yield())
                end
        end)
    else
		local succ, err = coroutine_resume(co, f)
        if not succ then
            error(err)
        end
    end

    return co
end

return {
    new = co_create,
}
