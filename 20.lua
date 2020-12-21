local PART_TWO = true --no part 2 yet

io.input("input/20")
local line = io.read()
local tiles = {}
local read_tile = {}
local block = {}
while line do
    if line == "" then
        local edges = {}
        edges[1] = block[1]
        edges[3] = block[#block]
        edges[2] = ""
        edges[4] = ""
        for _,v in ipairs(block) do
            edges[2] = edges[2] .. v:sub(-1)
            edges[4] = edges[4] .. v:sub(1, 1)
        end
        local data = {}
        for i=2, 9 do
            data[#data+1] = block[i]:sub(2, 9)
        end
        read_tile.edges = edges
        read_tile.data = data
        read_tile.matched = {false, false, false, false}
        tiles[#tiles+1] = read_tile
        block = {}
        read_tile = {}
    else
        if line:match("%d+") then
            read_tile.id = line:match("%d+")
        else
            block[#block+1] = line
        end
    end

    line = io.read()
end

local function find_matches(t, e, en)
    for _,t2 in ipairs(tiles) do
        if t2 ~= t then 
            for en2,e2 in ipairs(t2.edges) do
                if not t2.matched[en2] and e == e2 or e:reverse() == e2 then
                    t.matched[en] = t.id
                    t2.matched[en2] = t2.id
                    return
                end
            end
        end
    end
end

for _,t in ipairs(tiles) do
    for en,e in ipairs(t.edges) do
        if not t.matched[en] then
            find_matches(t, e, en)
        end
    end
end

local out = 1
for _,t in ipairs(tiles) do
    local count = 0
    for _,v in ipairs(t.matched) do
        if v then
            count = count + 1
        end
    end
    if count == 2 then
        out = out * t.id
    end
end

if not PART_TWO then
    print(out)
    return
end

local map_width = 96
