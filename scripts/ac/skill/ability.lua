local slk = require 'jass.slk'
local jass = require 'jass.common'
local japi = require 'jass.japi'

local Pool

local function poolAdd(name, obj)
    local pool = Pool[name]
    if not pool then
        pool = {}
        Pool[name] = pool
    end
    pool[#pool+1] = obj
end

local function poolGet(name)
    local pool = Pool[name]
    if not pool then
        return nil
    end
    local max = #pool
    if max == 0 then
        return nil
    end
    local obj = pool[max]
    pool[max] = nil
    return obj
end

local function init()
    if Pool then
        return
    end
    Pool = {}
    for id, abil in pairs(slk.ability) do
        local name = abil.Name
        if name and name:sub(1, 1) == '@' then
            poolAdd(name, id)
        end
    end
end

local function getId(skill)
    local slot = ac.toInteger(skill._slot)
    if not slot then
        return nil
    end
    local passive = ac.toInteger(skill.passive)
    local name
    if passive == 0 then
        name = '@主动技能-' .. tostring(slot)
    else
        name = '@被动技能-' .. tostring(slot)
    end
    local id = poolGet(name)
    if not id then
        log.error(('无法为[%s]分配图标'):format(name))
        return nil
    end
    return name, id
end

local function releaseId(icon)
    local name = icon._name
    local id = icon._id
    if not id then
        return
    end
    icon._id = nil
    poolAdd(name, id)
end

local function addAbility(icon)
    local id = icon._id
    if not id then
        return false
    end
    local unit = icon._skill._owner
    return jass.UnitAddAbility(unit._handle, ac.id[id])
end

local function removeAbility(icon)
    local id = icon._id
    if not id then
        return false
    end
    local unit = icon._skill._owner
    return jass.UnitRemoveAbility(unit._handle, ac.id[id])
end

local mt = {}
mt.__index = mt
mt.type = 'ability icon'

function mt:remove()
    if self._removed then
        return
    end
    self._removed = true
    removeAbility(self)
    releaseId(self)
end

return function (skill)
    init()

    local name, id = getId(skill)
    if not id then
        return nil
    end

    local icon = setmetatable({
        _name = name,
        _id = id,
        _skill = skill,
    }, mt)

    local ok = addAbility(icon)
    if not ok then
        releaseId(icon)
        return nil
    end

    return icon
end
