--------------------------------------------------------------------------------
-- main.lua
--------------------------------------------------------------------------------
local T = require "tengine"

local actor = T.actor

T.start(
    function()
        -- 登录服务
        actor.newservice('login')
        -- 全局服务
        actor.newservice('global')
        -- 前端服务
        actor.newservice('front')
        -- 游戏服务
        actor.newservice('game')
   end
)