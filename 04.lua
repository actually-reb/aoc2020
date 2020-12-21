local PART_TWO = true

io.input("input/04")
local line = io.read()
local field_list = {
	byr = function(s)
		local n = tonumber(s)
		return n >= 1920 and n <= 2002
	end,
	iyr = function(s) 
		local n = tonumber(s)
		return n >= 2010 and n <= 2020
	end,
	eyr = function(s)
		local n = tonumber(s)
		return n >= 2020 and n <= 2030
	end,
	hgt = function(s)
		local n, unit = s:match("(%d+)(%l+)")
		n = tonumber(n)
		if unit == "in" then
			return n >= 59 and n <= 76
		elseif unit == "cm" then
			return n >= 150 and n <= 193
		end
		return false
	end,
	hcl = function(s)
		return s:match("^#%x%x%x%x%x%x$")
	end,
	ecl = function(s)
		return s == "amb" or 
		s == "blu" or 
		s == "brn" or 
		s == "gry" or 
		s == "grn" or 
		s == "hzl" or
		s == "oth" 
	end,
	pid = function(s)
		return s:match("^%d%d%d%d%d%d%d%d%d$")
	end
}
local fields = {}
local has_cid = false
local count = 0
local eof = 0

while eof < 2 do
	if line == "" then
		local valid = true
		for field,func in pairs(field_list) do
			local dat = fields[field]
			if dat == nil or not func(dat) then
				valid = false
				break
			end
			if PART_TWO and not func(dat) then
				valid = false
				break
			end
		end
		if valid then count = count + 1 end
		fields = {}
	else
		for k,v in line:gmatch("(%l%l%l):(%S+)") do
			fields[k] = v
		end
	end
	line = io.read()
	if not line then
		line = ""
		eof = eof + 1
	end
end
print(count)