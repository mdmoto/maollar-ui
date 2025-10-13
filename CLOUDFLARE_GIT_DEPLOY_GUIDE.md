# 📘 Cloudflare Pages Git 自动部署指南

## ✅ 步骤 1: 代码已推送到 GitHub

代码已成功推送到: `https://github.com/mdmoto/maollar-ui`

---

## 🌐 步骤 2: 在 Cloudflare Pages 中配置

### 2.1 登录 Cloudflare

1. 访问: https://dash.cloudflare.com
2. 使用你的 Cloudflare 账户登录

### 2.2 进入 Pages

1. 在左侧菜单找到 **Workers & Pages**
2. 点击 **Create application**
3. 选择 **Pages** 标签
4. 点击 **Connect to Git**

---

## 📦 步骤 3: 创建三个独立项目

你需要为每个前端应用创建独立的 Cloudflare Pages 项目。

### 项目 1: Manager (管理端)

#### 基本设置
- **项目名称**: `maollar-manager`
- **选择仓库**: `mdmoto/maollar-ui`
- **分支**: `main`

#### 构建设置
```
Framework preset: None
Root directory: manager
Build command: npm run build
Build output directory: dist
```

#### 环境变量
点击 **Add environment variable** 添加:
```
NODE_VERSION = 18.20.8
NODE_OPTIONS = --openssl-legacy-provider
```

#### 点击 **Save and Deploy**

---

### 项目 2: Seller (商家端)

重复上述步骤,创建第二个项目:

#### 基本设置
- **项目名称**: `maollar-seller`
- **选择仓库**: `mdmoto/maollar-ui`
- **分支**: `main`

#### 构建设置
```
Framework preset: None
Root directory: seller
Build command: npm run build
Build output directory: dist
```

#### 环境变量
```
NODE_VERSION = 18.20.8
NODE_OPTIONS = --openssl-legacy-provider
```

#### 点击 **Save and Deploy**

---

### 项目 3: Buyer (买家端)

创建第三个项目:

#### 基本设置
- **项目名称**: `maollar-buyer`
- **选择仓库**: `mdmoto/maollar-ui`
- **分支**: `main`

#### 构建设置
```
Framework preset: None
Root directory: buyer
Build command: npm run build
Build output directory: dist
```

#### 环境变量
```
NODE_VERSION = 18.20.8
NODE_OPTIONS = --openssl-legacy-provider
```

#### 点击 **Save and Deploy**

---

## ⏱️ 步骤 4: 等待构建完成

每个项目大约需要 5-10 分钟构建。

### 查看构建进度
1. 在 Cloudflare Dashboard 中进入对应项目
2. 点击 **Deployments** 查看构建状态
3. 点击正在运行的部署查看实时日志

### 构建成功标志
看到绿色的 **Success** 标志,说明部署成功!

---

## 🌐 步骤 5: 获取访问 URL

构建成功后,每个项目会有自己的 URL:

- **Manager**: https://maollar-manager.pages.dev
- **Seller**: https://maollar-seller.pages.dev
- **Buyer**: https://maollar-buyer.pages.dev

点击 URL 即可访问你的前端应用!

---

## 🔧 步骤 6: 配置自定义域名 (可选)

### 6.1 添加自定义域名

在每个项目中:
1. 进入 **Custom domains**
2. 点击 **Set up a custom domain**
3. 输入域名:
   - Manager: `admin.maollar.com`
   - Seller: `store.maollar.com`
   - Buyer: `www.maollar.com` 或 `shop.maollar.com`

### 6.2 配置 DNS

Cloudflare 会自动:
- 创建 DNS 记录
- 配置 SSL 证书
- 几分钟后域名即可访问

---

## ⚙️ 步骤 7: 配置后端 API 环境变量

**重要**: 等后端部署完成后,需要配置 API 地址。

### Manager API 配置

在 `maollar-manager` 项目中:
1. 进入 **Settings** → **Environment variables**
2. 选择 **Production** 环境
3. 添加以下变量:

```
VUE_APP_API_BASE_URL = https://api.maollar.com
VUE_APP_MANAGER_API = https://admin-api.maollar.com
VUE_APP_COMMON_API = https://common-api.maollar.com
```

### Seller API 配置

在 `maollar-seller` 项目中添加:

