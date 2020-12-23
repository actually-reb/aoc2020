local PART_TWO = true

io.input("input/13")

local function part_one()
    local timestamp = tonumber(io.read())
    local id
    local wait = math.huge
    for n in io.read():gmatch("%P+") do
        n = tonumber(n)
        if n then
            local w = n - timestamp % n
            if w < wait then
                wait = w
                id = n
            end
        end
    end
    print(id * wait)
end

local function inverse(x, m)
    -- theres no force like brute force!
    local a = 1
    while (a * x) % m ~= 1 do
        a = a + 1
    end
    return a
end

local function subsequent()
    io.read()
    local id = {}
    local offset = {}
    local M = 1 -- product of all IDs
    local i = 0
    for n in io.read():gmatch("%P+") do
        n = tonumber(n)
        if n then
            id[#id+1] = n
            offset[#offset+1] = i
            M = M * n
        end
        i = i + 1
    end
    local acc = 0
    for k, v in ipairs(id) do
        local m = M//v -- make sure this is floor division because floats
        -- can't handle the big numbers
        -- maybe its that terrible inverse function up there
        local a = ((v - offset[k]) % v)
        local y = inverse(m, v)
        acc = acc + a * m * y
    end
    print(string.format("%.f", acc % M))
end

if not PART_TWO then
    part_one()
else
    subsequent()
end