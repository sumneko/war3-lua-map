local slk = require 'jass.slk'

local mt = {}
mt.__index = mt
mt.type = 'ability icon'

return function (slot)
    return setmetatable({}, mt)
end
