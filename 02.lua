local PART_TWO = true

io.input("input/02")
local line = io.read()
local count = 0
while line do
	local first, second = line:match("(%d+)-(%d+)")
	first = tonumber(first)
	second = tonumber(second)
	local letter = line:match("(.):")
	local password = line:match(": (%a+)")
	
	if not PART_TWO then
		local _, n = password:gsub(letter, "")
		if n >= first and n <= second then
			count = count + 1
		end
	else
		local valid = false
		if password:sub(first, first) == letter then
			valid = not valid
		end
		if password:sub(second, second) == letter then 
			valid = not valid
		end
		if valid then
			count = count + 1
		end
	end
	
	line = io.read()
end
print(count)