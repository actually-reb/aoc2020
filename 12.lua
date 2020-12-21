local PART_TWO = true

local way_x = 10
local way_y = 1
local pos_x = 0
local pos_y = 0
local facing = "E"
local directions = "NESW"
local actions
if not PART_TWO then
    actions = {
        ["N"] = function(n)
            pos_y = pos_y + n
        end,
        ["E"] = function(n)
            pos_x = pos_x + n
        end,
        ["S"] = function(n)
            pos_y = pos_y - n
        end,
        ["W"] = function(n)
            pos_x = pos_x - n
        end,
        ["F"] = function(n)
            actions[facing](n)
        end,
        ["R"] = function(n)
            n = n / 90
            local dir_index = directions:find(facing)
            dir_index = (dir_index + n - 1) % 4 + 1
            facing = directions:sub(dir_index, dir_index)
        end,
        ["L"] = function(n)
            actions["R"](math.abs(n - 360))
        end
    }
else
    actions = {
        ["N"] = function(n)
            way_y = way_y + n
        end,
        ["E"] = function(n)
            way_x = way_x + n
        end,
        ["S"] = function(n)
            way_y = way_y - n
        end,
        ["W"] = function(n)
            way_x = way_x - n
        end,
        ["F"] = function(n)
            pos_x = pos_x + way_x * n
            pos_y = pos_y + way_y * n
        end,
        ["R"] = function(n)
            for i = 1, n / 90 do
                local tmp = way_y
                way_y = -way_x
                way_x = tmp
            end
        end,
        ["L"] = function(n)
            actions["R"](math.abs(n - 360))
        end
    }
end

io.input("input/12")
local line = io.read()
while line do
    local action, value = line:match("(%u)(%d+)")
    value = tonumber(value)
    actions[action](value)
    line = io.read()
end
print(math.abs(pos_x) + math.abs(pos_y))