-- player_model.lua
-- 使用 player1.6.gltf 模型

local model_name = "player1.6.gltf"
local texture_name = "player.png"

player_api.register_model(model_name, {
    animation = {
        stand = {x = 0, y = 0, speed = 1},
        walk  = {x = 0, y = 39, speed = 40},
        mine  = {x = 0, y = 39, speed = 40},
        jump  = {x = 0, y = 39, speed = 40},
    },
    visual_size = {x = 1, y = 1},
    textures = {texture_name},
    collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.75, 0.3},
    stepheight = 0.6,
    eye_height = 1.5,
})

minetest.register_on_newplayer(function(player)
    player:set_properties({
        mesh = model_name,
        textures = {texture_name},
        visual = "mesh",
        visual_size = {x = 1, y = 1},
    })
end)