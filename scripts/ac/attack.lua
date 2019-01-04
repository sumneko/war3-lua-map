local mt = {}
mt.__index = mt

mt.type = 'attack'

local function init(unit)
    local attack = unit._slk.attack
    if not attack then
        return
    end

    unit.attack = setmetatable(attack, mt)
end

local function shotInstant(source, target)
    ac.damage.launch {
        source = source,
        target = target,
        damage = source:get '攻击',
    }
end

local function shot(source, target)
    if not source.attack then
        return
    end
    if source.attack.type == '立即' then
        shotInstant(source, target)
    end
end

ac.attack = {
    init = init,
    shot = shot,
}
