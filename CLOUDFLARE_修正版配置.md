# 🔧 Cloudflare Pages 配置（修正版）

## ⚠️ 重要变更

由于依赖冲突问题，构建命令已更新！

---

## 📝 更新后的配置

### 项目 1: Manager（管理端）

```
项目名称: maollar-manager
分支: main
Framework preset: Vue
Root directory: manager
Build command: npm run cf:build  ⚠️ 注意这里改了！
Build output directory: dist
```

**环境变量**:
```
NODE_VERSION = 18.20.8
NODE_OPTIONS = --openssl-legacy-provider
```

---

### 项目 2: Seller（商家端）

```
项目名称: maollar-seller
分支: main
Framework preset: Vue
Root directory: seller
Build command: npm run cf:build  ⚠️ 注意这里改了！
Build output directory: dist
```

**环境变量**:
```
NODE_VERSION = 18.20.8
NODE_OPTIONS = --openssl-legacy-provider
```

---

### 项目 3: Buyer（买家端）

```
项目名称: maollar-buyer
分支: main
Framework preset: Vue
Root directory: buyer
Build command: npm run cf:build  ⚠️ 注意这里改了！
Build output directory: dist
```

**环境变量**:
```
NODE_VERSION = 18.20.8
NODE_OPTIONS = --openssl-legacy-provider
```

---

## 🔄 如果已经创建了项目

### 方案 1: 更新构建命令（推荐）

1. 进入 Cloudflare Pages 项目
2. 点击 **Settings** → **Builds & deployments**
3. 找到 **Build command** 
4. 将 `npm run build` 改为 `npm run cf:build`
5. 点击 **Save**
6. 回到 **Deployments** 页面
7. 点击 **Retry deployment**

### 方案 2: 删除并重新创建

如果还没开始构建，可以直接：
1. 删除刚才创建的项目
2. 用新的构建命令重新创建

---

## 📋 快速对比

| 配置项 | 之前（错误） | 现在（正确） |
|--------|-------------|-------------|
| Build command | `npm run build` | `npm run cf:build` |

---

## ✅ 为什么要改？

`npm run cf:build` 命令会：
1. 先用 `--legacy-peer-deps` 安装依赖（解决版本冲突）
2. 然后再执行构建

这样可以避免 swiper 依赖冲突错误。

---

## 🎯 下一步

**如果你刚遇到错误**：
1. 在 Cloudflare Pages 项目设置中修改 Build command
2. 重新触发部署

**如果还没开始配置**：
- 直接用新的 `npm run cf:build` 命令创建项目

---

**代码已更新并推送到 GitHub！**
立即重试部署应该就能成功了！🚀
