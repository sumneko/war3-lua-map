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

    local eff = ac.effect {
        model = [[units\human\HeroArchMage\HeroArchMage.mdx]],
        target = target,
        size = 2,
        yScale = 1,
        angle = 90,
        time = 1,
        height = 100,
        skipDeath = true,
        sight = function (player)
            return player == ac.player(1)
        end
    }

    ac.timer(0.1, 50, function ()
        print(self:getCd())
    end)

    ac.wait(1, function ()
        self:setCd(0)
    end)
    ac.wait(2, function ()
        unit:set('冷却缩减', 40)
        self:activeCd(20)
        self:setCd(1)
    end)
end
