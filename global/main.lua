--------------------------------------------------------------------------------
-- main.lua
--------------------------------------------------------------------------------
local T = require "tengine"

local actor = T.actor
local timer = T.timer

local INFO_MSG = T.INFO_MSG

local conf = require "config"
local cmd	= require "global.cmd"

local world = require "world"

local function command(command, ...)
	local f = assert(cmd[command])
	return f(...)
end

local function main(...)
	world:init(...)

	actor.start(command)

    local function gc()
        collectgarbage()
        collectgarbage()
        timer.callback(1000, gc)
    end

    timer.callback(1000, gc)

	INFO_MSG("global service started ...")
end

T.start(main, conf)
