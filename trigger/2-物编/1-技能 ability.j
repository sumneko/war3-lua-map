//TESH.scrollpos=0
//TESH.alwaysfold=0
<?
local slk = require 'slk'

-- 每个head能产生1296个ID，应该够用了
local function idFactory(head)
    local ids = {}
    local chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'

    for x = 1, #chars do
        for y = 1, #chars do
            ids[#ids+1] = ('%s%s%s'):format(head, chars:sub(x, x), chars:sub(y, y))
        end
    end
    
    return ids
end

-- 主动技能的模板通魔，head == 'SS'
local skillIds = idFactory('SS')
-- 被动技能的模板月刃，head == 'SP'
local passiveIds = idFactory('SP')
-- 为每个格子分配50个技能，共600个
local i = 0
for x = 0, 3 do
    for y = 0, 2 do
        for _ = 1, 50 do
            i = i + 1
            slk.ability.ANcl:new(skillIds[i]) {
                Name = '主动技能',
                Buttonpos = {x, y},
                UnButtonpos = {x, y},
                Researchbuttonpos = {x, y},
                EffectArt = '',
                TargetArt = '',
                Targetattach = '',
                Animnames = '',
                CasterArt = '',
                hero = 0,
                levels = 2,
                DataA = {0, 0},
                DataD = {0, 0},
                Rng = {0, 0},
            }
            
            slk.ability.Amgl:new(passiveIds[i]) {
                Name = '被动技能',
                Buttonpos = {x, y},
                UnButtonpos = {x, y},
                Researchbuttonpos = {x, y},
                Requires = '',
            }
        end
    end
end
?>