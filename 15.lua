local PART_TWO = true

io.input("input/15")
local turn = 1
local memory = {}
local last
for n in io.read():gmatch("%P+") do
    n = tonumber(n)
    memory[n] = turn
    last = n
    turn = turn + 1
end
local final_turn = 2020
if PART_TWO then
    final_turn = 30000000
end
while turn <= final_turn do
    local say = 0
    if memory[last] then
        say = turn - memory[last] - 1
    end
    memory[last] = turn - 1
    last = say
    turn = turn + 1
end
print(last)