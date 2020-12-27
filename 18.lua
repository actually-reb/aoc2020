local PART_TWO = true

local operation = {
    ["+"] = function(stack)
        stack[#stack-1] = stack[#stack-1] + stack[#stack]
        stack[#stack] = nil
    end,
    ["*"] = function(stack)
        stack[#stack-1] = stack[#stack-1] * stack[#stack]
        stack[#stack] = nil
    end
}

local function evaluate(str)
    if str:match("%b()") == str then
        str = str:sub(2, -2)
    end
    str = str:gsub("%b()", evaluate)
    local stack = {}
    local op_stack = {}
    for token in str:gmatch("%S+") do
        if operation[token] then
            if PART_TWO then
                while token == "*" and op_stack[#op_stack] == "+" do
                    operation["+"](stack)
                    op_stack[#op_stack] = nil
                end
            else
                while op_stack[#op_stack] do
                    operation[op_stack[#op_stack]](stack)
                    op_stack[#op_stack] = nil
                end 
            end
            op_stack[#op_stack+1] = token
        else
            stack[#stack+1] = tonumber(token)
        end
    end
    for i = #op_stack, 1, -1 do
        operation[op_stack[i]](stack)
    end
    return stack[1]
end

local sum = 0
for line in io.lines("input/18") do
    sum = sum + evaluate(line)
end
print(sum)