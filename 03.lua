local PART_TWO = true

io.input("input/03")
local line = io.read()
local map = {}
while line do
	map[#map+1] = line
	line = io.read()
end

local function get_tile(x, y)
	if not map[y] then return nil end
	x = (x-1) % 31 + 1
	return map[y]:sub(x, x)
end

local function get_slope(x, y)
	local xpos, ypos = 1 + x, 1 + y
	local char = get_tile(xpos, ypos)
	local count = 0
	while char do
		if char == "#" then count = count + 1 end
		xpos = xpos + x
		ypos = ypos + y
		char = get_tile(xpos, ypos)
	end
	return count
end

if PART_TWO then
	local slopes = {{1,1}, {3,1}, {5,1}, {7,1}, {1,2}}
	local result = 1
	for _, slope in ipairs(slopes) do
		result = result * get_slope(slope[1], slope[2])
	end
	print(result)
else
	print(get_slope(3, 1))
end