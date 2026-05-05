-- growth.lua
-- 树苗生长逻辑

minetest.register_abm({
    label = "World sapling growth",
    nodenames = {"skyblock:world_sapling"},
    interval = 1.0,      -- 每秒检查一次
    chance = 1,           -- 每次 interval 都运行，在 action 里随机判断
    action = function(pos, node, active_object_count, active_object_count_wider)
        -- 7.8% 概率生长
        if math.random(100) <= 7.8 then   -- 1-100 的随机数，小于等于7.8 ≈ 7.8%
            -- 移除树苗并生成大树
            minetest.remove_node(pos)
            skyblock_generate_tree(pos)
        end
    end,
})