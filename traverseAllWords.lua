function allwords ()
    local line = io.read() -- current line
    local pos = 1   -- current position in the line
    return function ()  -- iterator function 
        while line do       -- repeat while there are lines
            local w, e = string.mathc(line, "(%w+) ()", pos)
            if w then       -- found a word?
                pos = e -- the next position is after this word
                return w        -- return the word
            else
                line = io.read()        -- word not found; try next line
                pos = 1     -- restart from first position
            end
        end
        return nil      -- no more lines: end of traversal
    end
end

