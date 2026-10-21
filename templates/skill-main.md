---
name: autodev-{模块名}
description: >-
  模块 {模块名} 的自主开发 Skill。输入需求（自然语言或 issue 链接），
  按 阶段1 计划 → 阶段2 开发 → 阶段3 交付 的固化流程完成开发、
  验证与提交。触发关键词：自主开发 {模块名}、AI 开发 {模块名}。
metadata:
  builder_version: {当前builder版本，从安装目录 meta-info.json 读取}
---

# {模块名} 自主开发 Skill

本 Skill 由 autodev-skill-builder 采访生成，固化了模块的开发与验证流程。
每次执行需求严格按阶段推进，任何阶段失败先修复再继续。

## 路径约定

- $SKILL_DIR：本 Skill 所在目录
- $MOD_DIR：模块仓库根目录（执行时由主流程传入）
- 运行时数据目录：~/.autodev-{模块名}/data/（凭证与临时产物，禁止写入仓库）
- 进度记录：$MOD_DIR/stages/_progress.md

## 启动检查

每次执行前先运行依赖检查，输出 DEPS_OK 才能进入阶段 1；
DEPS_MISSING 时把缺失项与安装提示告知用户并停止：

    bash $SKILL_DIR/scripts/check-deps.sh

## 阶段流程总览

| 阶段 | 文件 | 产出 |
|---|---|---|
| 阶段1 计划 | stages/stage1-planning.md | 需求确认 + 验证方案 + 开发计划 |
| 阶段2 开发 | stages/stage2-development.md | 代码变更 + 自主验证证据 |
| 阶段3 交付 | stages/stage3-summary.md | 提交 + PR/MR + 交付汇总 |

每完成一个 Part，把结论写入对应产出文档并刷新 _progress.md。
中断恢复：先读 _progress.md，从最后一个未完成 Part 继续，不重做已完成项。

## 异常处理

| 场景 | 处置 |
|---|---|
| 依赖检查失败 | 告知缺失项与安装提示，停止 |
| 验证连续 3 轮失败 | 停止，汇总根因分析请用户决策 |
| 破坏性 git 操作 | 先向用户确认 |

## 硬性约束

- 变更收敛在需求范围内
- 验证证据（命令原文 + PASS/FAIL）必须保留在产出文档
- 不在输出中粘贴密钥、token
