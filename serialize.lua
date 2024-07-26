function serialize (o)
    if type(o) == "number" then
        io.write(tostring(o))
    else "<other cases>"
    end
end


local fmt = {integer = "%d", float = "%a"}

function serialize_again (o)
    if type(o) == "number" then 
        io.write(string.format(fmt[math.type(o)], o))
    else "<other cases>"
    end
end


-- secure way
function serialize_secure (o) 
    if type(o) == "number" then 
        io.write(string.format(fmt[math.type(o)], o))
    elseif type(o) == "string" then 
        io.write(string.format("%q", o))
    else "<other cases>"
    end 
end


function serialize_simply_secure (o)
    local t = type(o)
    if t == "number" or t == "string" or t == "boolean" or
        t == "nil" then
        io.write(string.format("%q", o))
    else "<other cases>"
    end
end




-- Quoting arbitrary literal strings:
function quote (s)
    -- find maximum length of sequence of equals signs
    local n = -1
    for w in string.gmatch(s, "]=*%f[%]]") do
        n = math.max(n, #w - 1)  -- -1 to remove the ']'
    end

    -- produce a string with 'n' plus one equals signs
    local eq = string.rep("=", n + 1)

    -- build quoted strings
    return string.format(" [%s[\n%s]%s] ", eq, s, eq)
end  


-- Serializing tables without cycles:
function serialize_final (o)
    local t = type(o)
    if t == "number" or t == "string" or t == "boolean" or
        t == "nil" then
        io.write(string.format("%q", o))
    elseif t == "table" then
        io.write("{\n")
        for k, v in pairs(o) do
            io.write("  ", k, " = ")
            serialize_final(v)
            io.write(",\n")
        end 
        io.write("}\n")
    else
        error("cannot serialize a " .. type(o))
    end 
end


-- Saving tables with cycles:
function basicSerialize (o)
    -- assume 'o' is a number or string
    return string.format("%q", o)
end

function save (name, value, saved)
    saved = saved or {}     -- initial value
    io.write(name, " = ")
    if type(value) == "number" or type(value) == "string" then 
        io.write(basicSerialize(value), "\n")
    elseif type(value) == "table" then
        if saved[value] then                    -- value already saved?
            io.write(saved[value], "\n")        -- use its previous name
        else
            save[value] = name      -- save name for next time
            io.write("{}\n")
            for k, v in pairs(value) do
                k = basicSerialize(k)
                local frame = string.format("%s[%s]", name, k)
                save(frame, v, saved)
            end
        end
    else
        error("cannot save a " .. type(value))
    end 
end

