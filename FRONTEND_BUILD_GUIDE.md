# 喵乐商城前端构建指南

## 前端项目概览

本项目包含三个独立的前端应用:

1. **manager** - 管理端 (平台管理员)
2. **seller** - 商家端 (商家管理)
3. **buyer** - 买家端 (用户购物)

## 快速构建

### 一键构建所有项目

```bash
cd /Users/adam/maollar-project/frontend
./build-all-frontend.sh
```

### 单独构建某个项目

```bash
# 构建 manager (管理端)
cd /Users/adam/maollar-project/frontend/manager
npm install
npm run build

# 构建 seller (商家端)
cd /Users/adam/maollar-project/frontend/seller
npm install
npm run build

# 构建 buyer (买家端)
cd /Users/adam/maollar-project/frontend/buyer
npm install
npm run build
```

## 构建产物

构建成功后,每个项目会在其目录下生成 `dist` 文件夹:

- `/Users/adam/maollar-project/frontend/manager/dist`
- `/Users/adam/maollar-project/frontend/seller/dist`
- `/Users/adam/maollar-project/frontend/buyer/dist`

## 部署到 Cloudflare Pages

### 方法1: 使用 Wrangler CLI (推荐)

```bash
# 安装 Wrangler (只需一次)
npm install -g wrangler

# 登录 Cloudflare
wrangler login

# 部署 manager
cd /Users/adam/maollar-project/frontend/manager
wrangler pages deploy dist --project-name=maollar-manager

# 部署 seller
cd /Users/adam/maollar-project/frontend/seller
wrangler pages deploy dist --project-name=maollar-seller

# 部署 buyer
cd /Users/adam/maollar-project/frontend/buyer
wrangler pages deploy dist --project-name=maollar-buyer
```

### 方法2: 通过 Git 集成自动部署

1. 确保各前端项目已推送到 GitHub
2. 登录 Cloudflare Dashboard: https://dash.cloudflare.com
3. 进入 **Pages** 部分
4. 点击 **Create a project** → **Connect to Git**
5. 选择你的 GitHub 仓库 `mdmoto/maollar-frontend`
6. 为每个子项目创建独立部署:

#### Manager 配置
- **Project name**: `maollar-manager`
- **Production branch**: `main`
- **Root directory**: `manager`
- **Build command**: `npm run build`
- **Build output directory**: `dist`

#### Seller 配置
- **Project name**: `maollar-seller`
- **Production branch**: `main`
- **Root directory**: `seller`
- **Build command**: `npm run build`
- **Build output directory**: `dist`

#### Buyer 配置
- **Project name**: `maollar-buyer`
- **Production branch**: `main`
- **Root directory**: `buyer`
- **Build command**: `npm run build`
- **Build output directory**: `dist`

### 方法3: 手动上传

1. 登录 Cloudflare Dashboard: https://dash.cloudflare.com
2. 进入 **Pages** → **Upload assets**
3. 创建新项目并上传对应的 `dist` 文件夹

## 环境变量配置

在 Cloudflare Pages 项目设置中配置以下环境变量:

### Manager 环境变量
```
NODE_ENV=production
VUE_APP_API_BASE_URL=https://api.maollar.com
VUE_APP_MANAGER_API=https://admin.maollar.com/api
VUE_APP_COMMON_API=https://common.maollar.com/api
```

### Seller 环境变量
```
NODE_ENV=production
VUE_APP_API_BASE_URL=https://api.maollar.com
VUE_APP_SELLER_API=https://seller.maollar.com/api
VUE_APP_COMMON_API=https://common.maollar.com/api
```

### Buyer 环境变量
```
NODE_ENV=production
VUE_APP_API_BASE_URL=https://api.maollar.com
VUE_APP_BUYER_API=https://buyer.maollar.com/api
VUE_APP_COMMON_API=https://common.maollar.com/api
```

## 自定义域名绑定

在 Cloudflare Pages 项目中:

1. 进入项目设置 → **Custom domains**
2. 添加自定义域名:
   - Manager: `admin.maollar.com`
   - Seller: `store.maollar.com`
   - Buyer: `shop.maollar.com` 或 `www.maollar.com`

## 常见问题

### 1. 构建失败: "Undefined variable $theme_color"

**已修复**: 确保 `vue.config.js` 正确导入了全局 SCSS 变量文件。

### 2. npm install 太慢

使用国内镜像:
```bash
npm config set registry https://registry.npmmirror.com
```

### 3. 内存不足错误

增加 Node.js 内存限制:
```bash
export NODE_OPTIONS="--max-old-space-size=4096"
npm run build
```

### 4. CDN 资源加载失败

如果构建时 CDN 资源无法访问,可以在 `src/config/index.js` 中设置:
```js
enableCDN: false
```

## 构建日志

构建日志保存在:
```
/Users/adam/maollar-project/frontend/build-logs/
```

## 验证部署

部署成功后,访问以下 URL 验证:

- Manager: https://admin.maollar.com 或 https://maollar-manager.pages.dev
- Seller: https://store.maollar.com 或 https://maollar-seller.pages.dev
- Buyer: https://shop.maollar.com 或 https://maollar-buyer.pages.dev

## 后续步骤

1. ✅ 本地构建前端项目
2. ⬜ 部署到 Cloudflare Pages
3. ⬜ 配置自定义域名
4. ⬜ 设置环境变量指向后端 API
5. ⬜ 测试前后端连接

---

**构建时间**: 2025-10-13  
**Node 版本**: v18.20.8  
**npm 版本**: 10.8.2
