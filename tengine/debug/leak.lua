--------------------------------------------------------------------------------
-- leak
--------------------------------------------------------------------------------
local type, pairs, tostring, setmetatable = 
    type, pairs, tostring, setmetatable

local p = tengine.p

local findedObjMap = nil

local function findObject(obj, findDest)
    if findDest == nil then
        return false
    end
    if findedObjMap[findDest] ~= nil then
        return false
    end
    findedObjMap[findDest] = true

    local destType = type(findDest)
    if destType == "table" then
        if findDest == _G.CMemoryDebug then
            return false
        end
        for key, value in pairs(findDest) do
            if key == obj or value == obj then
                p("Finded Object")
                return true
            end
            if findObject(obj, key) == true then
                _info("table key")
                return true
            end
            if findObject(obj, value) == true then
                _info("key:["..tostring(key).."]")
                return true
            end
        end
    elseif destType == "function" then
        local uvIndex = 1
        while true do
            local name, value = debug.getupvalue(findDest, uvIndex)
            if name == nil then
                break
            end
            if findObject(obj, value) == true then
                _info("upvalue name:["..tostring(name).."]")
                return true
            end
            uvIndex = uvIndex + 1
        end
    end
    return false
end

local function findObjectInGlobal(obj)
    findedObjMap = {}
    setmetatable(findedObjMap, {__mode = "k"})
    return findObject(obj, _G)
end


return {
    findObject = findObject,
    findObjectInGlobal = findObjectInGlobal,
}
