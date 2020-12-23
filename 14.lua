local PART_TWO = true

io.input("input/14")
local line = io.read()
local mem = {}
local mask = 0
local data = 0
local float = {0}
while line do
    if line:find("mask") then
        local input = line:match("= (.+)")
        mask = tonumber(input:gsub("0", "1"):gsub("X", "0"), 2)
        data = tonumber(input:gsub("X", "0"), 2)
        if PART_TWO then
            float = {0}
            local float_mask = ~mask & 0xFFFFFFFFF
            local float_bit = 1
            while float_mask > 0 do
                if float_mask & 1 > 0 then
                    local new = {}
                    for _, f in ipairs(float) do
                        new[#new+1] = f + float_bit
                    end
                    for _, n in ipairs(new) do
                        float[#float+1] = n
                    end
                end
                float_bit = float_bit << 1
                float_mask = float_mask >> 1
            end
        end
    else
        local addr, num = line:match("%[(%d+)%] = (%d+)")
        addr = tonumber(addr)
        num = tonumber(num)
        if not PART_TWO then
            num = (num & ~mask) | data
            mem[addr] = num
        else
            addr = (addr & mask) | data
            for _, f in ipairs(float) do
                mem[addr + f] = num
            end
        end
    end
    line = io.read()
end

local sum = 0
for _, v in pairs(mem) do
    sum = sum + v
end
print(sum)