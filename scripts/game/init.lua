ac.game:event('单位-创建', function (_, unit)
    if unit:getName() == '测试英雄' then
        local skill = unit:addSkill('测试技能', '技能', 1)
        ac.wait(1000, function ()
            skill:remove()
        end)
    end
end)
