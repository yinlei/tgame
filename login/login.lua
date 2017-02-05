--------------------------------------------------------------------------------
-- login.lua
--------------------------------------------------------------------------------
local actor = tengine.actor
local timer = tengine.timer

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG

local agent = require "agent"
local db = require "db"
local server = require "server"
local cmd	= require "login.cmd"

local function command(command, ...)
	local f = assert(cmd[command])
	return f(...)
end

return function(conf)
	if not conf.db then
		error("can't find db config !!!")
	end

	--db.init(conf)

	actor.start(command)

end
