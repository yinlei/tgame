--------------------------------------------------------------------------------
-- debug
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

return {
    --snapshot = require (_PACKAGE.."/snapshot"),
    monitor = require (_PACKAGE.."/monitor"),
    leak = require (_PACKAGE.."/leak"),
}
