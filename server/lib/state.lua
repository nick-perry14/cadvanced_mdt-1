state = {}

function state_init(key)
    if not state[key] then
        state[key] = {}
    end
end

function state_get(key)
    if not state[key] then
        state_init(key)
    end
    return state[key]
end

function state_set(key, val)
    if not state[key] then
        state_init(key)
    end
    print("SERVER: UPDATING STATE FOR " .. key)
    state[key] = val
    return state[key]
end
