-- crafting.lua
-- 基础合成配方

-- 世界枝干 → 4 世界枝丫（木棍）
minetest.register_craft({
    output = "skyblock:world_stick 4",
    recipe = {
        {"skyblock:world_branch"},
    }
})

-- 世界枝丫 → 1 世界枝干（用 4 根棍子合成一个原木？这里我们按常规：一个原木 = 4 棍子，反之不成立）
-- 但为了空岛，可以允许 4 棍子合成原木，这样树叶掉的棍子可以攒出更多原木
minetest.register_craft({
    output = "skyblock:world_branch",
    recipe = {
        {"skyblock:world_stick"},
        {"skyblock:world_stick"},
        {"skyblock:world_stick"},
        {"skyblock:world_stick"},
    }
})

-- 工作台（原木 → 四个棍子合成一个工作台）
--minetest.register_craft({
--    output = "skyblock:workbench",
--    recipe = {
--        {"skyblock:world_stick", "skyblock:world_stick", "skyblock:world_stick"},
--        {"skyblock:world_stick", "skyblock:world_stick", "skyblock:world_stick"},
--        {"skyblock:world_stick", "skyblock:world_stick", "skyblock:world_stick"},
--    }
--})

-- 粗制滤网：四角木棍 + 中间原木
minetest.register_craft({
    output = "skyblock:crude_filter",
    recipe = {
        {"skyblock:world_stick", "", "skyblock:world_stick"},
        {"", "skyblock:world_leaves", ""},
        {"skyblock:world_stick", "", "skyblock:world_stick"},
    }
})

-- 9 铜粉尘 → 1 铜粒
minetest.register_craft({
    output = "skyblock:copper_nugget",
    recipe = {
        {"skyblock:copper_dust", "skyblock:copper_dust", "skyblock:copper_dust"},
        {"skyblock:copper_dust", "skyblock:copper_dust", "skyblock:copper_dust"},
        {"skyblock:copper_dust", "skyblock:copper_dust", "skyblock:copper_dust"},
    }
})

-- 9 铁粉尘 → 1 铁粒
minetest.register_craft({
    output = "skyblock:iron_nugget",
    recipe = {
        {"skyblock:iron_dust", "skyblock:iron_dust", "skyblock:iron_dust"},
        {"skyblock:iron_dust", "skyblock:iron_dust", "skyblock:iron_dust"},
        {"skyblock:iron_dust", "skyblock:iron_dust", "skyblock:iron_dust"},
    }
})

-- 9 铜粒 → 1 铜锭
minetest.register_craft({
    output = "skyblock:copper_ingot",
    recipe = {
        {"skyblock:copper_nugget", "skyblock:copper_nugget", "skyblock:copper_nugget"},
        {"skyblock:copper_nugget", "skyblock:copper_nugget", "skyblock:copper_nugget"},
        {"skyblock:copper_nugget", "skyblock:copper_nugget", "skyblock:copper_nugget"},
    }
})

-- 9 铁粒 → 1 铁锭
minetest.register_craft({
    output = "skyblock:iron_ingot",
    recipe = {
        {"skyblock:iron_nugget", "skyblock:iron_nugget", "skyblock:iron_nugget"},
        {"skyblock:iron_nugget", "skyblock:iron_nugget", "skyblock:iron_nugget"},
        {"skyblock:iron_nugget", "skyblock:iron_nugget", "skyblock:iron_nugget"},
    }
})

-- 9 虚空精华 → 1 圆石
minetest.register_craft({
    output = "skyblock:cobblestone 1",
    recipe = {
        {"skyblock:void_essence", "skyblock:void_essence", "skyblock:void_essence"},
        {"skyblock:void_essence", "skyblock:void_essence", "skyblock:void_essence"},
        {"skyblock:void_essence", "skyblock:void_essence", "skyblock:void_essence"},
    }
})

-- 石磨：圆石 + 木棍
minetest.register_craft({
    output = "skyblock:stone_mill",
    recipe = {
        {"skyblock:cobblestone", "skyblock:cobblestone", "skyblock:cobblestone"},
        {"skyblock:cobblestone", "skyblock:world_stick", "skyblock:cobblestone"},
        {"skyblock:cobblestone", "skyblock:cobblestone", "skyblock:cobblestone"},
    }
})

-- 木镐
minetest.register_craft({
    output = "skyblock:wooden_pickaxe",
    recipe = {
        {"skyblock:world_branch", "skyblock:world_branch", "skyblock:world_branch"},
        {"", "skyblock:world_stick", ""},
        {"", "skyblock:world_stick", ""},
    }
})

-- 木坩埚
minetest.register_craft({
    output = "skyblock:cauldron_0",
    recipe = {
        {"skyblock:world_branch", "skyblock:world_branch", "skyblock:world_branch"},
        {"skyblock:world_branch", "", "skyblock:world_branch"},
        {"skyblock:world_branch", "skyblock:world_branch", "skyblock:world_branch"},
    }
})

--石磨
minetest.register_craft({
    output = "skyblock:stone_mill",
    recipe = {
        {"","skyblock:cobblestone",""},
        {"","skyblock:world_branch",""},
    }
})