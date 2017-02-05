local function bind(obj, method)
    return function(...)
        return method(obj, ...)
    end
end

return bind
