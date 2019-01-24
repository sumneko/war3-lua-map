local mt = ac.skill['测试技能']

function mt:onAdd()
    print('获得：', self)
end

function mt:onRemove()
    print('失去：', self)
end

function mt:onCastShot()
    local unit = self:getOwner()
    print('onCastShot', unit:currentSkill())
    unit:blink(self:getTarget())
    unit:getOwner():moveCamera(self:getTarget(), 1)

    print('===============')
    for _, u in ac.selector()
        : inRange(unit:getPoint(), 10000)
        : of {'建筑', '英雄'}
        : ofNot '测试'
        : ipairs()
    do
        print(u)
    end
end
