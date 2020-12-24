local PART_TWO = true

io.input("input/16")
local line = io.read()
local fields = {}
while line ~= "" do
    local name, r1, r2, r3, r4 = line:match("(.-): (%d+)%-(%d+) or (%d+)%-(%d+)")
    fields[name] = {tonumber(r1), tonumber(r2), tonumber(r3), tonumber(r4)}
    line = io.read()
end
io.read()
local your_ticket = {}
for n in io.read():gmatch("(%d+)") do
    your_ticket[#your_ticket+1] = tonumber(n)
end

local tickets = {}
local acc = 0
while line do
    local t = {}
    local i = 1
    local valid_ticket = true
    for n in line:gmatch("(%d+)") do
        n = tonumber(n)
        local valid = false
        for _, f in pairs(fields) do
            if n >= f[1] and n <= f[2] or n >= f[3] and n <= f[4] then
                t[#t+1] = n
                valid = true
                break
            end
        end
        if not valid then
            acc = acc + n
            valid_ticket = false
        end
        i = i + 1
    end
    if valid_ticket then
        tickets[#tickets+1] = t
    end
    line = io.read()
end
if not PART_TWO then
    print(acc)
    return
end

local slots = {}
for _, t in ipairs(tickets) do
    for k, v in ipairs(t) do
        slots[k] = slots[k] or {}
        for name, f in pairs(fields) do
            if v >= f[1] and v <= f[2] or v >= f[3] and v <= f[4] then
                if slots[k][name] == nil then
                    slots[k][name] = true
                end
            else
                slots[k][name] = false
            end
        end
    end
end

local all_unique = false
while not all_unique do
    all_unique = true
    for _, s in ipairs(slots) do
        local length = 0
        local name
        for k, v in pairs(s) do
            if v then
                length = length + 1
                name = k
            end
        end
        if length == 1 then
            for _, s2 in ipairs(slots) do
                if s ~= s2 then
                    s2[name] = nil
                end
            end
        else
            all_unique = false
        end
    end
end

local result = 1
for index, s in ipairs(slots) do
    for name, _ in pairs(s) do
        if name:find("^departure") then
            result = result * your_ticket[index]
        end
        break
    end
end
print(result)