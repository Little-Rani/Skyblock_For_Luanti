#!/bin/bash

# 强制杀死可能残留的 Luanti 进程
pkill -9 luanti 2>/dev/null
sleep 1

# 删除旧世界
rm -rf ~/.minetest/worlds/skyblock_dev
rm -rf ~/.minetest/worlds/world

# 手动创建世界目录和配置文件
mkdir -p ~/.minetest/worlds/skyblock_dev

# 创建 world.mt 文件（世界的配置文件）
cat > ~/.minetest/worlds/skyblock_dev/world.mt << 'EOF'
gameid = skyblock_void
enable_damage = false
creative_mode = false
auth_backend = files
backend = sqlite3
player_backend = sqlite3
mapgen = singlenode
EOF

# 创建必要的子目录
mkdir -p ~/.minetest/worlds/skyblock_dev/players

echo "World skyblock_dev created manually"

# 正常启动游戏
/usr/bin/luanti --go --worldname skyblock_dev --gameid skyblock_void --name Tester