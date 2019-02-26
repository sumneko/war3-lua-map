ac.game:event('单位-创建', function (_, unit)
    if unit:getName() == '测试英雄' then
        local skill = unit:addSkill('测试技能', '技能', 3)
        unit:bagSize(6)
    end
end)

ac.player(1):add('金币', 1000)
ac.player(1):add('木材', 2000)
ac.player(1):add('食物', 10)
ac.player(1):add('食物上限', 20)

local message = require 'jass.message'
ac.loop(0.1, function ()
    ac.player(1):add('金币', 100)
end)

local shop = ac.player(16):createShop('商店', ac.point(-500, -500), 0)
shop:setItem('测试物品', 1, 'Q')
shop:setItem('测试物品', 4, 'W')
shop:setItem('测试物品', 11, 'E')

local mt = ac.item['测试物品']

function mt:onAdd()
    print('add item')
end

function mt:onRemove()
    print('remove item')
end

local mt = ac.skill['测试物品']

function mt:onAdd()
    print('add skill')
end

function mt:onRemove()
    print('remove skill')
end
