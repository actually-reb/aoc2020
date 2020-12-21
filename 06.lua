local PART_TWO = true

local function customs(t)
    local questions = {}
    local count = 0
    for _,answers in ipairs(t) do
        for q in answers:gmatch(".") do
            questions[q] = (questions[q] or 0) + 1
            if not PART_TWO and questions[q] == 1 then
                count = count + 1
            end
        end
    end
    for _,v in pairs(questions) do
        if v == #t then count = count + 1 end
    end
    return count
end

io.input("input/06")
local line = io.read()
local group = {}
local sum = 0
while line do
    if line == "" then
        sum = sum + customs(group)
        group = {}
    else
        group[#group+1] = line
    end
    line = io.read()
end
sum = sum + customs(group)
print(sum)