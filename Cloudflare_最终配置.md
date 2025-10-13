# ✅ Cloudflare Pages 最终正确配置

## 🎯 完整配置（针对内存不足问题）

### 项目配置

#### Build Settings
```
Framework preset: None 或 Vue
Branch: main
Root directory: manager (或 seller / buyer)
Build command: yarn && yarn build
Build output directory: dist
```

#### Environment Variables（2个变量）
```
NODE_VERSION = 14.16.0
NODE_OPTIONS = --max-old-space-size=2048
```

---

## 📋 三个项目的完整配置

### Manager（管理端）
```
项目名: maollar-manager
分支: main
Root directory: manager
Build command: yarn && yarn build
Output directory: dist

环境变量:
NODE_VERSION = 14.16.0
NODE_OPTIONS = --max-old-space-size=2048
```

### Seller（商家端）
```
项目名: maollar-seller
分支: main
Root directory: seller
Build command: yarn && yarn build
Output directory: dist

环境变量:
NODE_VERSION = 14.16.0
NODE_OPTIONS = --max-old-space-size=2048
```

### Buyer（买家端）
```
项目名: maollar-buyer
分支: main
Root directory: buyer
Build command: yarn && yarn build
Output directory: dist

环境变量:
NODE_VERSION = 14.16.0
NODE_OPTIONS = --max-old-space-size=2048
```

---

## 🔧 配置步骤

### 1. 进入项目设置
- https://dash.cloudflare.com
- Workers & Pages → 你的项目 → Settings

### 2. 修改构建配置
**Builds & deployments** → **Edit configuration**

设置：
```
Build command: yarn && yarn build
Build output directory: dist
Root directory: manager (对应项目名)
```

点击 **Save**

### 3. 设置环境变量
**Environment variables** (Production)

添加两个变量：

**变量 1:**
```
Variable name: NODE_VERSION
Value: 14.16.0
```

**变量 2:**
```
Variable name: NODE_OPTIONS
Value: --max-old-space-size=2048
```

点击 **Save**

### 4. 重新部署
**Deployments** → 点击失败的部署 → **...** → **Retry deployment**

---

## 💡 关于 NODE_OPTIONS 的说明

### --max-old-space-size=2048 是什么？

这个参数限制 Node.js 使用最多 2GB 内存：
- 默认情况下，Node.js 在 32 位系统限制为 512MB
- 在 64 位系统限制为 1.4GB
- 设置为 2048 可以使用 2GB 内存
- 足够编译 Vue 项目，又不会超过 Cloudflare 限制

### 为什么需要这个？

Vue CLI 构建大型项目时：
- Webpack 需要大量内存
- 编译、压缩、优化都很耗内存
- 不设置会触发 OOM (Out of Memory)

---

## 🎯 预期结果

设置正确后，构建日志应该显示：

```
13:XX:XX Cloning repository...
13:XX:XX Installing dependencies
13:XX:XX yarn install v1.22.19
13:XX:XX [1/4] Resolving packages...
13:XX:XX [2/4] Fetching packages...
13:XX:XX [3/4] Linking dependencies...
13:XX:XX [4/4] Building fresh packages...
13:XX:XX Done in XXs.
13:XX:XX Building application
13:XX:XX yarn run v1.22.19
13:XX:XX $ vue-cli-service build
13:XX:XX ⠹  Building for production...
13:XX:XX ⠸  Building for production...
13:XX:XX DONE  Build complete
13:XX:XX Success: Uploaded XX files
```

构建时间：约 8-15 分钟

---

## 🆘 如果还是失败

### 错误 126: 命令权限问题
**检查**：
- Root directory 是否正确（manager/seller/buyer）
- 构建命令是否没有引号

### 错误 9: 仍然内存不足
**解决**：可以尝试增加内存限制
```
NODE_OPTIONS = --max-old-space-size=3072
```
（改为 3GB）

### 其他错误
把完整日志发给我，包括：
1. 错误发生前 20 行
2. 错误信息
3. 错误发生后 5 行

---

## 📊 配置对比

| 配置项 | 值 |
|--------|-----|
| Framework preset | None 或 Vue |
| Build command | `yarn && yarn build` |
| Output directory | `dist` |
| Root directory | `manager` / `seller` / `buyer` |
| NODE_VERSION | `14.16.0` |
| NODE_OPTIONS | `--max-old-space-size=2048` |

---

**现在去 Cloudflare 添加这两个环境变量，然后重试部署！** 🚀
