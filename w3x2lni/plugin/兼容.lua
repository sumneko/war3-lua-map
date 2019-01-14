local mt = {}

mt.info = {
    name = '兼容',
    version = 1.0,
    author = '最萌小汐',
    description = 'YDWE运行时slk有BUG，这里做个兼容'
}

function mt:on_full(w2l)
    -- TODO 如果是YDWE打开lni地图，则不执行以下代码
    if w2l.setting.mode == 'obj' and w2l.log_path:filename():string() == 'w3x2lni' then
        return
    end
    for type in pairs(w2l.info.lni) do
        for _, obj in pairs(w2l.slk[type]) do
            obj.w2lobject = nil
        end
    end
end

return mt
