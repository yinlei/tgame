-------------------------------------------------------------------------------
-- handler
-------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local c = tengine.c

local _M = {}

local files = c.files(_PACKAGE)

for _, name in ipairs(files) do
    if name ~= 'init' then
        local m = require(_PACKAGE.."/" .. name)
        if m.ID then
            _M[m.ID] = m
        end
    end

end

return _M
