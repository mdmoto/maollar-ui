#!/bin/bash

# 喵乐商城前端 - 本地构建 + Wrangler 直接部署脚本
# 绕过 Cloudflare Pages Git 构建的内存限制

set -e

echo "🚀 开始本地构建并部署到 Cloudflare Pages"
echo ""

# 构建 Manager
echo "📦 [1/3] 构建 Manager (管理端)..."
cd manager
yarn install
yarn build
echo "✅ Manager 构建完成"
cd ..

# 构建 Seller
echo "📦 [2/3] 构建 Seller (商家端)..."
cd seller
yarn install
yarn build
echo "✅ Seller 构建完成"
cd ..

# 构建 Buyer
echo "📦 [3/3] 构建 Buyer (买家端)..."
cd buyer
yarn install
yarn build
echo "✅ Buyer 构建完成"
cd ..

echo ""
echo "🎉 所有项目构建完成！"
echo ""
echo "📤 现在可以部署到 Cloudflare Pages："
echo ""
echo "方式 1: 使用 Wrangler CLI"
echo "  cd manager && npx wrangler pages deploy dist --project-name=maollar-manager"
echo "  cd seller && npx wrangler pages deploy dist --project-name=maollar-seller"
echo "  cd buyer && npx wrangler pages deploy dist --project-name=maollar-buyer"
echo ""
echo "方式 2: 手动上传"
echo "  在 Cloudflare Pages 控制台，选择 'Upload assets' 上传 dist 目录"
echo ""
