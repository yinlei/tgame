-------------------------------------------------------------------------------
-- 行为树
-------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local BT = require('lib/behaviourtree')

BT.register("login", require(_PACKAGE.."/login"))
BT.register("game", require(_PACKAGE.."/game"))

local function new()
    return BT:new({
        tree = BT.Sequence:new({nodes = {"login", "game"}})
    })
end

return {
    new = new
}
