-- mapgen.lua
-- 空岛初始平台与树木生成

local PLATFORM_Y = 1
local PLATFORM_SIZE = 7
local PLATFORM_NODE = "skyblock:world_foundation"
local TRUNK_NODE = "skyblock:world_branch"
local LEAVES_NODE = "skyblock:world_leaves"

-- 全局函数：在任意位置生成一棵世界之树
-- 参数 pos: 树苗所在的位置（树将替换该节点作为树干底部）
function skyblock_generate_tree(pos)
    local x, y, z = pos.x, pos.y, pos.z

    -- 树干：从树苗位置向上 5 格
    for dy = 0, 4 do
        minetest.set_node({x = x, y = y + dy, z = z}, {name = TRUNK_NODE})
    end

    -- 树冠：在树干第四、五层周围生成树叶
    local leaf_y1 = y + 3   -- 第四层
    local leaf_y2 = y + 4   -- 第五层（树顶）

    -- 第四层十字形树叶
    for dx = -1, 1 do
        for dz = -1, 1 do
            if dx == 0 and dz == 0 then
                -- 中心留给树干
                minetest.set_node({x = x, y = leaf_y1, z = z}, {name = TRUNK_NODE})
            elseif (dx == 0 or dz == 0) then
                minetest.set_node({x = x + dx, y = leaf_y1, z = z + dz}, {name = LEAVES_NODE})
            end
        end
    end
    -- 四角额外树叶（丰满一点）
    for dx = -1, 1, 2 do
        for dz = -1, 1, 2 do
            minetest.set_node({x = x + dx, y = leaf_y1, z = z + dz}, {name = LEAVES_NODE})
        end
    end

    -- 第五层（树顶）十字形树叶，中心换树叶
    minetest.set_node({x = x, y = leaf_y2, z = z}, {name = LEAVES_NODE})
    for _, off in ipairs({{1,0},{-1,0},{0,1},{0,-1}}) do
        minetest.set_node({x = x + off[1], y = leaf_y2, z = z + off[2]}, {name = LEAVES_NODE})
    end

    minetest.log("action", "[skyblock] Tree grown at " .. minetest.pos_to_string(pos))
end

-- 检查平台是否存在
local function platform_exists()
    local half = math.floor(PLATFORM_SIZE / 2)
    local pos = {x = -half, y = PLATFORM_Y, z = -half}
    return minetest.get_node(pos).name == PLATFORM_NODE
end

-- 检查初始树是否存在
local function tree_exists()
    local pos = {x = 0, y = PLATFORM_Y + 1, z = 0}
    return minetest.get_node(pos).name == TRUNK_NODE
end

-- 生成平台
local function generate_platform()
    if platform_exists() then return end
    local half = math.floor(PLATFORM_SIZE / 2)
    for x = -half, half do
        for z = -half, half do
            minetest.set_node({x = x, y = PLATFORM_Y, z = z}, {name = PLATFORM_NODE})
        end
    end
    minetest.log("action", "[skyblock] Platform generated at y=" .. PLATFORM_Y)
end

-- 生成初始树
local function generate_initial_tree()
    generate_platform()
    if tree_exists() then return end
    skyblock_generate_tree({x = 0, y = PLATFORM_Y + 1, z = 0})
end

-- 区块加载时补全
minetest.register_on_generated(function(minp, maxp, seed)
    if minp.x <= 0 and maxp.x >= 0 and minp.z <= 0 and maxp.z >= 0 then
        generate_initial_tree()
    end
end)

minetest.log("action", "[skyblock] Mapgen ready. Platform: " .. PLATFORM_SIZE .. "x" .. PLATFORM_SIZE)