--------------------------------------------------------------------------------
-- 命令处理
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local c = tengine.c

local _M = {}

local files = c.files(_PACKAGE)

for _, name in ipairs(files) do
    if name ~= 'init' then
        local m = require(_PACKAGE.."/" .. name)
        _M[name] = m.command
    end
end

return _M
