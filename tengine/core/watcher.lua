--------------------------------------------------------------------------------
-- wrap for c.watchdog
--------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

--[[
local watcher = c.watchdog("data/buff.lua", function(path) p(path) end)

p(watcher)
--]]
