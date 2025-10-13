#!/bin/bash

# 修复 /deep/ 语法为 ::v-deep
# Vue 3 和新版 Sass 不再支持 /deep/ 语法

echo "🔧 修复 /deep/ 语法..."

# 修复三个项目
for project in "manager" "seller" "buyer"; do
    echo ""
    echo "处理 $project..."
    
    project_dir="/Users/adam/maollar-project/frontend/$project"
    
    if [ ! -d "$project_dir" ]; then
        echo "❌ 目录不存在: $project_dir"
        continue
    fi
    
    # 统计需要修复的文件数
    count=$(find "$project_dir/src" -type f \( -name "*.vue" -o -name "*.scss" \) -exec grep -l "/deep/" {} \; 2>/dev/null | wc -l)
    
    if [ "$count" -gt 0 ]; then
        echo "找到 $count 个需要修复的文件"
        
        # 替换 /deep/ 为 ::v-deep
        find "$project_dir/src" -type f \( -name "*.vue" -o -name "*.scss" \) -exec sed -i '' 's|/deep/|::v-deep|g' {} \; 2>/dev/null
        
        echo "✅ $project 修复完成"
    else
        echo "✅ $project 无需修复"
    fi
done

echo ""
echo "=========================================="
echo "🎉 所有项目的 /deep/ 语法已修复为 ::v-deep"
echo "=========================================="
