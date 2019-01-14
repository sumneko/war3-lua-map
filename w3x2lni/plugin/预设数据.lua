local mt = {}

mt.info = {
    name = '预设数据',
    version = 1.0,
    author = '最萌小汐',
    description = '将物编数据设置为标准值。'
}

function mt:on_full(w2l)
    -- TODO 如果是YDWE打开lni地图，则不执行以下代码
    if w2l.setting.mode == 'obj' and w2l.log_path:filename():string() == 'w3x2lni' then
        return
    end
    for _, unit in pairs(w2l.slk.unit) do
        -- 生命回复类型
        unit.regentype = 'none'
        -- 魔法回复
        unit.regenmana = 0
        -- 攻击骰子数量
        unit.dice1 = 1
        -- 攻击骰子面数
        unit.sides1 = 1
        -- 魔法施放点
        unit.castpt = 0
        -- 魔法施放回复
        unit.castbsw = 0
    end
end

return mt
