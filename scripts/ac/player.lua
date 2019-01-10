local jass = require 'jass.common'

local MIN_ID = 1
local MAX_ID = 16
local All = {}
local mt = {}

local function create(id)
    if id < MIN_ID or id > MAX_ID then
        return nil
    end
    local player = setmetatable({
        _handle = jass.Player(id - 1),
        _id = id,
    }, mt)
    All[id] = player

    return player
end

mt.__index = mt

function mt:event(name)
    return ac.event_register(self, name)
end

function mt:eventDispatch(name, ...)
    local res = ac.eventDispatch(self, name, ...)
    if res ~= nil then
        return res
    end
    local res = ac.game:eventDispatch(ac.game, name, ...)
    if res ~= nil then
        return res
    end
    return nil
end

function mt:eventNotify(name, ...)
    ac.eventNotify(self, name, ...)
    ac.game:eventNotify(name, ...)
end

function ac.player(id)
    if not All[id] then
        return create(id)
    end
    return All[id]
end
