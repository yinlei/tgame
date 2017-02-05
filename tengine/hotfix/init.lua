--------------------------------------------------------------------------------
-- hotfix
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local c = require "tengine.c"

local hotfix = require (_PACKAGE.."/fix")

local watchers = {}

local function fix(files)
    if type(files) == 'table' then
        for _, file in ipairs(files) do
            hotfix.hotfix_file(file)
        end
    end
end

local function hotupdate(path)
    if watchers[path] then
        return
    end

    local watcher = c.watchdog(path, fix)

    watchers[path] = watcher
end


return hotupdate
