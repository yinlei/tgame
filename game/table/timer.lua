-------------------------------------------------------------------------------
-- timer.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local table_insert, string_len = table.insert, string.len

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = require (_PACKAGE.."/table")

--- 创建定时器
function _M:create_timer(interval, count, ...)
    local count = 1
    if interval > 0 then
        count = 0
    end

    _timer:add(interval, interval, count, ...)

    local timer_id = self:add_local_timer(start, interval, count, 
		function(id, args)
			if type(self.on_timer) == "function" then
				self:on_timer(id, args)
			end
		end, args)

    return timer_id
end

--- 摧毁定时器
function _M:destory_timer(id)
    self.__timer:del(id)
end