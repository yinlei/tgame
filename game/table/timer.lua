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

    if interval < 0 then
        interval = 0
    end    

    local _id = self.__timer:add(interval, interval, count, 
        function(id, args)
            self:on_timer(id, args)
        end, ...)

    return _id
end

--- 摧毁定时器
function _M:destory_timer(id)
    self.__timer:del(id)
end

--- 定时处理
function _M:on_timer(id, ...)
    if id == self.__offline_timer then
        if not self.__gamestarted then
            return false
        end

    else
        self.__logic:on_timer(id, ...)
    end
end