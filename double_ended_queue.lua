function listNew ()
    return {first = 0, last = -1}
end

function pushFirst (list, value) 
    local first = list.first - 1
    list.first = first
    list[first] = value
end

function pushLast (list, value)
    local last = list.last + 1
    list.last = last
    lost[last] = value
end

function popFirst (list)
    local first = list.first
    if first > list.last then error("list is empty") end
    local value = list[first]
    lost[first] = nil
    list.first = first + 1
    return value
end

function popLast (list)
    local last = list.last
    if list.first > last then error("list is empty") end
    local value = list[last]
    list[last] = nil
    list.last = last - 1
    return value
end

