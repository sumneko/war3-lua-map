//TESH.scrollpos=15
//TESH.alwaysfold=0
<?
local slk = require 'slk'

-- 通魔使用的命令字符串（共需要12个）
local orderList = {
    'incineratearrowoff',
    'incineratearrowon',
    'incineratearrow',
    'volcano',
    'soulburn',
    'lavamonster',
    'transmute',
    'healingspray',
    'chemicalrage',
    'acidbomb',
    'summonfactory',
    'unrobogoblin',
}

-- 为每个格子分配50个技能，共600个
local SIZE = 50
local i = 0
local slot = 0
for x = 0, 3 do
    for y = 2, 0, -1 do
        slot = slot + 1
        for _ = 1, SIZE do
            i = i + 1
            local order = orderList[slot]
            local tag = '主动技能-' .. tostring(i)
            slk.ability.ANcl:new(tag) {
                Name = '@主动技能-' .. tostring(slot),
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
                DataF = {order, order},
                Rng = {0, 0},
            }
            
            local tag = '被动技能-' .. tostring(i)
            slk.ability.Amgl:new(tag) {
                Name = '@被动技能-' .. tostring(slot),
                Buttonpos = {x, y},
                UnButtonpos = {x, y},
                Researchbuttonpos = {x, y},
                Requires = '',
            }
        end
    end
end
?>
