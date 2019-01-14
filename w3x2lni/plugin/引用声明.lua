local mt = {}

mt.info = {
    name = '引用声明',
    version = 1.1,
    author = '最萌小汐',
    description = '保留所有lni中声明的对象。',
}

local function mergeLni(list, lni)
    for k in pairs(lni) do
        list[k] = true
    end
end

function mt:on_mark(w2l)
    local list = {}
    for type, name in pairs(w2l.info.lni) do
        local buf = w2l.input_ar:get('table\\' .. name)
        if buf then
            local lni = w2l:parse_lni(buf, type)
            mergeLni(list, lni)
        end
    end
    return list
end

return mt
