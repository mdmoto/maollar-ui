#!/bin/bash

# 喵乐商城 - 前端构建脚本 (使用 npm)
# 构建 manager、seller、buyer 三个前端项目

# 注意：不使用 set -e，因为我们要手动控制错误处理

FRONTEND_DIR="/Users/adam/maollar-project/frontend"
LOG_DIR="${FRONTEND_DIR}/build-logs"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# 创建日志目录
mkdir -p "${LOG_DIR}"

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}🚀 喵乐商城前端构建开始${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Node 版本: $(node -v)"
echo "npm 版本: $(npm -v)"
echo "构建时间: $TIMESTAMP"
echo ""

# 构建函数
build_project() {
    local project_name=$1
    local project_dir="${FRONTEND_DIR}/${project_name}"
    
    echo -e "${YELLOW}========================================${NC}"
    echo -e "${YELLOW}📦 开始构建: ${project_name}${NC}"
    echo -e "${YELLOW}========================================${NC}"
    
    if [ ! -d "${project_dir}" ]; then
        echo -e "${RED}❌ 错误: 目录不存在 ${project_dir}${NC}"
        return 1
    fi
    
    cd "${project_dir}"
    
    # 检查是否需要安装依赖
    if [ ! -d "node_modules" ] || [ ! -f "package-lock.json" ]; then
        echo -e "${YELLOW}📥 安装依赖...${NC}"
        npm install 2>&1 | tee "${LOG_DIR}/${project_name}_install_${TIMESTAMP}.log"
        
        if [ ${PIPESTATUS[0]} -ne 0 ]; then
            echo -e "${RED}❌ ${project_name} 依赖安装失败${NC}"
            return 1
        fi
    else
        echo -e "${GREEN}✓ node_modules 已存在，跳过安装${NC}"
    fi
    
    # 清理旧的构建文件
    if [ -d "dist" ]; then
        echo -e "${YELLOW}🗑️  清理旧的构建文件...${NC}"
        rm -rf dist
    fi
    
    # 开始构建
    echo -e "${YELLOW}🔨 开始构建...${NC}"
    npm run build 2>&1 | tee "${LOG_DIR}/${project_name}_build_${TIMESTAMP}.log"
    
    if [ ${PIPESTATUS[0]} -ne 0 ]; then
        echo -e "${RED}❌ ${project_name} 构建失败${NC}"
        echo -e "${RED}查看日志: ${LOG_DIR}/${project_name}_build_${TIMESTAMP}.log${NC}"
        return 1
    fi
    
    # 检查构建结果
    if [ -d "dist" ] && [ "$(ls -A dist)" ]; then
        echo -e "${GREEN}✅ ${project_name} 构建成功!${NC}"
        echo -e "${GREEN}   构建输出: ${project_dir}/dist${NC}"
        
        # 显示构建文件大小
        local dist_size=$(du -sh dist | cut -f1)
        echo -e "${GREEN}   大小: ${dist_size}${NC}"
        
        return 0
    else
        echo -e "${RED}❌ ${project_name} 构建失败: dist 目录为空${NC}"
        return 1
    fi
}

# 构建状态追踪
manager_status=""
seller_status=""
buyer_status=""

# 构建三个项目
projects=("manager" "seller" "buyer")

for project in "${projects[@]}"; do
    echo ""
    if build_project "$project"; then
        case $project in
            "manager") manager_status="✅ 成功" ;;
            "seller") seller_status="✅ 成功" ;;
            "buyer") buyer_status="✅ 成功" ;;
        esac
    else
        case $project in
            "manager") manager_status="❌ 失败" ;;
            "seller") seller_status="❌ 失败" ;;
            "buyer") buyer_status="❌ 失败" ;;
        esac
    fi
    echo ""
    sleep 2
done

# 构建总结
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}📊 构建总结${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

all_success=true
echo "  manager: $manager_status"
if [[ "$manager_status" == *"失败"* ]]; then
    all_success=false
fi

echo "  seller: $seller_status"
if [[ "$seller_status" == *"失败"* ]]; then
    all_success=false
fi

echo "  buyer: $buyer_status"
if [[ "$buyer_status" == *"失败"* ]]; then
    all_success=false
fi

echo ""
echo -e "${GREEN}日志目录: ${LOG_DIR}${NC}"
echo ""

if [ "$all_success" = true ]; then
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}🎉 所有前端项目构建完成！${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    echo -e "${YELLOW}下一步：部署到 Cloudflare Pages${NC}"
    echo ""
    echo "方式1 - 使用 Wrangler CLI:"
    echo "  npm install -g wrangler"
    echo "  wrangler login"
    echo "  cd ${FRONTEND_DIR}/manager && wrangler pages deploy dist --project-name=maollar-manager"
    echo "  cd ${FRONTEND_DIR}/seller && wrangler pages deploy dist --project-name=maollar-seller"
    echo "  cd ${FRONTEND_DIR}/buyer && wrangler pages deploy dist --project-name=maollar-buyer"
    echo ""
    echo "方式2 - 手动上传到 Cloudflare Pages Dashboard:"
    echo "  访问: https://dash.cloudflare.com -> Pages -> Upload assets"
    echo "  上传各个项目的 dist 目录"
    echo ""
    exit 0
else
    echo -e "${RED}========================================${NC}"
    echo -e "${RED}⚠️  部分项目构建失败${NC}"
    echo -e "${RED}========================================${NC}"
    echo ""
    echo "请检查上面的错误信息和日志文件"
    echo "日志位置: ${LOG_DIR}"
    echo ""
    exit 1
fi
