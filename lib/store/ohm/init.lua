--------------------------------------------------------------------------------
-- sohm(https://github.com/soveran/ohm)
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local ohm = require(_PACKAGE.."/model")

local models = {}

local function model(name, scheme)
    if not models[name] then
        local _model = ohm.model(name, scheme)
        models[name] = _model
    end

    return models[name]
end


return {
    model = model
}

