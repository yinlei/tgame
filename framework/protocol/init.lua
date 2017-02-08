--------------------------------------------------------------------------------
-- protocol
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local p = tengine.p

local _M = require(_PACKAGE.."/protocol")

--_M.registerproto("protocol.proto", "framework/protocol/")
--_M.registerproto("login.proto", "framework/protocol/")
--_M.registerproto("lobby.proto", "framework/protocol/")
--_M.registerproto("match.proto", "framework/protocol/")
--_M.registerproto("private.proto", "framework/protocol/")

_M.register("protocol.pb", "framework/protocol/")
_M.register("login.pb", "framework/protocol/")
_M.register("lobby.pb", "framework/protocol/")
_M.register("match.pb", "framework/protocol/")
_M.register("private.pb", "framework/protocol/")

local protobuf = require(_PACKAGE .. '/protobuf')

return _M