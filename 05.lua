local PART_TWO = true

io.input("input/05")
local ret = 0
local line = io.read()
local lowest_seat = 9999
local seats = {}
while line do
    local lower_row = 0
    local upper_row = 127
    local lower_column = 0
    local upper_column = 8
    for c in line:gmatch(".") do
        if c == "F" then
            upper_row = upper_row - (upper_row - lower_row + 1) // 2
        elseif c == "B" then
            lower_row = lower_row + (upper_row - lower_row + 1) // 2
        elseif c == "L" then
            upper_column = upper_column - (upper_column - lower_column + 1) // 2
        elseif c == "R" then
            lower_column = lower_column + (upper_column - lower_column + 1) // 2
        end
    end
    local result = lower_row * 8 + lower_column
    if not PART_TWO then
        if result > ret then ret = result end
    else
        if result < lowest_seat then lowest_seat = result end
        seats[result] = true
    end
    line = io.read()
end
if not PART_TWO then
    print(ret)
else
    local i = lowest_seat + 1
    while seats[i] do i = i + 1 end
    print(i)
end
