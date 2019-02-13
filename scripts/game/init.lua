ac.game:event('单位-创建', function (_, unit)
    if unit:getName() == '测试英雄' then
        local skill = unit:addSkill('测试技能', '技能', 3)
        ac.wait(1, function ()
            unit:createItem('测试物品')
        end)
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
end

local mt = ac.item['测试物品']

function mt:onAdd()
    print('获得 item')
end

function mt:onRemove()
    print('失去 item')
end

ac.player(1):createShop('测试防御塔', ac.point(-500, -500), 0)
