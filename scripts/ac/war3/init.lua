local jass = require 'jass.common'
local dbg = require 'jass.debug'
local initDamage = require 'ac.war3.damage'

local FRAME = 10

local function startTimer()
    local jTimer = jass.CreateTimer()
    dbg.handle_ref(jTimer)
    jass.TimerStart(jTimer, 0.001 * FRAME, true, function ()
        ac.event['游戏-帧'](FRAME)
    end)
end

local function searchPresetUnits()
    local g = jass.CreateGroup()
    for i = 0, 15 do
        jass.GroupEnumUnitsOfPlayer(g, jass.Player(i), nil)
        while true do
            local u = jass.FirstOfGroup(g)
            if u == 0 then
                break
            end
            jass.GroupRemoveUnit(g, u)
            ac.unit(u)
        end
    end
    jass.DestroyGroup(g)
end

-- 根据unit表注册地图上的预设单位
searchPresetUnits()
-- 注册任意单位受伤事件
initDamage(function ()
end)
-- 启动计时器，开始tick
startTimer()
