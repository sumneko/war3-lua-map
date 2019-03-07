ac.game:event('单位-创建', function (_, unit)
    if unit:getName() == '测试英雄' then
        unit:bagSize(6)
        unit:set('攻击', 99999999999999)
        unit:set('护甲', 99999999999999)
        unit:set('力量', 99999999999999)
        unit:set('敏捷', 99999999999999)
        unit:set('智力', 99999999999999)
    end
end)

ac.game:event('玩家-聊天', function (_, _, str)
    local japi = require 'jass.japi'
    local jass = require 'jass.common'
    local unit = ac.player(1):getHero()
    print(tonumber(str))
    jass.SetHeroStr(unit._handle, tonumber(str), true)
end)

ac.player(1):add('金币', 1000)
ac.player(1):add('木材', 2000)
ac.player(1):add('食物', 10)
ac.player(1):add('食物上限', 20)

local message = require 'jass.message'
ac.loop(0.1, function ()
    ac.player(1):add('金币', 1000)
end)

local unit = ac.player(16):createUnit('商店', ac.point(-500, -500), 0)
local shop = unit:createShop()
shop:setItem('测试物品', 1, 'Q')
shop:setItem('测试物品', 4, 'W')
shop:setItem('测试物品', 11, 'E')

local mt = ac.item['测试物品']

function mt:onAdd()
    print('add item')
    self:stack(1)
end

function mt:onRemove()
    print('remove item')
end

function mt:onCanLoot()
    print('onCanLoot')
    return true
end

local mt = ac.skill['测试物品']

function mt:onAdd()
    print('add skill')
    print(self)
end

function mt:onRemove()
    print('remove skill')
end

function mt:onCastShot()
    print('onCastShot')
end
