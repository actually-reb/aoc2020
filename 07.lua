local PART_TWO = true

local bags = {}

local function bag_has_gold(bag)
    if bag.has_gold == nil then
        for color,_ in pairs(bag.contents) do
            if bag_has_gold(bags[color]) then
                bag.has_gold = true
                return true
            end
        end
    else
        return bag.has_gold
    end
    return false
end

local function amount_in(bag)
    local count = 0
    for color,num in pairs(bag.contents) do
        count = count + amount_in(bags[color]) * num + num
    end
    return count
end

io.input("input/07")
local line = io.read()
while line do
    local color, contents = line:match("(.+) bags contain (.+)")
    bags[color] = {}
    bags[color].contents = {}
    if contents:find("%d") then
        local bag_contents = bags[color].contents
        for content_num, content_color in contents:gmatch("(%d+) (.-) bag[s]?[,%.]") do
            bag_contents[content_color] = content_num
            if content_color == "shiny gold" then
                bags[color].has_gold = true
            end
        end
    else
        bags[color].has_gold = false
    end
    line = io.read()
end

if not PART_TWO then
    local count = 0
    for color,bag in pairs(bags) do
        if bag_has_gold(bag) then count = count + 1 end
    end
    print(count)
else
    print(amount_in(bags["shiny gold"]))
end
