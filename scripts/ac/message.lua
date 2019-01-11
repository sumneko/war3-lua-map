local message = require 'jass.message'
local jass = require 'jass.common'
local command = require 'ac.command'

local ORDER = require 'ac.war3.order'
local KEYBORD = message.keyboard
local FLAG = {
    QUEUE   = 1 << 0,
    INSTANT = 1 << 1,
    SINGLE  = 1 << 2,
    RESUME  = 1 << 5,
    FAIL    = 1 << 8,
}

local function localHero()
    return ac.localPlayer():getHero()
end

local function selectHero()
    local hero = localHero()
    if not hero then
        return
    end
    ac.localPlayer():selectUnit(hero)
end

local function lockHero()
    local hero = localHero()
    if not hero then
        return
    end
    jass.SetCameraTargetController(hero._handle, 0, 0, false)
end

local function unlockHero()
    jass.SetCameraPosition(jass.GetCameraTargetPositionX(), jass.GetCameraTargetPositionY())
end

local function onKeyDown(msg)
    -- 空格
    if msg.code == 32 then
        selectHero()
        lockHero()
        return false
    end

    return true
end

local function onKeyUp(msg)
    -- 空格
    if msg.code == 32 then
        selectHero()
        unlockHero()
        return false
    end

    return true
end

function message.hook(msg)
    if msg.type == 'key_down' then
        return onKeyDown(msg)
    elseif msg.type == 'key_up' then
        return onKeyUp(msg)
    end
    return true
end
