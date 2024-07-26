local results = {}

setmetatable(results, {__mode = "v"}) -- make values weak (1)
-- setmetatable(results, {__mode = "kv"}) (2)


-- This behavior will exhaust the server's memory.(1)
function mem_loadstring (s)
    local res = results[s]
    if res == nil then      -- result not available?
        res = assert(load(s))   -- compute new result
        results[s] = res
    end
    return res
end

-- (1) A weak table provides a simple solution to this problem. If the
-- results table has weak values, each garbage collection cycle will remove
-- all translations not in use at that moment (which means virtually all of them).
-- (2) Actually, because the indices are always strings, we can make this table 
-- fully weak, if we want.
