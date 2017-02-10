-------------------------------------------------------------------------------
-- 行为树
-------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local BT = require('lib/behaviourtree')

BT.register("login", require(_PACKAGE.."/login"))
BT.register("lobby", require(_PACKAGE.."/lobby"))
BT.register("game", require(_PACKAGE.."/game"))

local function new()
    return BT:new({
        tree = BT.Sequence:new({nodes = {"login", "lobby", "game"}})
    })
end

return {
    new = new
}
