//TESH.scrollpos=14
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
local i = 0
for x = 0, 3 do
    for y = 0, 2 do
        for _ = 1, 50 do
            i = i + 1
            local order = orderList[x*3+y+1]
            local tag = '主动技能-' .. tonumber(i)
            slk.ability.ANcl:new(tag) {
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
                DataF = {order, order},
                Rng = {0, 0},
            }
            
            local tag = '被动技能-' .. tonumber(i)
            slk.ability.Amgl:new(tag) {
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