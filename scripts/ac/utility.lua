local type = type

function ac.isUnit(obj)
    return type(obj) == 'table' and obj.type == 'unit'
end

function ac.isPoint(obj)
    return type(obj) == 'table' and obj.type == 'point'
end

function ac.isNumber(obj)
    return type(obj) == 'number'
end
