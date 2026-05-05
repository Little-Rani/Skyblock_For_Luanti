-- nodes_cauldron.lua
-- 木坩埚：树叶榨水 (最多1格)，淘洗沙砾获得1个金属粒

local boxes = {
    [0] = { -- 空
        type = "fixed",
        fixed = {
            {-0.4, -0.5, -0.4, 0.4, 0.3, 0.4},
            {-0.3, -0.2, -0.3, 0.3, 0.3, 0.3},
        }
    },
    [1] = { -- 1格水 (底部一点水)
        type = "fixed",
        fixed = {
            {-0.4, -0.5, -0.4, 0.4, 0.3, 0.4},
            {-0.3, -0.2, -0.3, 0.3, -0.5, 0.3},
        }
    }
}

for level = 0, 1 do
    local name = "skyblock:cauldron_" .. level
    local desc = "木坩埚"
    if level > 0 then desc = desc .. " (有水)" end

    minetest.register_node(name, {
        description = desc,
        drawtype = "nodebox",
        node_box = boxes[level],
        tiles = {"world_foundation_top.png"}, -- 暂时用占位纹理
        paramtype = "light",
        groups = {cracky = 2, oddly_breakable_by_hand = 1, pickaxey = 1, cauldron = 1},
        drop = "skyblock:cauldron_0",
        sounds = stone_sounds,

        on_rightclick = function(pos, node, clicker, itemstack)
            local wield = itemstack:get_name()
            local pname = clicker:get_player_name()

            -- 加水：持有树叶，且坩埚空 (level == 0)
            if wield == "skyblock:world_leaves" and level == 0 then
                local inv = clicker:get_inventory()
                if itemstack:get_count() >= 1 then
                    itemstack:take_item(1)
                    minetest.set_node(pos, {name = "skyblock:cauldron_1"})
                    minetest.chat_send_player(pname, "你向坩埚中加入了一片树叶，得到了1格水。")
                    minetest.sound_play("default_place_node", {pos = pos, gain = 0.5})
                    return itemstack
                end
            end

            -- 淘矿：持有沙砾，且有水 (level == 1)
            if wield == "skyblock:gravel" and level == 1 then
                local inv = clicker:get_inventory()
                if itemstack:get_count() >= 1 then
                    itemstack:take_item(1)
                    minetest.set_node(pos, {name = "skyblock:cauldron_0"})

                    local reward = math.random(1,100) <= 80 and "skyblock:copper_nugget" or "skyblock:iron_nugget"
                    if inv:room_for_item("main", {name = reward}) then
                        inv:add_item("main", reward)
                    else
                        minetest.add_item(pos, reward)
                    end
                    minetest.chat_send_player(pname, "你淘洗了沙砾，获得了1个金属粒。")
                    minetest.sound_play("default_dig_cracky", {pos = pos, gain = 0.5})
                    return itemstack
                end
            end

            -- 提示
            if level == 0 then
                minetest.chat_send_player(pname, "坩埚是空的。手持树叶可以加水，手持沙砾可以淘矿（需要水）。")
            else
                minetest.chat_send_player(pname, "坩埚里有水。手持沙砾可以淘矿。")
            end
            return itemstack
        end,
    })
end