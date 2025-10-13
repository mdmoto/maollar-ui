# ⚡ Cloudflare Pages 最简配置（保证成功）

## ❌ 错误 126 的原因

- 构建命令格式错误
- 引号使用不当
- 命令不存在

---

## ✅ 正确的 Cloudflare 配置

### Build Settings（构建设置）

```
Framework preset: None
Build command: yarn install && yarn build
Build output directory: dist
Root directory: manager (或 seller / buyer)
```

**注意**：
- ❌ 不要用双引号包裹命令
- ❌ 不要用复杂的 NODE_OPTIONS
- ✅ 使用最简单的命令

---

### Environment Variables（环境变量）

**只设置一个变量**：

```
NODE_VERSION = 14.16.0
```

**不要设置**：
- ❌ NODE_OPTIONS
- ❌ YARN_VERSION
- ❌ 其他任何变量

---

## 🎯 分项目配置清单

### Manager
```
项目名: maollar-manager
分支: main
Framework preset: None
Root directory: manager
Build command: yarn install && yarn build
Output directory: dist

环境变量:
NODE_VERSION = 14.16.0
```

### Seller
```
项目名: maollar-seller
分支: main
Framework preset: None
Root directory: seller
Build command: yarn install && yarn build
Output directory: dist

环境变量:
NODE_VERSION = 14.16.0
```

### Buyer
```
项目名: maollar-buyer
分支: main
Framework preset: None
Root directory: buyer
Build command: yarn install && yarn build
Output directory: dist

环境变量:
NODE_VERSION = 14.16.0
```

---

## 💡 如果还是失败

### 建议：使用本地构建

Cloudflare Pages 的构建环境对这个项目可能太严格了。

**最可靠的方案是本地构建**：

```bash
# 1. 本地构建
cd /Users/adam/maollar-project/frontend
./本地构建直接部署.sh

# 2. 使用 Wrangler 部署
cd manager
npx wrangler pages deploy dist --project-name=maollar-manager
```

这样可以完全避开 Cloudflare 的构建限制。

---

## 📊 方案对比

| 方案 | 优点 | 缺点 | 推荐度 |
|------|------|------|--------|
| Git 自动构建 | 自动化，推送即部署 | 构建环境限制多，容易失败 | ⭐⭐ |
| 本地构建 + Wrangler | 100% 可控，必定成功 | 需要手动操作 | ⭐⭐⭐⭐⭐ |

---

**我的建议：直接使用本地构建！**

现在就运行：
```bash
cd /Users/adam/maollar-project/frontend
./本地构建直接部署.sh
```
