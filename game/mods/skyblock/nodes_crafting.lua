-- nodes_crafting.lua
-- 生产设备：石磨

minetest.register_node("skyblock:stone_mill", {
    description = "石磨",
    drawtype = "mesh",
    mesh = "stonemill.obj",
    tiles = {
        "stone_mill.png"
    },
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 2, oddly_breakable_by_hand = 1},
    drop = "skyblock:stone_mill",
    sounds = stone_sounds,

    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5}
    },

    on_rightclick = function(pos, node, clicker, itemstack)
        local name = clicker:get_player_name()
        local wield_item = itemstack:get_name()

        -- 手持圆石时，可以研磨
        if wield_item == "skyblock:cobblestone" then
            local inv = clicker:get_inventory()
            local count = itemstack:get_count()

            if count >= 1 then
                -- 消耗 1 个圆石
                itemstack:take_item(1)

                -- 产出 3 个沙砾
                local gravel = "skyblock:gravel"
                if not inv:room_for_item("main", {name = gravel, count = 3}) then
                    -- 背包满就掉在地上
                    minetest.add_item(pos, gravel .. " 3")
                    minetest.chat_send_player(name, "背包满了，沙砾掉在地上。")
                else
                    inv:add_item("main", gravel .. " 3")
                    minetest.chat_send_player(name, "石磨研磨出 3 个沙砾。")
                end

                -- 播放声音反馈
                minetest.sound_play("default_dig_cracky", {pos = pos, gain = 0.5, max_hear_distance = 5})
            end
        elseif wield_item == "skyblock:copper_dust" or wield_item == "skyblock:iron_dust" then
            -- 手持铜/铁粉尘时，可以研磨成更细的粉（未来扩展用）
            minetest.chat_send_player(name, "石磨暂不支持研磨矿物粉尘，请使用圆石。")
        else
            minetest.chat_send_player(name, "手持圆石右键石磨可以研磨出沙砾。")
        end

        return itemstack
    end,
})