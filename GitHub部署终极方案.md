# 🎯 Cloudflare Pages GitHub 部署 - 终极方案

## ✅ 完整配置清单

### 项目：maollar-manager

#### 1. Build configuration
```
Framework preset: None (或 Vue)
Branch: main
Root directory: manager
Build command: yarn && yarn build
Build output directory: dist
```

#### 2. Environment variables
```
NODE_VERSION = 14.16.0
```

**仅此一个变量！其他都不要设置！**

---

### 项目：maollar-seller

#### 1. Build configuration
```
Framework preset: None (或 Vue)
Branch: main
Root directory: seller
Build command: yarn && yarn build
Build output directory: dist
```

#### 2. Environment variables
```
NODE_VERSION = 14.16.0
```

---

### 项目：maollar-buyer

#### 1. Build configuration
```
Framework preset: None (或 Vue)
Branch: main
Root directory: buyer
Build command: yarn && yarn build
Build output directory: dist
```

#### 2. Environment variables
```
NODE_VERSION = 14.16.0
```

---

## 🔍 常见错误检查

### ❌ 错误 1: 构建命令格式错误

**错误示例**：
- `"yarn && yarn build"` (有引号)
- `yarn install && yarn build` (太冗余)
- `npm run cf:build` (错误的包管理器)

**正确格式**：
```
yarn && yarn build
```

不要加任何引号！

---

### ❌ 错误 2: Root directory 未设置

如果 Root directory 是空的或设置为 `/`，构建会失败。

**必须设置为**：
- Manager: `manager`
- Seller: `seller`
- Buyer: `buyer`

---

### ❌ 错误 3: 多余的环境变量

删除这些环境变量（如果有）：
- ❌ `NODE_OPTIONS`
- ❌ `YARN_VERSION`
- ❌ `NPM_FLAGS`
- ❌ 任何其他变量

**只保留**：
- ✅ `NODE_VERSION = 14.16.0`

---

## 📋 逐步操作指南

### Step 1: 进入项目设置
1. 打开 https://dash.cloudflare.com
2. Workers & Pages
3. 选择你的项目（例如 maollar-manager）
4. 点击 **Settings**

---

### Step 2: 检查并修改构建配置

找到 **Builds & deployments** 部分

#### A. Production 配置
点击 **Edit configuration**，确保：
- Framework preset: `None` 或 `Vue`
- Build command: `yarn && yarn build`
- Build output directory: `dist`
- Root directory: `manager` (对应项目)

点击 **Save**

#### B. 环境变量
找到 **Environment variables** (Production)

1. 删除所有现有变量
2. 添加新变量：
   - Variable name: `NODE_VERSION`
   - Value: `14.16.0`
3. 点击 **Save**

---

### Step 3: 触发新部署

#### 方式 A: 重试现有部署
1. 回到 **Deployments** 页面
2. 找到最新的失败部署
3. 点击右边的 **...** 菜单
4. 选择 **Retry deployment**

#### 方式 B: 创建新部署
1. 点击 **Create deployment**
2. 选择分支 `main`
3. 开始构建

---

### Step 4: 观察构建日志

构建开始后，点击部署记录查看实时日志。

**应该看到**：
```
✓ Cloning repository...
✓ Installing dependencies
yarn install v1.22.x
...
✓ Building application
yarn run v1.22.x
...
✓ Success!
```

**如果失败**：
- 复制完整错误日志
- 告诉我具体的错误信息

---

## 🆘 故障排除

### 问题 1: "yarn: command not found"
**原因**：Cloudflare 构建环境未识别 yarn

**解决**：将构建命令改为
```
npm install -g yarn && yarn && yarn build
```

---

### 问题 2: "Error code: 9" (内存不足)
**原因**：构建占用内存太大

**解决**：添加环境变量
```
NODE_OPTIONS = --max-old-space-size=2048
```

---

### 问题 3: "Error code: 126" (权限错误)
**原因**：构建命令格式或路径问题

**解决**：
1. 确认 Root directory 正确设置
2. 确认构建命令没有引号
3. 尝试简化为: `yarn build`

---

### 问题 4: 依赖安装失败
**原因**：npm 版本冲突

**解决**：添加 `.npmrc` 或使用 yarn（已经做了）

---

## 💡 终极备选方案

如果 GitHub 自动构建实在不行，使用本地构建：

```bash
# 1. 本地构建
cd /Users/adam/maollar-project/frontend/manager
yarn && yarn build

# 2. 使用 Wrangler 部署
npx wrangler pages deploy dist --project-name=maollar-manager
```

这样 100% 成功！

---

## 📞 需要帮助？

如果按照这个配置还是失败，请提供：
1. 完整的构建日志（从开始到错误）
2. Cloudflare 项目的完整配置截图
3. 具体的错误代码

我会帮你精确诊断！

---

**现在就去 Cloudflare 按照这个配置修改吧！** 🚀
