---
name: autodev
description: >-
  通用需求交付 Agent。给定代码仓库地址和需求（自然语言或 issue 链接），先检测
  该模块是否已有自主开发 Skill：没有就通过采访固化开发与验证流程并随仓入库；
  有则直接按该 Skill 自主开发、验证并提交变更。用户提到 autodev、自主开发、
  模块级 Skill 开发时使用本 skill。
---

# AutoDev 通用需求交付

一个代码仓库 + 一段需求 → 自主完成开发、验证、提交。
模块级 Skill 每个模块只建一次，随仓库入库（`.agents/skills/`），团队共享复用。

本 skill 安装目录即本文件所在目录，下文记为 `{AUTODEV_HOME}`。

## 输入

- **代码仓库**（必须）：任意 git URL（https/ssh）、`user/repo` 简写或本地已有路径
- **分支**（可选）：拿不到默认 `main`，**不向用户索要**
- **需求**（必须）：自然语言描述或 issue URL（GitHub 用 `gh issue view`，
  GitLab 用 `glab issue view`；拉取失败就把 URL 退回让用户直接描述需求）

缺仓库或需求时用 AskUserQuestion 补问。绝不猜测仓库地址，不用写死的默认值。

## 流程

### Step 1 — 入参解析
仓库 URL → 提取仓库路径；**模块名** = 路径最后一段（去掉 `.git`）。
**本地模块目录** = `{工作目录}/{仓库路径}`。需求是 issue URL → 用平台 CLI
拉标题和正文作为需求文本。

### Step 2 — 拉取代码
本地已有（`{本地模块目录}/.git` 存在）→ 只更新不重克隆：

    cd {本地模块目录} && git fetch origin
    git checkout {分支} 2>/dev/null || git checkout -b {分支} origin/{分支}
    git pull --ff-only origin {分支}

工作区有未提交改动导致失败 → 列出改动文件与 stderr，AskUserQuestion
让用户决定处理方式，**不强制覆盖**。本地不存在 → 直接 `git clone -b {分支} {仓库URL} {本地模块目录}`；
失败贴 stderr 指明动作（申请权限/配 SSH key），不重试超过一次。

### Step 3 — 检测模块 Skill

    bash "{AUTODEV_HOME}/scripts/detect-skill.sh" "{本地模块目录}" "{模块名}"

输出其一：`MISS` / `NEED_UPDATE {旧版本} {新版本}` / `UP_TO_DATE {skill目录}` / `BUILDER_UNAVAILABLE`。

### Step 4 — 按结果走分支（单 Agent 内顺序执行，不派子任务）
- **MISS** → Builder 模式
- **NEED_UPDATE** → Updater 模式
- **UP_TO_DATE** → Runner 模式
- **BUILDER_UNAVAILABLE** → 报错停止：`{AUTODEV_HOME}/meta-info.json` 缺失，修复安装

### Step 5 — 收尾
汇总本次交付（改动内容、验证结果、commit/PR 信息），并写入
`{本地模块目录}/.autodev-state.json` 记录本次需求与结果。

## Builder 模式（构建模块 Skill）
目标：把「这个模块怎么开发、怎么验证」固化成
`{本地模块目录}/.agents/skills/autodev-{模块名}/`（固定路径，不问用户）。

1. **探索模块**：构建工具、测试命令、目录结构、已有 lint/规范配置
2. **采访**：用 `{AUTODEV_HOME}/templates/` 的模板，AskUserQuestion 逐项确认
   模块类型、技术栈、验证方案、提交流程——**每题附基于探索的推荐默认值**，
   用户可直接采纳
3. **生成**：按模板产出 SKILL.md 与各阶段文件，frontmatter 写入
   `metadata.builder_version`（读 `{AUTODEV_HOME}/meta-info.json` 的 version）
4. 覆盖已存在 Skill 前必须向用户确认

## Updater 模式（升级旧 Skill）
版本比较一律 `sort -V` 语义序，**禁止字符串比较**（否则 1.9.0 会被判成比 1.16.0 新）。
落后时：用 `{AUTODEV_HOME}/templates/` 同步框架结构、保留模块个性化配置、
刷新版本号。仅在模板删除章节/结构迁移时问用户，≤3 问。

## Runner 模式（执行需求）
读取命中的模块 Skill，按其阶段流程执行：
1. **需求确认**：与用户确认需求细节与验证方案
2. **计划过审**：开发计划整体过审后才动代码
3. **阶段执行**：按模块 Skill 固化流程开发 + 自主验证（静态 + 功能，
   保留 PASS/FAIL 证据；失败做根因分析并修复，记录轮次）
4. **变更收敛**：只改需求范围内的代码
5. **提交**：git commit；平台 CLI 可用时建 PR/MR
   （`gh pr create` / `glab mr create`），描述附验证证据

## 硬性约束
- 入参不全绝不启动开发；不猜仓库
- 破坏性操作（`git reset --hard`、`git clean -fd`、删仓库目录）先向用户确认
- 输出中不粘贴密钥、token
- 版本比较必须 `sort -V`
