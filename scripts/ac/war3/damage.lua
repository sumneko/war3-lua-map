local jass = require 'jass.common'

local Trg
local Aloc = ('>I4'):unpack('Aloc')

local function createTrigger(callback)
    if Trg then
        jass.DestroyTrigger(Trg)
    end
    Trg = jass.CreateTrigger()
    jass.TriggerAddCondition(Trg, jass.Condition(callback))
    for handle in pairs(ac.unit.all) do
        if jass.GetUnitAbilityLevel(handle, Aloc) == 0 then
            jass.TriggerRegisterUnitEvent(Trg, handle, 52) -- EVENT_UNIT_DAMAGED
        end
    end
end

return function (callback)
    createTrigger(callback)
    ac.loop(600 * 1000, function ()
        createTrigger(callback)
    end)
    ac.game:event('单位-初始化', function (_, unit)
        jass.TriggerRegisterUnitEvent(Trg, unit.handle, 52) -- EVENT_UNIT_DAMAGED
    end)
end
