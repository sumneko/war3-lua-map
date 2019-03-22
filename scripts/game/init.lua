local japi = require 'jass.japi'
local jass = require 'jass.common'

ac.game:event('单位-创建', function (_, unit)
    if unit:getName() == '测试英雄' then
        unit:bagSize(6)
        --unit:set('攻击', 99999999999999)
        --unit:set('护甲', 99999999999999)
        --unit:set('力量', 99999999999999)
        --unit:set('敏捷', 99999999999999)
        --unit:set('智力', 99999999999999)
        ac.player(1):addHero(unit)
        print('addHero', unit)
        unit:addRestriction '飞行'
        unit:addRestriction '缴械'
        unit:addSkill('测试技能', '技能', 6)
        local skill = unit:addSkill('测试技能2', '技能', 6)
        ac.loop(1, function ()
            if skill:isShow() then
                skill:hide()
                print('hide')
            else
                skill:show()
                print('show')
            end
        end)
    end
end)

print(_VERSION)

ac.wait(1, function ()
    local u1 = ac.player(1):getHero(1)
    local u2 = ac.player(1):getHero(2)
    
    print('getHero', u1, u2)

    ac.lightning {
        source = u1,
        target = u2,
        model = 'AFOD',
        sourceHeight = 100,
        targetHeight = 100,
    }
end)

ac.game:event('玩家-聊天', function (_, _, str)
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

local jass = require 'jass.common'
local mt = ac.item['测试物品']

function mt:onAdd()
    print('add item')
    self:stack(1)
end

function mt:onRemove()
    print('remove item')
    if self.timer then
        return
    end
    self.timer = ac.loop(1, function ()
        if self:isShow() then
            self:hide()
            print('hide')
        else
            self:show()
            print('show')
        end
    end)
end

local mt = ac.skill['测试物品']

mt.cool = 10

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
