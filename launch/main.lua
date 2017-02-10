--------------------------------------------------------------------------------
-- main.lua
--------------------------------------------------------------------------------
local T = require "tengine"

local json = require "cjson"

local actor = T.actor

local gameconf = {
    -- 游戏类型
    type = 302,
    -- 游戏名字
    name = '血战麻将',
    -- 椅子数目
    chair = 4,
    -- 游戏版本
    version = '0.1',
    -- 服务名
    service = 'xuezhan'
}

local gameoption = {
    -- 游戏类型
    kind = 302,
    server = 1,

    -- 最大人数
    max_player = 500,
    -- 桌子数目
    table = 10,
    type = 0,
    rule = 0,
}

T.start(
    function()
        -- 登录服务
        actor.newservice('login')
        -- 全局服务
        actor.newservice('global')
        -- 前端服务
        actor.newservice('front')
        -- 游戏服务
        actor.newservice('game', json.encode(gameconf), json.encode(gameoption))
   end
)