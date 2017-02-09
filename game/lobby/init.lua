-------------------------------------------------------------------------------
-- lobby
-------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local _M = require(_PACKAGE.."/lobby")
require(_PACKAGE.."/start")

local self = _M:new()

return self