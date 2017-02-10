-------------------------------------------------------------------------------
-- lobby.lua
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
    p("lobby run", args[1])

    local action = args[1]
    local client = args[2]

    if action == 'net' then
        local name = args[3]
        local message = args[4]

        p(name)
        if name == 'LobbyServerInfo' then
            -- 创建房间
            local CreatePrivateGame = {
                type = 302,
                round = 10,
                subtype = 1,
                rule = 2,
            }

            client:send('CreatePrivateGame', CreatePrivateGame)  
            running()
        elseif name == 'EnterLobbyFailed' then
            fail()
        end
    else
        running()
    end
end

return _M
