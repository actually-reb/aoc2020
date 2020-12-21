local PART_TWO = true

io.input("input/08")
local line = io.read()
local program = {}
while line do
    program[#program+1] = line
    line = io.read()
end

local visited = {}
local pc = 1
local acc = 0

local function do_program()
    visited = {}
    pc = 1
    acc = 0
    while true do
        if visited[pc] then break end
        visited[pc] = true
        local op, arg = program[pc]:match("(...) (.+)")
        arg = tonumber(arg)
        if op == "acc" then
            acc = acc + arg
        elseif op == "jmp" then
            pc = pc + arg - 1
        end
        pc = pc + 1
        if pc > #program then break end
    end
    return visited[pc]
end

if not PART_TWO then
    do_program()
    print(acc)
else
    for i=1,#program do
        local op = program[i]:sub(1,3)
        if op ~= "acc" then
            local replace = "nop"
            if op == "nop" then
                replace = "jmp"
            end
            local old = program[i]
            program[i] = replace .. program[i]:sub(4)
            if not do_program() then
                break
            end
            program[i] = old
        end
    end
    print(acc)
end
