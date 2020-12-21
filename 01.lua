local PART_TWO = true

local arr = {}
local map = {}
io.input("input/01")
local line = io.read()
while line do
	local num = tonumber(line)
	arr[#arr+1] = num
	map[num] = true
	line = io.read()
end

if not PART_TWO then
	for _,v in ipairs(arr) do
		local find = 2020 - v
		if map[find] then
			print(v * find)
			return
		end
	end
else
	for _,v in ipairs(arr) do
		local sum_to = 2020 - v
		for _,w in ipairs(arr) do
			local find = sum_to - w
			if map[find] then
				print(v * w * find)
				return
			end
		end
	end
end