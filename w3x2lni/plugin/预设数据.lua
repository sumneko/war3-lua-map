local mt = {}

mt.info = {
    name = '预设数据',
    version = 1.0,
    author = '最萌小汐',
    description = '将物编数据设置为标准值。'
}

local function deepCopy(t)
    local new = {}
    for k, v in pairs(t) do
        if type(v) == 'table' then
            new[k] = deepCopy(v)
        else
            new[k] = v
        end
    end
    return new
end

local function newObject(slk, id, parent, level)
    return function (data)
        local new = deepCopy(slk[parent])
        new._parent = parent
        new._id = id
        new._obj = true

        for k, v in pairs(data) do
            new[k:lower()] = v
        end

        slk[id] = new
    end
end

local function unitInsert(w2l)
    newObject(w2l.slk.unit, '@DMY', 'ewsp'){
        -- 可建造建筑
        Builds = "",
        -- 名字
        Name = "通用马甲",
        -- 特殊效果
        Specialart = "",
        -- 普通
        abilList = "Aloc,Arav",
        -- 可以逃跑
        canFlee = 0,
        -- 动画 - 魔法施放回复
        castbsw = 0.0000,
        -- 碰撞体积
        collision = 0.0000,
        -- 死亡时间(秒)
        death = 10.0000,
        -- 防御升级奖励
        defUp = 0.0000,
        -- 高度变化 - 采样范围
        elevRad = 0.0000,
        -- 模型文件
        file = "model\\dummy-common.mdl",
        -- 占用人口
        fused = 0,
        -- 隐藏小地图显示
        hideOnMinimap = 1,
        -- 射弹碰撞偏移 - Z
        impactZ = 0.0000,
        -- X轴最大旋转角度(弧度)
        maxPitch = 0.0000,
        -- Y轴最大旋转角度(弧度)
        maxRoll = 0.0000,
        -- 类型
        movetp = "",
        -- 视野范围(夜晚)
        nsight = 0,
        -- 生命回复
        regenHP = 0.0000,
        -- 生命回复类型
        regenType = "",
        -- 视野范围(白天)
        sight = 0,
        -- 转身速度
        turnRate = 3.0000,
        -- 单位类别
        type = "ward",
        -- 使用科技
        upgrades = "",
    }

    newObject(w2l.slk.unit, '@MVR', 'ewsp'){
        -- 可建造建筑
        Builds = "",
        -- 名字
        Name = "通用马甲",
        -- 特殊效果
        Specialart = "",
        -- 普通
        abilList = "Aloc,Arav",
        -- 可以逃跑
        canFlee = 0,
        -- 动画 - 魔法施放回复
        castbsw = 0.0000,
        -- 碰撞体积
        collision = 0.0000,
        -- 死亡时间(秒)
        death = 10.0000,
        -- 防御升级奖励
        defUp = 0.0000,
        -- 高度变化 - 采样范围
        elevRad = 0.0000,
        -- 模型文件
        file = "model\\dummy-mover.mdl",
        -- 占用人口
        fused = 0,
        -- 隐藏小地图显示
        hideOnMinimap = 1,
        -- 射弹碰撞偏移 - Z
        impactZ = 0.0000,
        -- X轴最大旋转角度(弧度)
        maxPitch = 0.0000,
        -- Y轴最大旋转角度(弧度)
        maxRoll = 0.0000,
        -- 类型
        movetp = "",
        -- 视野范围(夜晚)
        nsight = 0,
        -- 生命回复
        regenHP = 0.0000,
        -- 生命回复类型
        regenType = "",
        -- 视野范围(白天)
        sight = 0,
        -- 转身速度
        turnRate = 3.0000,
        -- 单位类别
        type = "ward",
        -- 使用科技
        upgrades = "",
    }
end

local function unitDefault(w2l)
    -- 设置所有单位的默认数据
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

function mt:on_full(w2l)
    -- TODO 如果是YDWE打开lni地图，则不执行以下代码
    if w2l.setting.mode == 'obj' and w2l.log_path:filename():string() == 'w3x2lni' then
        return
    end

    unitInsert(w2l)

    unitDefault(w2l)
end

return mt
