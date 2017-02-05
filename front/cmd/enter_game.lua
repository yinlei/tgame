--------------------------------------------------------------------------------
-- login->gate
--------------------------------------------------------------------------------
local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local server = require "server"

local key = require("gate.core").key

local  _M = {}

function _M.command(account, char_id)
    local _key = key.key(account, char_id)

    return {_key, server.address()}
end

return _M
