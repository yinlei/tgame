--------------------------------------------------------------------------------
-- main.lua
--------------------------------------------------------------------------------
local  T = require "tengine"

local INFO_MSG = T.INFO_MSG

local conf = require "config"

local timer = T.timer

local function main(...)
    local function gc()
        collectgarbage()
        collectgarbage()
        timer.callback(100, gc)
    end

    timer.callback(100, gc)
    require "login"(...)
    INFO_MSG("login service started ...")
end

T.start(main, conf)
