local mt = ac.skill['测试技能']

function mt:onAdd()
    print('获得：', self)
end

function mt:onRemove()
    print('失去：', self)
end

local count = 0

function mt:onCastShot()
    local unit = self:getOwner()
    local target = self:getTarget()
    print('onCastShot', unit:currentSkill())

    unit:addBuff '测试' {}
    unit:addBuff '测试' {}
end

local mt = ac.buff['测试']

function mt:onAdd()
    print('获得状态：', self)
end

function mt:onRemove()
    print('失去状态：', self)
end

function mt:onPulse()
    print(self:remaining())
end
