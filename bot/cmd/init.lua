--------------------------------------------------------------------------------
-- cmd
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local c = tengine.c

local _M = {}

local files = c.files(_PACKAGE)

for _, name in ipairs(files) do
    if name ~= 'init' then
        local m = require(_PACKAGE.."/" .. name)

        for key, command in pairs(m) do
            if type(command) == 'function' then
                if type(_M[name]) == 'function' or
                    type(_M[key]) == 'function' then
                    error(key .. " command existed !!!")
                end
                -- 如果模块中只有command，就用文件名作为命令
                if key == 'command' then
                    _M[name] = command
                else
                    _M[key] = command
                end
            end
        end
    end
end

return _M
