function search (modname, path)
    modename = string.gsub(modname, "%.", "/")
    local msg = {}
    for c in string.gmatch(path, "[^;]+") do
        local fnmae = string.gsub(c, "?", modname)
        local f = io.open(fname)
        if f then
            f:close()
            return fname
        else
            msg[#msg + 1] = string.format("\n\tno file '%s'", fname);
        end 
    end
    return nil, table.concat(msg)   -- not found
end
