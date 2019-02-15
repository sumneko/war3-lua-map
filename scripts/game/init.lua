ac.game:event('单位-创建', function (_, unit)
    if unit:getName() == '测试英雄' then
        local skill = unit:addSkill('测试技能', '技能', 3)
    end
end)

local mt = ac.skill['测试物品']

function mt:onAdd()
    print('获得 skill')
end

function mt:onRemove()
    print('失去 skill')
end

function mt:onCastShot()
    print('cast shot')
    local tag = ac.textTag()
        : text '测试'
        : at(self:getOwner():getPoint())
        : speed(0.2)
        : show(function (player)
            return player == ac.player(1)
        end)
end

local mt = ac.item['测试物品']

function mt:onAdd()
    print('获得 item')
end

function mt:onRemove()
    print('失去 item')
end

ac.player(1):add('金币', 1000)
ac.player(1):add('木材', 2000)
ac.player(1):add('食物', 10)
ac.player(1):add('食物上限', 20)

ac.loop(0.1, function ()
    ac.player(1):add('金币', 100)
end)

local shop = ac.player(1):createShop('商店', ac.point(-500, -500), 0)
shop:setItem('测试物品', 1)
shop:setItem('测试物品', 4)
shop:setItem('测试物品', 11)

local shop2 = ac.player(2):createShop('商店', ac.point(-500, -500), 0)
shop2:setItem('测试物品', 3)
shop2:setItem('测试物品', 7)
shop2:setItem('测试物品', 10)
