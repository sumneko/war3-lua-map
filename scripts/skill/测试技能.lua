local mt = ac.skill['测试技能']

function mt:onAdd()
    print('获得：', self)
end

function mt:onRemove()
    print('失去：', self)
end

function mt:onCastShot()
    local unit = self:getOwner()
    print('onCastShot')
    unit:blink(self:getTarget())
    unit:getOwner():moveCamera(self:getTarget(), 1)

end
