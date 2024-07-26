local function new(r, i) return { r = r, i = i } end

-- defines constant 'i'
local i = complex.new(0, 1)

-- <other functions follow the same pattern>

return {
    new = new,
    i = i,
    add = add,
    sub = sub,
    mul = mul,
    div = div,
    tostring = tostring,
}
