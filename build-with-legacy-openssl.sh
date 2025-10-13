#!/bin/bash

# 使用 legacy OpenSSL 提供程序构建前端项目
# 修复 Node.js 18 与旧版 webpack 的兼容性问题

export NODE_OPTIONS="--openssl-legacy-provider"

echo "=========================================="
echo "🚀 使用 Legacy OpenSSL 构建前端"
echo "=========================================="
echo ""
echo "Node 版本: $(node -v)"
echo "环境变量: NODE_OPTIONS=$NODE_OPTIONS"
echo ""

cd /Users/adam/maollar-project/frontend

# 运行原始构建脚本
bash build-all-frontend.sh
