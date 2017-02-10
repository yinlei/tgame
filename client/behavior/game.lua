-------------------------------------------------------------------------------
-- 游戏
-------------------------------------------------------------------------------
local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local BT = require('lib/behaviourtree') 

local _M = BT.Task:new()

function _M:start(args)
    -- 进入大厅
    local EnterLobby = {
        kind = 302,
    }

    local client = args[2]

    client:send('EnterLobby', EnterLobby)    
end

function _M:run(args)
    p("game run", args[1])
end

return _M
