# 🚀 Cloudflare Pages 配置清单

## 📋 准备信息

- **仓库地址**: `mdmoto/maollar-ui`
- **GitHub 账号**: mdmoto
- **分支**: main

---

## 🎯 配置步骤（重复 3 次）

### 第一步：打开 Cloudflare Dashboard

访问: https://dash.cloudflare.com

### 第二步：创建新项目

1. 点击 **Workers & Pages**
2. 点击 **Create application**
3. 选择 **Pages** 标签
4. 点击 **Connect to Git**

### 第三步：连接 GitHub 仓库

1. 选择 **mdmoto/maollar-ui** 仓库
2. 点击 **Begin setup**

---

## 📝 项目 1: Manager（管理端）

### 基本设置
```
项目名称: maollar-manager
分支: main
```

### 构建设置
```
Framework preset: Vue
Root directory: manager
Build command: npm run build
Build output directory: dist
```

### 环境变量（Environment variables）
```
NODE_VERSION = 18.20.8
NODE_OPTIONS = --openssl-legacy-provider
```

点击 **Save and Deploy** ✅

---

## 📝 项目 2: Seller（商家端）

### 基本设置
```
项目名称: maollar-seller
分支: main
```

### 构建设置
```
Framework preset: Vue
Root directory: seller
Build command: npm run build
Build output directory: dist
```

### 环境变量（Environment variables）
```
NODE_VERSION = 18.20.8
NODE_OPTIONS = --openssl-legacy-provider
```

点击 **Save and Deploy** ✅

---

## 📝 项目 3: Buyer（买家端）

### 基本设置
```
项目名称: maollar-buyer
分支: main
```

### 构建设置
```
Framework preset: Vue
Root directory: buyer
Build command: npm run build
Build output directory: dist
```

### 环境变量（Environment variables）
```
NODE_VERSION = 18.20.8
NODE_OPTIONS = --openssl-legacy-provider
```

点击 **Save and Deploy** ✅

---

## ⏱️ 等待构建

每个项目需要 **5-10 分钟**构建时间。

可以在 Cloudflare 控制台看到构建日志和进度。

---

## ✅ 构建成功后

每个项目会得到一个访问地址：
- Manager: `https://maollar-manager.pages.dev`
- Seller: `https://maollar-seller.pages.dev`
- Buyer: `https://maollar-buyer.pages.dev`

---

## 🔧 后续配置（可选）

### 配置后端 API 地址

等 Oracle Cloud 后端部署好后，需要在每个项目添加环境变量：

```
VUE_APP_API_BASE_URL = https://你的后端地址
```

然后触发重新部署（推送新代码或手动重新部署）。

---

## 🆘 常见问题

### Q: 构建失败怎么办？
A: 查看构建日志，通常是因为：
- 没有设置 `NODE_OPTIONS` 环境变量
- `Root directory` 设置错误
- `Build output directory` 设置错误

### Q: 页面显示 404？
A: 检查 `Build output directory` 是否设置为 `dist`

### Q: 需要重新构建？
A: 进入项目 → Deployments → 点击最新部署右边的 "..." → Retry deployment

---

## 🎉 完成标志

- ✅ 3 个项目都显示 "Success" 状态
- ✅ 可以访问 3 个 .pages.dev 地址
- ✅ 页面能正常加载（即使后端还没连接）

---

**现在开始**: https://dash.cloudflare.com

**预计总时间**: 30-40 分钟
