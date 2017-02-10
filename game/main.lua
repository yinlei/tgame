-------------------------------------------------------------------------------
-- game
-------------------------------------------------------------------------------
local T = require "tengine"

local json = require 'cjson'

local args = {...}

local actor = tengine.actor
local timer = tengine.timer

local conf = require "config"
local cmd	= require "game.cmd"
local lobby = require "game.lobby"

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local function command(command, ...)
	local f = assert(cmd[command])

    local succ, ret = pcall(f, ...)
	if not succ then
        ERROR_MSG("game command failed %s, %s", command, ret)
        return
    else
        return ret
    end
end

local function main(...)
	actor.start(command)

    local gconf = json.decode(args[1])
    local goption = json.decode(args[2])

    --p(gconf, goption)

    lobby:start(gconf, goption)

    local function gc()
        collectgarbage()
        collectgarbage()
        timer.callback(100, gc)
    end

    timer.callback(100, gc)

    INFO_MSG("game service started ...")
end

T.start(main, conf)
