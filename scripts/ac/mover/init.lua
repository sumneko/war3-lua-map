local moverTarget = require 'ac.mover.target'

local mt = {}
mt.__index = mt

mt.type = 'mover'
mt.source = nil
mt.speed = 1000.0

local Movers = {}

local function callMethod(mover, name, ...)
    local method = mover[name]
    if not method then
        return
    end
    local suc, res = xpcall(method, log.error, ...)
    if suc then
        return res
    end
end

local function updateMove(mover, delta)
    mover.project.onMove(delta)
end

local function updateFinish(mover)
    if mover._finish then
        callMethod(mover, 'onFinish')
        mover:remove()
    end
end

local function update(delta)
    local max = #Movers
    -- 1. 更新移动
    for i = 1, max do
        local mover = Movers[i]
        if mover then
            updateMove(mover, delta)
        end
    end

    -- 2. 检查碰撞

    -- 3. 检查完成
    for i = 1, max do
        local mover = Movers[i]
        if mover then
            updateFinish(mover)
        end
    end
end

local function addList(mover)
    local n = #Movers+1
    Movers[n] = mover
    Movers[mover] = n
end

local function removeList(mover)
    local n = Movers[mover]
    if not n then
        return
    end
    Movers[n] = false
    Movers[mover] = nil
end

local function createMover(mover)
    if ac.isUnit(mover.mover) then
        return true
    end
    if type(mover.mover) == 'string' then
        local dummy = mover.source:createUnit(mover.mover, mover.start, mover.angle)
        if dummy then
            mover.mover = dummy
            mover._needKillMover = true
            return true
        end
    end
    if mover.model then
        local dummy = mover.source:createUnit('@运动马甲', mover.start, mover.angle)
        if dummy then
            mover.mover = dummy
            mover._needKillMover = true
            dummy:particle(mover.model, 'origin')
            return true
        end
    end
    return false, '没有运动单位'
end

local function computeParams(mover)
    if not ac.isUnit(mover.source) then
        return nil, '来源必须是单位'
    end
    if not ac.isPoint(mover.start) then
        mover.start = mover.source:getPoint()
    end
    return true
end

local function create(data)
    local mover = setmetatable(data, mt)

    if mover.moverType == 'target' then
        mover.project = moverTarget
    else
        return nil, '未知的运动类型'
    end

    local ok, err = computeParams(mover)
    if not ok then
        return nil, err
    end

    local ok, err = mover.project.onCreate(mover)
    if not ok then
        return nil, err
    end

    local ok, err = createMover(mover)
    if not ok then
        return nil, err
    end

    addList(mover)

    return mover
end

function mt:remove()
    if self._removed then
        return
    end
    self._removed = true
    removeList(self)
    if self._needKillMover then
        self.mover:kill()
    end
end

function mt:finish()
    self._finish = true
end

function mt:setAngle(angle)
    self._angle = angle
    self.mover:setFacing(angle)
end

return {
    update = update,
    create = create,
}
