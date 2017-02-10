-------------------------------------------------------------------------------
-- lobby
-------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local _M = require(_PACKAGE.."/lobby")
require(_PACKAGE .. "/start")
require(_PACKAGE .. "/enter")
require(_PACKAGE .. "/leave")

-- state
require(_PACKAGE.."/normal")
require(_PACKAGE.."/private")

local self = _M:new()

return self