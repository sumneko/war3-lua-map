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
    local me, dest = mover.mover:getPoint(), mover.target:getPoint()
    local angle = me / dest
    local distance = me * dest
    local step = mover.speed * delta / 1000
    mover:setAngle(angle)
    if step >= distance then
        mover.mover:setPoint(dest)
        mover:setProcess(1.0)
        mover:finish()
    else
        mover.mover:setPoint(me - {angle, step})
        mover:stepProcess(step / distance)
    end
end

local function getAngle(mover)
end

return {
    onCreate = onCreate,
    onMove = onMove,
    getAngle = getAngle,
}
