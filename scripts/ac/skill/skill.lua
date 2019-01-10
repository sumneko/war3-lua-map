local jass = require 'jass.common'
local japi = require 'jass.japi'
local ability = require 'ac.skill.ability'
local type = type
local rawget = rawget
local getmetatable = getmetatable
local setmetatable = setmetatable

-- 技能分为4层：
-- 1. data，通过ac.table.skill[name]访问，与lni中填写的内容一样
-- 2. define，通过ac.skill[name]访问，已根据技能的maxLevel字段
--    展开了数据，内部数据通过 ac.skill[name][key][level] 访问
-- 3. skill，单位身上的技能实例，技能数据为当前等级的值。0级技能
--    使用1级技能的数据。
-- 4. cast，每次施法的独立实例。

local DefinedData = {}
local DefinedDual = {}
local mt = {}

local function compileValue(name, k, v, maxLevel)
    if type(v) == 'table' and type(v[1]) == 'number' then
        -- 数列必须是刚好满足maxLevel，或是首项+尾项。其他情况直接丢弃。
        if #v == maxLevel then
            return v
        elseif maxLevel == 1 then
            log.error(('技能[%s]的[%s]不能为数列'):format(name, k))
            return nil
        elseif #v == 2 then
            local n = v[1]
            local m = v[#v]
            if type(m) ~= 'number' then
                log.error(('技能[%s]的[%s]尾项不是数字'):format(name, k))
                return nil
            end
            local o = (m - n) / (maxLevel - 1)
            local list = {}
            for i = 1, maxLevel do
                list[i] = n + o * (i - 1)
            end
            return list
        else
            log.error(('技能[%s]的[%s]数列长度不正确'):format(name, k))
            return nil
        end
    else
        local list = {}
        for i = 1, maxLevel do
            list[i] = v
        end
        return list
    end
end

local function compileDual(name, definedData, maxLevel)
    local dual = {}
    for lv = 1, maxLevel do
        dual[lv] = {}
        dual[lv].__index = dual[lv]
        dual[lv]._name = name
        setmetatable(dual[lv], mt)
    end
    for k, v in pairs(definedData) do
        for lv = 1, maxLevel do
            dual[lv][k] = v[lv]
        end
    end
    return dual
end

local function compileData(name, data)
    local maxLevel = ac.toInteger(data, 1)
    if maxLevel < 1 then
        log.error(('技能[%s]的等级上限小于1'):format(name))
        return nil
    end

    local definedData = {}
    definedData.__index = definedData
    for k, v in pairs(data) do
        definedData[k] = compileValue(name, k, v, maxLevel)
    end

    local definedDual = compileDual(name, definedData, maxLevel)

    DefinedData[name] = definedData
    DefinedDual[name] = definedDual
    return setmetatable({}, definedData )
end

-- 继承关系：
--  技能直接继承dual数据
--      skill[key] -> dual[key]
--  施法根据创建时的dual，选择使用的数据
--      cast[key] -> rawget(skill, key) | dual[key]

local function createSkill(name, level)
    local define = ac.skill[name]
    if not define then
        return nil
    end

    local definedDual = DefinedDual[name]
    if not definedDual then
        return nil
    end

    if level < 1 then
        level = 1
    elseif level > #definedDual then
        level = #definedDual
    end

    local skill = {}
    for k, v in pairs(define) do
        skill[k] = v
    end

    skill.__index = skill
    return setmetatable(skill, definedDual[level])
end

local function updateSkill(skill, level)
    local definedDual = DefinedDual[skill._name]
    if not definedDual then
        return
    end

    if level < 1 then
        level = 1
    elseif level > #definedDual then
        level = #definedDual
    end

    return setmetatable(skill, definedDual[level])
end

local castmt = {
    __index = function (self, key)
        local skill = self._parent
        local dual = self._dual
        local v = rawget(skill, key)
        if v == nil then
            v = dual[key]
        end
        return v
    end,
}

local function createCast(skill)
    return setmetatable({
        _parent = skill,
        _dual = getmetatable(skill),
    }, castmt)
end

local function createDefine(name)
    local data = ac.table.skill[name]
    if not data then
        log.error(('技能[%s]不存在'):format(name))
        return nil
    end
    -- 将data编译为define，展开等级数据
    local defined = compileData(name, data)
    if not defined then
        return nil
    end
    return defined
end

mt.__index = mt
mt.type = 'skill'

ac.skill = setmetatable({}, {
    __index = function (self, name)
        local skill = createDefine(name)
        if skill then
            self[name] = skill
            return skill
        else
            return nil
        end
    end,
})

return {
    createSkill = createSkill,
    updateSkill = updateSkill,
    createCast  = createCast,
}
