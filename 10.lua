local PART_TWO = true

local nums = {}
io.input("input/10")
local line = io.read()
nums[1] = 0
while line do
    nums[#nums+1] = tonumber(line)
    line = io.read()
end
table.sort(nums)
nums[#nums+1] = nums[#nums] + 3

if not PART_TWO then
    local diffs = {}
    diffs[1] = 0
    diffs[2] = 0
    diffs[3] = 0
    for i=2, #nums do
        local d = nums[i] - nums[i-1]
        diffs[d] = diffs[d] + 1
    end
    print(diffs[1] * diffs[3])
else
    local diffs = {}
    for i=2, #nums - 1 do
        local d = nums[i] - nums[i-1]
        diffs[#diffs+1] = d
    end
    local runs = {}
    runs[1] = 0
    for _,v in ipairs(diffs) do
        if v == 1 then
            runs[#runs] = runs[#runs] + 1
        else
            runs[#runs+1] = 0
        end
    end
    local total = 1
    for _,v in ipairs(runs) do
        v = v - 1
        if v > 0 then
            -- ok, WTF is going on here?
            -- this is all unnessesary because the amount of adapters that can
            -- be left out in a path is never going to exceed 3.
            -- ...but i did it properly(?) anyway
            local count = 0
            for i = 0, (1 << v) - 1 do
                local off = 0
                local valid = true
                for j = 0, v - 1 do
                    if i & (1 << j) > 0 then
                        off = 0
                    else
                        off = off + 1
                    end
                    if off > 2 then
                        valid = false
                        break
                    end
                end
                if valid then
                    count = count + 1
                end
            end
            total = total * count
        end
    end
    print(total)
end