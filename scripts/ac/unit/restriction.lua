local mt = {}

return function (unit, restriction)
    local obj = setmetatable({
        _unit = unit,
    }, mt)

    return obj
end
