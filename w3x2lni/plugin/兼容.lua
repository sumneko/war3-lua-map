local mt = {}

mt.info = {
    name = '兼容',
    version = 1.0,
    author = '最萌小汐',
    description = 'YDWE运行时slk有BUG，这里做个兼容'
}

function mt:on_full(w2l)
    for type in pairs(w2l.info.lni) do
        for _, obj in pairs(w2l.slk[type]) do
            obj.w2lobject = nil
        end
    end
end

return mt
