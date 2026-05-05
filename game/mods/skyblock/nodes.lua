-- nodes.lua
-- 存放所有自定义方块的定义

-- 注册空手工具（确保能够挖掘方块）
minetest.register_item(":", {
    type = "none",
    wield_scale = {x = 1, y = 1, z = 1},           -- 手部大小
    tool_capabilities = {
        full_punch_interval = 1.0,                  -- 攻击间隔
        max_drop_level = 0,                          -- 挖掘等级
        groupcaps = {
            -- 用手可以挖掘所有设置了 oddly_breakable_by_hand 的方块
            choppy = {times = {[1] = 3.0, [2] = 2.0, [3] = 1.0}, uses = 0, maxlevel = 0},
            snappy = {times = {[1] = 1.5, [2] = 1.0, [3] = 0.5}, uses = 0, maxlevel = 0},
            cracky = {times = {[1] = 3.0, [2] = 2.0, [3] = 1.0}, uses = 0, maxlevel = 0},
            crumbly = {times = {[1] = 2.0, [2] = 1.5, [3] = 1.0}, uses = 0, maxlevel = 0},  -- 调慢
        },
        damage_groups = {fleshy = 1},                -- 徒手伤害
    }
})

-- 本地音效定义 (不依赖 default 模组)
local stone_sounds = {
    footstep = {name = "default_hard_footstep", gain = 0.3},
    dig = {name = "default_dig_crumbly", gain = 0.5},
    place = {name = "default_place_node_hard", gain = 1.0},
    dug = {name = "default_hard_footstep", gain = 1.0},
}

local wood_sounds = {
    footstep = {name = "default_hard_footstep", gain = 0.2},
    dig = {name = "default_dig_choppy", gain = 0.5},
    place = {name = "default_place_node", gain = 1.0},
    dug = {name = "default_hard_footstep", gain = 1.0},
}

local leaves_sounds = {
    footstep = {name = "default_grass_footstep", gain = 0.3},
    dig = {name = "default_dig_snappy", gain = 0.4},
    place = {name = "default_place_node", gain = 1.0},
    dug = {name = "default_grass_footstep", gain = 0.9},
}

-- 世界基石
minetest.register_node("skyblock:world_foundation", {
    description = "世界基石",
    tiles = {
        "stone.png"
    },
    groups = {immortal = 1},
    drawtype = "normal",
    paramtype = "light",
    is_ground_content = true,
    sunlight_propagates = true,
    sounds = stone_sounds,
    drop = "",
    on_blast = function() end,
})

-- 世界枝干（树干）
minetest.register_node("skyblock:world_branch", {
    description = "世界枝干",
    tiles = {"wood_top.png", "wood_top.png", "wood_side.png"},
    groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
    drawtype = "normal",
    paramtype = "light",
    is_ground_content = false,
    sunlight_propagates = true,
    sounds = wood_sounds,
    drop = "skyblock:world_branch",
})

-- 世界枝叶（树叶）
minetest.register_node("skyblock:world_leaves", {
    description = "世界枝叶",
    tiles = {"leaves.png"},
    groups = {leaves = 1, snappy = 3, flammable = 2, oddly_breakable_by_hand = 1},
    drawtype = "allfaces_optional",
    paramtype = "light",
    is_ground_content = false,
    sunlight_propagates = true,
    sounds = leaves_sounds,
    drop = {
        max_items = 3,
        items = {
            {items = {"skyblock:world_stick"}, rarity = 3},
            {items = {"skyblock:world_leaves"}, rarity = 5},
            {items = {"skyblock:world_sapling"}, rarity = 6},  -- 新增树苗掉落
            }
     }
})

-- 世界枝丫（木棍）
minetest.register_craftitem("skyblock:world_stick", {
    description = "世界枝丫",
    inventory_image = "stick.png",
    groups = {stick = 1, flammable = 2},
})

-- 工作台（临时占位，后续可升级）
--minetest.register_node("skyblock:workbench", {
--    description = "工作台",
--    tiles = {"workbench_top.png", "workbench_bottom.png", "workbench_side.png"},
--    groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
--    drawtype = "normal",
--    paramtype = "light",
--    is_ground_content = false,
--    sunlight_propagates = true,
--    sounds = wood_sounds,
--    drop = "skyblock:workbench",
--})

minetest.register_node("skyblock:model_test", {
    description = "模型测试",
    drawtype = "mesh",
    mesh = "model3.2.gltf",
    tiles = {"player.png"},
    use_texture_alpha = "clip",

    -- 显式指定碰撞箱（必须！否则某些 glTF 方块交互异常）
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},  -- 标准 1×1×1 方块
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
    },

    groups = {dig_immediate = 2},
    drop = "skyblock:model_test",
    paramtype = "light",
    sunlight_propagates = true,
    is_ground_content = false,
    sounds = leaves_sounds,
})

--shumiao
minetest.register_node("skyblock:world_sapling", {
    description = "世界树苗",
    drawtype = "plantlike",
    tiles = {"shumiao.png"},
    inventory_image = "shumiao.png",
    wield_image = "shumiao.png",
    paramtype = "light",
    sunlight_propagates = false,
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
    },
    groups = {snappy = 2, dig_immediate = 3, flammable = 2},
    drop = "skyblock:world_sapling",
    sounds = wood_sounds,
})

-- 圆石
minetest.register_node("skyblock:cobblestone", {
    description = "圆石",
    tiles = {"cobble.png"},
    groups = {cracky = 3, stone = 1},
    drop = "skyblock:cobblestone",
    sounds = stone_sounds,
})

-- 沙砾
minetest.register_node("skyblock:gravel", {
    description = "沙砾",
    tiles = {"gravel.png"},
    groups = {crumbly = 2, falling_node = 1},
    drop = "skyblock:gravel",
    sounds = stone_sounds,
})

-- 木镐
minetest.register_tool("skyblock:wooden_pickaxe", {
    description = "木镐",
    inventory_image = "mugao.png",
    tool_capabilities = {
        full_punch_interval = 0.8,
        max_drop_level = 0,
        groupcaps = {
            cracky = {times = {[1] = 2.0, [2] = 1.2, [3] = 0.8}, uses = 70, maxlevel = 1},
        },
        damage_groups = {fleshy = 2},
    },
    groups = {tool = 1, flammable = 2},
    sound = {breaks = "default_tool_breaks"},
})