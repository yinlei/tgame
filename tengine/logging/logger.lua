
local string_format = string.format

local type = type

local c = require "tengine.c"

local log = c.log

DEBUG = DEBUG or true

local inspect = tengine.inspect

--[[
/*
 * Output colored text to ANSI (Linux, Mac, iPhone) and Windows terminals.
 * This function wraps printf (by using vprintf), and adds a 'color' parameter to it.
 *
 * color = -1 -> not colored (same as printf)
 *          0 -> red
 *          1 -> green
 *          2 -> yellow
 *          3 -> blue
 *          4 -> magenta
 *          5 -> cyan
 */
--]]

local function p(...)
    if DEBUG then
        if tengine.is_windows then
            log(-1, inspect({...}))
        else
            log(-1, pretty(...))
        end
    end
end

--[[
local function Log(msg, ...)
	log(4, string_format("[LOG] " .. msg, ...))
end

local function Debug(msg, ... )
	if DEBUG then
		log(3, string_format("[DEBUG] " .. msg, ...))
	end
end

local function Fatal(msg, ...)
	log(0, string_format("[ERROR] " .. msg, ...))
end
--]]

local function filter(msg)
    if type(msg) ~= 'string' then
        msg = inspect(msg)
    end

    return msg
end

local function trace_msg(msg, ...)
    log(3, string_format("[TRACE] [%d] " .. filter(msg), __Service__, ...))
end

local function debug_msg(msg, ...)
    log(1, string_format("[DEBUG] [%d] " .. filter(msg), __Service__, ...))
end

local function info_msg(msg, ...)
    log(5, string_format("[INFO] [%d] " .. filter(msg), __Service__, ...))
end

local function notice_msg(msg, ...)
    log(4, string_format("[NOTICE] [%d] " .. filter(msg), __Service__, ...))
end

local function warning_msg(msg, ...)
    log(2, string_format("[WARNING] [%d] " .. filter(msg), __Service__, ...))
end

local function error_msg(msg, ...)
    log(0, string_format("[ERROR] [%d] " .. filter(msg), __Service__, ...))
end

local function critical_msg(msg, ...)
    log(0, string_format("[CRITICAL] [%d] " .. filter(msg), __Service__, ...))
end


return {
	p = p,

    TRACE_MSG = trace_msg,
    DEBUG_MSG = debug_msg,
    INFO_MSG = info_msg,
    NOTICE_MSG = notice_msg,
    WARNING_MSG = warning_msg,
    ERROR_MSG = error_msg,
    CRITICAL_MSG = critical_msg,
}
