local jass = require 'jass.common'
local japi = require 'jass.japi'
local slk = require 'jass.slk'
local dbg = require 'jass.debug'
local attribute = require 'ac.attribute'
local attack = require 'ac.attack'

local All = {}
local UnitTable

local function initUnitTable()
    if UnitTable then
        return
    end
    UnitTable = {}
    for name, data in pairs(ac.table.unit) do
        local id = ('>I4'):unpack(data.id)
        local obj = slk.unit[id]
        if not obj then
            log.error(('单位[%s]的id[%s]无效'):format(name, id))
            goto CONTINUE
        end
        UnitTable[id] = name
        ::CONTINUE::
    end
end

local mt = {}
ac.unit = {
    all = All,
    mt  = mt,
}
setmetatable(ac.unit, ac.unit)

function ac.unit:__call(handle)
    if handle == 0 then
        return nil
    end
    if All[handle] then
        return All[handle]
    end

    initUnitTable()

    local id = jass.GetUnitTypeId(handle)
    local name = UnitTable[id]
    if not name then
        log.error(('ID[%s]对应的单位不存在'):format(id))
        return nil
    end
    local data = ac.table.unit[name]
    if not data then
        log.error(('名字[%s]对应的单位不存在'):format(name))
        return nil
    end

    local u = setmetatable({
        _gchash = handle,
        _handle = handle,
        _id = id,
        _data = data,
        _slk = slk.unit[id],
    }, mt)
    dbg.gchash(u, handle)
    u._gchash = handle

    All[handle] = u

    if jass.GetUnitAbilityLevel(handle, ac.id.Aloc) > 0 then
        return u
    end

    -- 初始化单位属性
    u.attribute = attribute(u, u._data.attribute)

    ac.game:eventNotify('单位-初始化', u)

    -- 初始化攻击
    u.attack = attack(u, u._data.attack)

    ac.game:eventNotify('单位-创建', u)

    return u
end

mt.__index = mt

mt.type = 'unit'

function mt:getName()
    return self._slk.Propernames or self._slk.Name
end

function mt:set(k, v)
    self.attribute:set(k, v)
end

function mt:get(k)
    return self.attribute:get(k)
end

function mt:add(k, v)
    self.attribute:add(k, v)
end

function mt:kill(target)
    jass.KillUnit(target._handle)
    target:eventNotify('单位-死亡', self)
end

--注册单位事件
function mt:event(name)
    return ac.event_register(self, name)
end

--发起事件
function mt:eventDispatch(name, ...)
    local res = ac.eventDispatch(self, name, ...)
    if res ~= nil then
        return res
    end
    --local player = self:getOwner()
    --if player then
    --	local res = ac.eventDispatch(player, name, ...)
    --	if res ~= nil then
    --		return res
    --	end
    --end
    local res = ac.eventDispatch(ac.game, name, ...)
    if res ~= nil then
        return res
    end
    return nil
end

function mt:eventNotify(name, ...)
    ac.eventNotify(self, name, ...)
    --local player = self:getOwner()
    --if player then
    --	ac.eventNotify(player, name, ...)
    --end
    ac.eventNotify(ac.game, name, ...)
end
