local PART_TWO = true

local nums = {}
io.input("input/09")
local line = io.read()
while line do
    nums[#nums+1] = tonumber(line)
    line = io.read()
end

local invalid
for i = 26, #nums do
    local found = false
    for j = i - 25, i - 2 do
        for k = j + 1, i - 1 do
            if nums[j] + nums[k] == nums[i] and nums[j] ~= nums[k] then
                found = true
                goto found
            end
        end
    end
    ::found::
    if not found then
        invalid = nums[i]
    end
end

if not PART_TWO then
    print(invalid)
else
    for k,v in ipairs(nums) do
        local sum = v + nums[k + 1]
        local range = 1
        while sum < invalid do
            range = range + 1
            sum = sum + nums[k + range]
        end
        if sum == invalid then
            local min = v
            local max = v
            for i = k + 1, k + range do
                if nums[i] < min then min = nums[i] end
                if nums[i] > max then max = nums[i] end
            end
            print(min + max)
            break
        end
    end
end