# ✅ Cloudflare Pages 正确配置（基于官方文档）

## 🎯 配置要点

根据 Lilishop 官方文档，前端应该使用：
- ✅ **Yarn**（不是 npm）
- ✅ **Node 14.16.0**（不是 18.x）
- ✅ **简单构建命令**

---

## 📝 Cloudflare Pages 配置

### 项目 1: Manager（管理端）

```
项目名称: maollar-manager
生产分支: main
Framework preset: Vue

Root directory: manager
Build command: yarn && yarn build
Build output directory: dist
```

**环境变量**：
```
NODE_VERSION = 14.16.0
```

---

### 项目 2: Seller（商家端）

```
项目名称: maollar-seller
生产分支: main
Framework preset: Vue

Root directory: seller
Build command: yarn && yarn build
Build output directory: dist
```

**环境变量**：
```
NODE_VERSION = 14.16.0
```

---

### 项目 3: Buyer（买家端）

```
项目名称: maollar-buyer
生产分支: main
Framework preset: Vue

Root directory: buyer
Build command: yarn && yarn build
Build output directory: dist
```

**环境变量**：
```
NODE_VERSION = 14.16.0
```

---

## 🔄 如何修改现有项目配置

### 方法 1：更新配置（推荐）

1. **进入项目设置**
   - 打开 Cloudflare Pages 控制台
   - 选择你的项目（如 maollar-manager）
   - 点击 **Settings**

2. **修改构建配置**
   - 找到 **Builds & deployments** 部分
   - 点击 **Edit configuration**
   
3. **更新以下字段**：
   ```
   Build command: yarn && yarn build
   Build output directory: dist
   Root directory: manager (保持不变)
   ```

4. **修改环境变量**
   - 找到 **Environment variables** 部分
   - 删除 `NODE_OPTIONS`（如果有）
   - 将 `NODE_VERSION` 改为 `14.16.0`
   - 点击 **Save**

5. **触发重新部署**
   - 回到 **Deployments** 页面
   - 点击 **Create deployment**
   - 或者点击失败部署的 **Retry**

---

### 方法 2：删除并重建（如果改配置不生效）

如果修改配置后还是有问题，可以：

1. 删除现有项目
2. 用新配置重新创建
3. 确保使用上面的正确配置

---

## 🎯 快速配置对比表

| 配置项 | ❌ 之前（错误） | ✅ 现在（正确） |
|--------|----------------|----------------|
| Build command | `npm run build` 或 `npm run cf:build` | `yarn && yarn build` |
| Node 版本 | `18.20.8` | `14.16.0` |
| 其他环境变量 | `NODE_OPTIONS=--openssl-legacy-provider` | **不需要** |
| .npmrc 文件 | 需要 | **不需要**（Yarn 自动处理） |

---

## ⏱️ 预期构建时间

- 首次构建：8-12 分钟（需要安装依赖）
- 后续构建：3-6 分钟（有缓存）

---

## ✅ 成功标志

构建日志应该显示：

```
✓ Installing dependencies with Yarn
✓ yarn install v1.22.19
✓ Building application
✓ yarn build
✓ Build succeeded
✓ Deploying to Cloudflare Pages
```

---

## 🆘 如果还是失败

1. **检查 Node 版本**：确保设置为 `14.16.0`
2. **检查构建命令**：必须是 `yarn && yarn build`
3. **检查 Root directory**：manager/seller/buyer
4. **查看完整日志**：复制错误信息给我

---

## 🎉 部署成功后

每个项目会得到独立的访问地址：

- Manager: `https://maollar-manager.pages.dev`
- Seller: `https://maollar-seller.pages.dev`
- Buyer: `https://maollar-buyer.pages.dev`

---

## 📌 重要提醒

1. ✅ Cloudflare Pages 原生支持 Yarn，无需额外配置
2. ✅ Node 14 是官方推荐版本，稳定性最好
3. ✅ Yarn 处理依赖冲突比 npm 更智能
4. ✅ 不需要任何 workaround（如 legacy-peer-deps）

---

**现在去 Cloudflare 更新配置吧！** 🚀

这次使用官方推荐的方式，应该能顺利成功！
