--------------------------------------------------------------------------------
-- 启动
--------------------------------------------------------------------------------
local T = require "tengine"

local config = require "config"
local client = require "client"

T.start(
    function()
        local _client = client.new("test")
        if _client then
            _client:start(config.address, config.version)
        end
    end
)
