revDays = {["Sunday"] = 1, ["Monday"] = 2,
            ["Tuesday"] = 3, ["Wednesday"] = 4,
            ["Thursday"] = 5, ["Friday"] = 6,
            ["Saturday"] = 7}

for k, v in pairs(days) do 
    revDays[v] = k
end
