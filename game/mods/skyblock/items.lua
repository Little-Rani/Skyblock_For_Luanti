-- items.lua
-- 物品定义：※ 占位物品 & 粗制滤网

-- 占位物品 ※
minetest.register_craftitem("skyblock:placeholder", {
    description = "※",
    inventory_image = "unkown.png",
    stack_max = 99,
})

-- 粗制滤网（带右键萃取逻辑）
minetest.register_craftitem("skyblock:crude_filter", {
    description = "粗制滤网",
    inventory_image = "shaiwang.png",
    stack_max = 1,

    on_use = function(itemstack, player, pointed_thing)
        -- 必须指向空气
        if pointed_thing and pointed_thing.type ~= "nothing" then
            return itemstack
        end

        local name = player:get_player_name()

        -- 检查是否已在萃取中
        if skyblock_is_extracting(player) then
            minetest.chat_send_player(name, "已经在萃取中了...")
            return itemstack
        end

        -- 检查冷却
        if skyblock_is_on_cooldown(player) then
            minetest.chat_send_player(name, "萃取冷却中...")
            return itemstack
        end

        -- 开始萃取
        skyblock_start_extract(player)
        return itemstack
    end,
})

-- 铜粉尘
minetest.register_craftitem("skyblock:copper_dust", {
    description = "铜粉尘",
    inventory_image = "tongfen.png",
    stack_max = 99,
})

-- 铁粉尘
minetest.register_craftitem("skyblock:iron_dust", {
    description = "铁粉尘",
    inventory_image = "tiefen.png",
    stack_max = 99,
})

-- 虚空精华
minetest.register_craftitem("skyblock:void_essence", {
    description = "虚空精华",
    inventory_image = "void_fenmo.png",
    stack_max = 99,
})

-- 铜粒
minetest.register_craftitem("skyblock:copper_nugget", {
    description = "铜粒",
    inventory_image = "tongli.png",
    stack_max = 99,
})

-- 铁粒
minetest.register_craftitem("skyblock:iron_nugget", {
    description = "铁粒",
    inventory_image = "tieli.png",
    stack_max = 99,
})

-- 铜锭
minetest.register_craftitem("skyblock:copper_ingot", {
    description = "铜锭",
    inventory_image = "tongding.png",
    stack_max = 99,
})

-- 铁锭
minetest.register_craftitem("skyblock:iron_ingot", {
    description = "铁锭",
    inventory_image = "tieding.png",
    stack_max = 99,
})