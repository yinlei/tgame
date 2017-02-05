-------------------------------------------------------------------------------
-- packet
-------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local c = tengine.c

local _M = {}

local files = c.files(_PACKAGE)

for _, name in ipairs(files) do
    if name ~= 'init' and name ~= 'opcode' then
        local m = require(_PACKAGE.."/" .. name)
        if m.C_ID then
            _M[m.C_ID] = m
        end

        if m.S_ID then
            _M[m.S_ID] = m
        end
    end

end

return _M
