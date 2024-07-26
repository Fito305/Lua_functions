-- The following function illustrates the use of debug.getinfo by printing
-- a primitve traceback of the active stack:
function traceback()
    for level = 1, math.huge do
        local info = debug.getinfo(level, "S1")
        if not info then break end
        if info.what == "C" then -- is a C function?
            print(string.format("%d\tC function", level))
        else                     -- a Lua function
            print(string.format("%d\t[%s]:%d", level,
                info.short_src, info.currentline))
        end
    end
end
