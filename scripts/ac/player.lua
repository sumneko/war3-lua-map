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

function ac.player(id)
    if not All[id] then
        return create(id)
    end
    return All[id]
end
