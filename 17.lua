local PART_TWO = true

local function new_grid(dim)
    local metatable = {}
    for i = dim, 2, -1 do
        metatable[i] = {
            __index = function(t, k)
                t[k] = {}
                if i > 2 then
                    t[k] = setmetatable(t[k], metatable[i-1])
                end
                return t[k]
            end,
        }
    end
    return setmetatable({}, metatable[dim])
end

local function grid_iterate(grid, dim, recursive_dim)
    return coroutine.wrap(function()
        recursive_dim = recursive_dim or dim
        if recursive_dim > 1 then
            for key, gridval in pairs(grid) do
                for coords, v in grid_iterate(gridval, dim, recursive_dim - 1) do
                    coords[dim - recursive_dim + 1] = key
                    coroutine.yield(coords, v)
                end
            end
        else
            for k, v in pairs(grid) do
                coroutine.yield({[dim] = k}, v)
            end
        end
    end)
end

local function all_zero(t)
    for _, v in ipairs(t) do
        if v ~= 0 then
            return false
        end
    end
    return true
end

local cached_surrounding_coords = {}
local function surrounding_coords(coords)
    local dim = #coords
    if not cached_surrounding_coords[dim] then
        local add = {}
        local cached = {}
        cached_surrounding_coords[dim] = cached
        for i = 1, dim do
            add[i] = -1
        end
        while add[1] < 2 do
            if not all_zero(add) then
                local t = {}
                for k, v in ipairs(add) do
                    t[k] = v
                end
                cached[#cached+1] = t
            end
            add[dim] = add[dim] + 1
            local i = dim
            while add[i] > 1 do
                add[i] = -1
                add[i-1] = add[i-1] + 1
                i = i > 2 and i - 1 or 2
            end
        end
    end
    local ret = {}
    for k, add in ipairs(cached_surrounding_coords[dim]) do
        local t = {}
        for i = 1, dim do
            t[i] = coords[i] + add[i]
        end
        ret[k] = t
    end
    return ret
end

local function grid_get(grid, coords)
    for i = 1, #coords do
        grid = grid[coords[i]]
    end
    return grid
end

local function grid_set(grid, coords, val)
    local len = #coords
    for i = 1, len - 1 do
        grid = grid[coords[i]]
    end
    grid[coords[#coords]] = val
end

local function grid_inc(grid, coords)
    local len = #coords
    for i = 1, len - 1 do
        grid = grid[coords[i]]
    end
    grid[coords[len]] = (grid[coords[len]] or 0) + 1
end

local function read_input(grid, dim)
    io.input("input/17")
    local line = io.read()
    local y = 1
    local coords = {}
    for i = 1, dim do
        coords[i] = 0
    end
    while line do
        local x = 1
        for c in line:gmatch(".") do
            if c == "#" then
                coords[1] = x
                coords[2] = y
                grid_set(grid, coords, true)
            end
            x = x + 1
        end
        y = y + 1
        line = io.read()
    end
end

local dimentions = 3
if PART_TWO then
    dimentions = 4
end

local world = new_grid(dimentions)
read_input(world, dimentions)
for i = 1, 6 do
    local scratch = new_grid(dimentions)
    for coords, v in grid_iterate(world, dimentions) do
        if v then
            for _, scratch_coords in ipairs(surrounding_coords(coords)) do
                grid_inc(scratch, scratch_coords)
            end
        end
    end
    local new_world = new_grid(dimentions)
    for coords, v in grid_iterate(scratch, dimentions) do
        if v == 3 or v == 2 and grid_get(world, coords) then
            grid_set(new_world, coords, true)
        end
    end
    world = new_world
end

local count = 0
for coords, v in grid_iterate(world, dimentions) do
    if v then
        count = count + 1
    end
end
print(count)