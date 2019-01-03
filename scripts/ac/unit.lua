local jass = require 'jass.common'
local japi = require 'jass.japi'
local slk = require 'jass.slk'
local dbg = require 'jass.debug'

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
        _slk = slk.unit[id]
    }, mt)
    dbg.gchash(u, handle)
    u._gchash = handle

    All[handle] = u

    if jass.GetUnitAbilityLevel(handle, ac.id.Aloc) > 0 then
        return u
    end

    ac.game:event_notify('单位-初始化', u)
    ac.game:event_notify('单位-创建', u)

    return u
end

mt.__index = mt

mt.type = 'unit'

function mt:get_name()
    return self._slk.Propernames or self._slk.Name
end
