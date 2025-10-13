#!/bin/bash

echo "=========================================="
echo "🚀 喵乐商城前端一键部署"
echo "=========================================="
echo ""

# 确保 Wrangler 已安装
if ! command -v wrangler &> /dev/null; then
    echo "📥 安装 Wrangler CLI..."
    npm install -g wrangler
    echo ""
fi

# 检查登录状态
echo "🔐 检查 Cloudflare 登录状态..."
if ! wrangler whoami &> /dev/null; then
    echo "需要登录 Cloudflare..."
    wrangler login
fi
echo ""

# 部署 Manager
echo "=========================================="
echo "📦 部署 Manager (管理端)..."
echo "=========================================="
cd /Users/adam/maollar-project/frontend/manager
wrangler pages deploy dist --project-name=maollar-manager
echo ""
sleep 2

# 部署 Seller
echo "=========================================="
echo "📦 部署 Seller (商家端)..."
echo "=========================================="
cd /Users/adam/maollar-project/frontend/seller
wrangler pages deploy dist --project-name=maollar-seller
echo ""
sleep 2

# 部署 Buyer
echo "=========================================="
echo "📦 部署 Buyer (买家端)..."
echo "=========================================="
cd /Users/adam/maollar-project/frontend/buyer
wrangler pages deploy dist --project-name=maollar-buyer
echo ""

echo "=========================================="
echo "🎉 所有项目部署完成!"
echo "=========================================="
echo ""
echo "请访问 Cloudflare Dashboard 查看:"
echo "https://dash.cloudflare.com -> Pages"
echo ""
echo "部署的项目:"
echo "  • maollar-manager (管理端)"
echo "  • maollar-seller  (商家端)"
echo "  • maollar-buyer   (买家端)"
echo ""
echo "下一步:"
echo "1. 在 Cloudflare Pages 中为每个项目绑定自定义域名"
echo "2. 配置环境变量 (API 地址)"
echo "3. 等待后端部署完成后测试完整功能"
echo ""
