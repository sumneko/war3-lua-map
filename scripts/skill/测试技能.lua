local mt = ac.skill['测试技能']

function mt:onAdd()
    print('获得：', self)
end

function mt:onRemove()
    print('失去：', self)
end

local count = 0

function mt:onCanCast()
    print('onCanCast')
    return false
end

function mt:onCastShot()
    local unit = self:getOwner()
    local target = self:getTarget()
    print('onCastShot', target)
end

function mt:onRemove()
    print('onRemove', self._lockEvent)
end

local mt = ac.buff['测试1']

mt.show = 1
mt.icon = [[ReplaceableTextures\CommandButtons\BTNInvisibility.blp]]
mt.title = '测试状态'
mt.description = '测试状态的描述'

function mt:onAdd()
    print('获得状态：', self)
    self:remove()
    print('after remove')
end

function mt:onRemove()
    print('失去状态：', self)
end

local mt = ac.buff['测试2']

mt.show = 1

function mt:onAdd()
    print('获得状态：', self)
end

function mt:onRemove()
    print('失去状态：', self)
end
