--------------------------------------------------------------------------------
-- sohm(https://github.com/soveran/ohm)
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local ohm = require(_PACKAGE.."/model")

local models = {}

local function model(name, define)
    if not models[name] then
        local _model = ohm.model(name, define.model)
        models[name] = _model
    end

    return models[name]
end


return {
    model = model
}

