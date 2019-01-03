ac.event = {}

function ac.event_dispatch(obj, name, ...)
    local events = obj._events
    if not events then
        return
    end
    local event = events[name]
    if not event then
        return
    end
    for i = #event, 1, -1 do
        local res, arg = event[i](...)
        if res ~= nil then
            return res, arg
        end
    end
end

function ac.event_notify(obj, name, ...)
    local events = obj._events
    if not events then
        return
    end
    local event = events[name]
    if not event then
        return
    end
    for i = #event, 1, -1 do
        event[i](...)
    end
end

function ac.event_register(obj, name, f)
    local events = obj._events
    if not events then
        events = {}
        obj._events = events
    end
    local event = events[name]
    if not event then
        event = {}
        events[name] = event
        function event:remove()
            events[name] = nil
        end
    end
    return ac.trigger(event, f)
end

function ac.game:event_dispatch(name, ...)
    return ac.event_dispatch(self, name, ...)
end

function ac.game:event_notify(name, ...)
    return ac.event_notify(self, name, ...)
end

function ac.game:event(name, f)
    return ac.event_register(self, name, f)
end
