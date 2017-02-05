--------------------------------------------------------------------------------
-- world.lua
--------------------------------------------------------------------------------
local actor = tengine.actor
local emitter = tengine.Emitter
local timer = tengine.timer

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = {}

local global_objects = {}

local function _on_register_service(type, s)
    --INFO_MSG("after 5s, start game ...")
    timer.callback(0, function(...)
        if type == 'gate' then
            local _gate = actor.sync(s)
            local ok, ret = _gate.start_game()
            if not ok or ret ~= 0 then
                ERROR_MSG("start game logic failed !!!")
            else
                INFO_MSG("start game ok ...")

                -- TODO 通知登录服
            end
        end
    end, type, s)
end

function _M.init(self, conf)
    if not self.__init then
        self.__init = true
        self.event = emitter:new()

        -- 当第一个gate注册上来就通知他启动游戏逻辑
        self.event:once("register_service", _on_register_service)
    end
end

function _M.trigger(self, name, ...)
    local event = self.event
    if event then
        event:emit(name, ...)
    end
end

function _M.get_global_object(type)
    return global_objects[type]
end

function _M.add_global_object(type, s)
    global_objects[type] = s
end

function _M.del_global_object(type)
    global_objects[type] = nil
end

return _M
