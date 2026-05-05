-- hud.lua
-- 萃取倒计时 HUD 管理

local hud_ids = {}
local cooldowns = {}

function skyblock_is_extracting(player)
    return hud_ids[player:get_player_name()] ~= nil
end

function skyblock_set_cooldown(player, duration)
    cooldowns[player:get_player_name()] = os.time() + duration
end

function skyblock_is_on_cooldown(player)
    local t = cooldowns[player:get_player_name()]
    return t and os.time() < t
end

local function remove_hud(player)
    local name = player:get_player_name()
    if hud_ids[name] then
        player:hud_remove(hud_ids[name])
        hud_ids[name] = nil
    end
end

function skyblock_start_extract(player)
    local name = player:get_player_name()
    if hud_ids[name] then return end

    local id = player:hud_add({
        hud_elem_type = "text",
        position = {x = 0.5, y = 0.8},
        text = "萃取中... 2.0s",
        number = 0xFFFF00,
        alignment = {x = 0, y = 0},
        scale = {x = 100, y = 100},
        size = {x = 1.2, y = 0.8},   -- 缩小文字
    })
    hud_ids[name] = id

    local remaining = 2.0
    local step = 0.5
    local function update()
        if not hud_ids[name] then return end
        remaining = remaining - step
        if remaining <= 0 then
            remove_hud(player)
            local inv = player:get_inventory()
            -- 粗制滤网战利品表（权重）
local loot = {
    {name = "skyblock:copper_dust",  weight = 35},
    {name = "skyblock:iron_dust",    weight = 35},
    {name = "skyblock:void_essence", weight = 20},
    --{name = "skyblock:placeholder",  weight = 10},  -- 10% 空手
}

-- 按权重随机
local total = 0
for _, e in ipairs(loot) do total = total + e.weight end
local roll = math.random(1, total)
local cumulative = 0
local chosen
for _, e in ipairs(loot) do
    cumulative = cumulative + e.weight
    if roll <= cumulative then
        chosen = e.name
        break
    end
end

local item = {name = chosen, count = 1}
            if inv:room_for_item("main", item) then
                inv:add_item("main", item)
            else
                minetest.add_item(player:get_pos(), item)
            end
            skyblock_set_cooldown(player, 1.0)
        else
            player:hud_change(id, "text", string.format("萃取中... %.1fs", remaining))
            minetest.after(step, update)
        end
    end
    minetest.after(step, update)
end

minetest.register_on_leaveplayer(function(player)
    remove_hud(player)
    cooldowns[player:get_player_name()] = nil
end)

minetest.register_on_dieplayer(function(player)
    remove_hud(player)
    cooldowns[player:get_player_name()] = nil
end)