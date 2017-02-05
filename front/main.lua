--------------------------------------------------------------------------------
-- front
--------------------------------------------------------------------------------
local T = require "tengine"

local timer = T.timer

require "gate.object"
require "gate.core"

local conf = require "config"

local function main(...)
    local function gc()
        collectgarbage()
        collectgarbage()
        timer.callback(100, gc)
    end

    timer.callback(100, gc)

   require "gate"(...)
end

T.start(main, conf)
