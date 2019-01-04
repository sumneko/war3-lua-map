local mt = {}
mt.__index = mt

mt.type = 'attack'
mt.unit = nil

function mt:shotInstant(target)
    local damage = ac.damage.create {
        source = self.unit,
        target = target,
        skill  = self,
        damage = self.unit:get '攻击',
    }
    ac.damage.dispatch(damage)
end

function mt:dispatch(target)
    if self.type == '立即' then
        self:shotInstant(target)
    elseif self.type == '弹道' then
        self:shotInstant(target)
    end
end

return function (unit, attack)
    if not attack then
        return nil
    end

    return setmetatable({
        type = attack.type,
        range = attack.range,
        mover = attack.mover,
        unit = unit,
    }, mt)
end
