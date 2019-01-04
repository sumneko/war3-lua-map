local jass = require 'jass.common'

local Trg
local Condition = jass.Condition(function ()
    local source = ac.unit(jass.GetEventDamageSource())
    local target = ac.unit(jass.GetTriggerUnit())
    local dmg = jass.GetEventDamage()
    if source and target and dmg == 1.0 then
        if source.attack then
            source.attack:dispatch(target)
        end
    end
end)

local function createTrigger()
    if Trg then
        jass.DestroyTrigger(Trg)
    end
    Trg = jass.CreateTrigger()
    jass.TriggerAddCondition(Trg, Condition)
    for handle in pairs(ac.unit.all) do
        if jass.GetUnitAbilityLevel(handle, ac.id.Aloc) == 0 then
            jass.TriggerRegisterUnitEvent(Trg, handle, 52) -- EVENT_UNIT_DAMAGED
        end
    end
end

return function ()
    createTrigger()
    ac.loop(600 * 1000, function ()
        createTrigger()
    end)
    ac.game:event('单位-初始化', function (_, unit)
        jass.TriggerRegisterUnitEvent(Trg, unit.handle, 52) -- EVENT_UNIT_DAMAGED
    end)
end
