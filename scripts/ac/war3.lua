local jass = require 'jass.common'
local dbg = require 'jass.debug'

local FRAME = 10

local function timer()
    local jTimer = jass.CreateTimer()
    dbg.handle_ref(jTimer)
    jass.TimerStart(jTimer, 0.001 * FRAME, true, function ()
        ac.event['游戏-帧'](FRAME)
    end)
end

timer()
