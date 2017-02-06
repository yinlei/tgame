-------------------------------------------------------------------------------
-- game
-------------------------------------------------------------------------------
local T = require "tengine"

require "game.object"

local actor = tengine.actor
local timer = tengine.timer

local conf = require "config"
local cmd	= require "game.cmd"
local lobby = require "lobby"

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG

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
    lobby.init(...)

	actor.start(command)

    local global = actor.sync("global")

    local succ, ret = global.register_service("game", actor.self())
    if succ and ret == 0 then
        INFO_MSG("register to global success ...")
    else
        ERROR_MSG("rgister to global failed !!!")
    end

    local function gc()
        collectgarbage()
        collectgarbage()
        timer.callback(100, gc)
    end

    timer.callback(100, gc)


    INFO_MSG("game service started ...")
end

T.start(main, conf)