```
VUE_APP_API_BASE_URL = https://api.maollar.com
VUE_APP_SELLER_API = https://seller-api.maollar.com
VUE_APP_COMMON_API = https://common-api.maollar.com
```

### Buyer API 配置

在 `maollar-buyer` 项目中添加:

```
VUE_APP_API_BASE_URL = https://api.maollar.com
VUE_APP_BUYER_API = https://buyer-api.maollar.com
VUE_APP_COMMON_API = https://common-api.maollar.com
```

**注意**: 添加或修改环境变量后,需要触发重新部署 (Cloudflare 会自动提示)。

---

## 🔄 自动部署功能

配置完成后,以后每次推送代码到 GitHub:

```bash
cd /Users/adam/maollar-project/frontend
git add .
git commit -m "更新内容"
git push origin main
```

Cloudflare Pages 会自动:
1. 检测到代码变更
2. 自动构建
3. 自动部署
4. 几分钟后更新就上线了!

---

## 🐛 常见问题排查

### 问题 1: 构建失败

**症状**: 构建状态显示 Failed

**检查**:
1. 点击失败的部署查看日志
2. 确认环境变量 `NODE_OPTIONS` 设置正确
3. 确认 `Root directory` 设置正确 (manager/seller/buyer)

**解决**: 修改设置后点击 **Retry deployment**

---

### 问题 2: 页面空白或 404

**症状**: 访问 URL 后看到空白页

**检查**:
1. 确认 `Build output directory` 设置为 `dist`
2. 查看构建日志确认 dist 目录已生成
3. 检查浏览器控制台是否有错误

---

### 问题 3: API 请求失败

**症状**: 前端加载成功但无法获取数据

**原因**: 后端 API 还未部署或环境变量未配置

**解决**:
1. 等待后端部署完成
2. 在 Cloudflare Pages 中配置 API 环境变量
3. 触发重新部署

---

## 📊 部署状态检查清单

部署前检查:
- ✅ 代码已推送到 GitHub
- ✅ GitHub 仓库: mdmoto/maollar-ui

Manager 项目:
- ⬜ 在 Cloudflare 中创建项目
- ⬜ 配置构建设置 (Root: manager)
- ⬜ 添加环境变量 (NODE_OPTIONS)
- ⬜ 部署成功,获得 URL
- ⬜ 访问 URL 确认页面加载

Seller 项目:
- ⬜ 在 Cloudflare 中创建项目
- ⬜ 配置构建设置 (Root: seller)
- ⬜ 添加环境变量
- ⬜ 部署成功,获得 URL
- ⬜ 访问 URL 确认页面加载

Buyer 项目:
- ⬜ 在 Cloudflare 中创建项目
- ⬜ 配置构建设置 (Root: buyer)
- ⬜ 添加环境变量
- ⬜ 部署成功,获得 URL
- ⬜ 访问 URL 确认页面加载

可选配置:
- ⬜ 绑定自定义域名
- ⬜ 配置后端 API 环境变量
- ⬜ 测试完整功能

---

## 🎯 快速配置表格

| 配置项 | Manager | Seller | Buyer |
|--------|---------|--------|-------|
| 项目名 | maollar-manager | maollar-seller | maollar-buyer |
| 仓库 | mdmoto/maollar-ui | mdmoto/maollar-ui | mdmoto/maollar-ui |
| 分支 | main | main | main |
| Root 目录 | manager | seller | buyer |
| Build 命令 | npm run build | npm run build | npm run build |
| Output 目录 | dist | dist | dist |
| NODE_VERSION | 18.20.8 | 18.20.8 | 18.20.8 |
| NODE_OPTIONS | --openssl-legacy-provider | --openssl-legacy-provider | --openssl-legacy-provider |

---

## 📝 下一步

1. ✅ **立即操作**: 打开 https://dash.cloudflare.com 开始配置
2. ⏳ **等待构建**: 大约 15-30 分钟完成所有三个项目
3. 🎉 **验证成功**: 访问生成的 URL 查看前端
4. 🔧 **继续后端**: 准备 Oracle Cloud 后端部署

---

**提示**: 建议按照 Manager → Seller → Buyer 的顺序创建项目,这样更有条理。

**需要帮助?** 如果在 Cloudflare 配置过程中遇到问题,随时告诉我具体的错误信息,我会帮你解决!
