-- init.lua
-- Skyblock 模组的入口文件

minetest.log("action", "[skyblock] Loading skyblock mod...")

local modpath = minetest.get_modpath("skyblock")

-- 加载别名
dofile(modpath .. "/aliases.lua")
-- 加载方块
dofile(modpath .. "/nodes.lua")
-- 加载地图生成
dofile(modpath .. "/mapgen.lua")
--加载配方
dofile(modpath .. "/crafting.lua")
--树苗生长
dofile(modpath .. "/growth.lua")
--占位物品
dofile(modpath .. "/items.lua")
--hud部分
dofile(modpath .. "/hud.lua")
--玩家模型暂时废弃
--dofile(modpath .. "/player_model.lua")
--石磨
dofile(modpath .. "/nodes_crafting.lua")
--坩埚
dofile(modpath .. '/nodes_cauldron.lua')

-- 自动给 Tester 管理员权限
minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    if name == "Tester" or name == "tester" then
        minetest.set_player_privs(name, {interact = true, shout = true, give = true, server = true})
        minetest.log("action", "[skyblock] Granted admin privileges to " .. name)
    end
end)

-- 延迟设置出生点，防止卡进方块
minetest.register_on_newplayer(function(player)
    minetest.after(0.5, function()
        -- 树顶上方一格 (y=7)，绝对安全
        player:set_pos({x = 0, y = 7, z = 0})
        minetest.log("action", "[skyblock] Player spawned on top of the tree at (0, 7, 0)")
    end)
end)

minetest.log("action", "[skyblock] Skyblock mod loaded successfully!")

