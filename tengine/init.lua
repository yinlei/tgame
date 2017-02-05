--------------------------------------------------------------------------------
-- tengine
--------------------------------------------------------------------------------
local require, package = require, package

if _G.jit then
    require "tengine.compat53"
end

tengine = tengine or {}


if _G.jit then
    tengine.is_windows = _G.jit.os == "Windows"
else
    tengine.is_windows = not package.path:match("\\")
end

-- c
tengine.c 		= require "tengine.c"
tengine.now      = tengine.c.now

-- base
require "tengine.base"

-- bit
tengine.bit = require "tengine.base.bit"

tengine.cmsgpack = require "cmsgpack"
tengine.cjson    = require "cjson"

-- logger
tengine.logger 	    = require("tengine.logging").logger
tengine.p 		    = tengine.logger.p

tengine.TRACE_MSG 	= tengine.logger.TRACE_MSG
tengine.DEBUG_MSG 	= tengine.logger.DEBUG_MSG
tengine.INFO_MSG     = tengine.logger.INFO_MSG
tengine.NOTICE_MSG   = tengine.logger.NOTICE_MSG
tengine.WARNING_MSG  = tengine.logger.WARNING_MSG
tengine.ERROR_MSG    = tengine.logger.ERROR_MSG
tengine.CRITICAL_MSG = tengine.logger.CRITICAL_MSG

-- helper
tengine.helper = require "tengine.helper"
tengine.bind = tengine.helper.bind
tengine.map = tengine.helper.map
tengine.weakref = tengine.helper.weakref
tengine.weaktable = tengine.helper.weaktable
tengine.balance = tengine.helper.balance

require "tengine.helper.pretty"

-- debug
tengine.debug = require "tengine.debug"

-- hotfix
tengine.hotfix = require "tengine.hotfix"

-- core
tengine.core = require "tengine.core"
tengine.actor = tengine.core.actor
tengine.timer = tengine.core.timer
tengine.sleep = tengine.core.sleep
tengine.mysql = tengine.core.mysql
tengine.redis = tengine.core.redis
tengine.server = tengine.core.server
tengine.channel = tengine.core.channel
tengine.http = tengine.core.http
tengine.web = tengine.core.web

setmetatable(tengine, {__index = {_VERSION = "0.0.1"}})

return tengine
