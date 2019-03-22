local mt = ac.skill['测试技能']

mt.animation = 'attack'
mt.targetType = '点'

function mt:onAdd()
    print('获得：', self)
    local hero = self:getOwner()

    ac.game:event('单位-攻击出手', function (_, source, target, _, mover)
        if target ~= hero then
            return
        end
        if not mover then
            return
        end
        local paused = false
        ac.loop(0.01, function ()
            if mover.mover:getPoint() * hero:getPoint() < 200 then
                if not paused then
                    paused = true
                    mover:pause()
                end
            else
                if paused then
                    paused = false
                    mover:resume()
                end
            end
        end)
    end)
end

function mt:onRemove()
    print('失去：', self)
end

local count = 0

function mt:onCastShot()
    local unit = self:getOwner()
    local target = self:getTarget()
    print('onCastShot', target)
    ac.effect {
        target = target,
        model = [[Abilities\Spells\Human\MagicSentry\MagicSentryCaster.mdl]],
        speed = 1 / 2.0,
        time = 2.0,
        --size = 500 / 100.0,
        height = -100,
        skipDeath = true,
    }

    local tag = ac.textTag():text('测试文字'):at(target)
    ac.wait(3, function ()
        print('tag life')
        tag:life(3, 0)
    end)
end

function mt:onCastStop()
    print('onCastStop')
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
