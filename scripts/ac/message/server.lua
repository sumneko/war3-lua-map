local jass = require 'jass.common'
local ORDER = require 'ac.war3.order'
local PROTO = require 'ac.message.proto'
local TRG = jass.CreateTrigger()

local EVENT = {
    Order       = jass.EVENT_PLAYER_UNIT_ISSUED_ORDER,
    PointOrder  = jass.EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER,
    TargetOrder = jass.EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER,
}

for i = 0, 15 do
    jass.TriggerRegisterPlayerUnitEvent(TRG, jass.Player(i), EVENT.Order, nil)
    jass.TriggerRegisterPlayerUnitEvent(TRG, jass.Player(i), EVENT.PointOrder, nil)
    jass.TriggerRegisterPlayerUnitEvent(TRG, jass.Player(i), EVENT.TargetOrder, nil)
end

local function pointOrder(unit, order, point)
    local x, y = point:getXY()
    jass.IssuePointOrderById(unit._handle, ORDER[order], x, y)
end

local function onProto(unit, id, arg)
    if id == PROTO['Sleep'] then
        local skill = unit:findSkill '@命令'
        if not skill then
            return
        end
        local order = skill:getOrder()
        if not order then
            return
        end
    end
end

local function onPointOrder(unit)
    local orderId = jass.GetIssuedOrderId()
    if orderId == ORDER['AImove'] then
        local id = jass.GetOrderPointX()
        local arg = jass.GetOrderPointY()
        onProto(unit, id, arg)
        return
    end
end

-- 命令事件
jass.TriggerAddCondition(TRG, jass.Condition(function ()
    local eventId = jass.GetTriggerEventId()
    local unit = ac.unit(jass.GetTriggerUnit())
    if not unit then
        return
    end
    if eventId == EVENT.PointOrder then
        onPointOrder(unit)
    end
end))
