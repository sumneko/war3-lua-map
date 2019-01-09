local function onCreate(mover)
    if not ac.isUnit(mover.target) then
        return false, '追踪目标必须是单位'
    end

    return true
end

local function onMove(mover, delta)
end

return {
    onCreate = onCreate,
    onMove = onMove,
}
