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
    print('onCastShot', unit:currentSkill())

    local jass = require 'jass.common'
    local japi = require 'jass.japi'
    count = count + 1
    if count == 1 then
        unit:bagSize(6)
    elseif count == 2 then
        unit:bagSize(1)
    elseif count == 3 then
        unit:bagSize(0)
    elseif count == 4 then
        unit:bagSize(3)
    end

    for _, u in ac.selector()
        : inLine(unit, unit:getPoint() * self:getTarget(), unit:getPoint() / self:getTarget(), 500)
        : ipairs()
    do
        print(u)
    end
end
