-------------------------------------------------------------------------------
-- 血战麻将
-------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local class = require "lib.middleclass"
local super = require "framework.mahjong"

local _game = require(_PACKAGE.."/game")
local _player = require(_PACKAGE.."/player")
local _logic = require(_PACKAGE.."/logic")
local _handler = require(_PACKAGE.."/handler")

local _M = class("xuezhan", super):include(_game, _player, _logic, _handler)

--- 常量定义
_M.static.GAME_NAME = '血战麻将'
_M.static.GAME_PLAYER = 4

-- 空闲状态
_M.static.GAME_STATUS_MJ_FREE = 0
-- 游戏状态
_M.static.GAME_STATUS_MJ_PLAY = 1
-- 换牌状态
_M.static.GAME_STATUS_MJ_HUANPAI = 2
-- 选缺状态
_M.static.GAME_STATUS_MJ_XUANQUE = 3

return _M