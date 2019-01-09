local type = type

function ac.isUnit(obj)
    return type(obj) == 'table' and obj.type == 'unit'
end
