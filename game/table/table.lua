-------------------------------------------------------------------------------
-- table.lua
-------------------------------------------------------------------------------
local tlen = table.lenght

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local class = require "lib.middleclass"

local _M = class("table")

--- 初始化
function _M:initialize(id, conf)
    if not conf.chair then
        error('conf no chair count !!!')
    end
    -- 桌子编号
    self.__id = id
    -- 椅子数
    self.__chair = conf.chair
    -- 游戏开始模式
    self.__startmode = 0
    -- 游戏开始标记
    self.__gamestarted = false
    self.__roundstarted = false
    self.__tablestarted = false

    -- 是否允许旁观
    self.__lookon = {}
    -- 服务费用

    -- 游戏单位分数
    self.__unitscore = 0
    -- 游戏状态
    self.__gamestatus = 0

    -- 创建房间玩家
    self.__ownerid = 0
    -- 进入密码
    self.__enterpassword = ''

    -- 玩家断线次数
    self.__offlinecounts = {}
    -- 玩家断线时间
    self.__offlinetimes = {}

    -- 玩家列表
    self.__players = {}
    -- 旁观玩家
    self.__watchers = {}

    -- 游戏逻辑
    self.__logic = require('apps.'.. conf.service):new(self)

    INFO_MSG("table[%d] initialize ok ...", id)
end

--- 获取桌子编号
function _M:id()
    return self.__id
end

return _M