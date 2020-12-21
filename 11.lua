local PART_TWO = true

local function iter_map(m)
    local x = 0
    local y = 1
    return function()
        x = x + 1
        if x > #m[y] then
            y = y + 1
            x = 1
        end
        if m[y] then
            return x, y, m[y][x]
        end
    end
end

local function count_surround(m, x, y)
    local count = 0
    for i = -1, 1 do
        for j = -1, 1 do
            if j == 0 and i == 0 then
                goto continue
            end
            local old_i, old_j = i, j
            if PART_TWO then
                local vi = i
                local vj = j
                while m[y + j] and m[y + j][x + i] == "." do
                    i = i + vi
                    j = j + vj
                end
            end
            if m[y + j] and m[y + j][x + i] == "#" then
                count = count + 1
            end
            i, j = old_i, old_j
            ::continue::
        end
    end
    return count
end

io.input("input/11")
local line = io.read()
local map = {}
while line do
    local row = {}
    map[#map+1] = row
    for c in line:gmatch(".") do
        row[#row+1] = c
    end
    line = io.read()
end

local changed = true
while changed do
    changed = false
    local new_map = {}
    for i=1, #map do
        new_map[i] = {}
    end
    for x, y, c in iter_map(map) do
        new_map[y][x] = c
        if c == "L" then
            if count_surround(map, x, y) == 0 then
                changed = true
                new_map[y][x] = "#"
            end
        elseif c == "#" then
            local tolerance = 4
            if PART_TWO then
                tolerance = 5
            end
            if count_surround(map, x, y) >= tolerance then
                changed = true
                new_map[y][x] = "L"
            end
        end
    end
    map = new_map
end


local occupied = 0
for _, _, c in iter_map(map) do
    if c == "#" then 
        occupied = occupied + 1
    end
end
print(occupied)
