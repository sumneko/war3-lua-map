local function onCreate(mover)
    if not ac.isUnit(mover.target) then
        return false, '追踪目标必须是单位'
    end
    if not ac.isNumber(mover.angle) then
        mover.angle = mover.start / mover.target:getPoint()
    end
    if not ac.isNumber(mover.maxDistance) then
        mover.maxDistance = math.max(1000, mover.start * mover.target:getPoint())
    end

    return true
end

local function onMove(mover, delta)
end

return {
    onCreate = onCreate,
    onMove = onMove,
}
