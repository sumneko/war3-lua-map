ac.game:event('单位-创建', function (_, unit)
    if unit:getName() == '测试英雄' then
        local skill = unit:addSkill('测试技能', '物品', 3)
        ac.wait(1, function ()
            unit:getPoint():createItem('测试物品')
        end)
        unit:add('力量', 100)
    end
end)
