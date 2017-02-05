-------------------------------------------------------------------------------
-- lib
-------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local c = tengine.c

local include = function(package)

end

return {
    include = include,
    ser = require(_PACKAGE.."/ser")
}
