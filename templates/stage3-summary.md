# 阶段 3：交付（验证汇总 → 提交 → PR/MR → 交付报告）

## Part 1 验证证据汇总

汇总阶段 2 全部验证记录：命令原文 + PASS/FAIL + 失败修复轮次。
存在未解释的 FAIL → 回阶段 2 修复，不许带病交付。

## Part 2 提交

    cd $MOD_DIR
    git status --short
    git add -A
    git commit -m "feat: {一句话变更摘要}"

- commit message 用 Conventional Commits：feat/fix/refactor/test/docs
- 仓库另有提交规范时以仓库规范为准

## Part 3 PR/MR

- gh 或 glab 可用：创建 PR/MR，描述附需求、变更点、验证证据
- CLI 不可用：输出当前分支名与 push 命令，请用户手动推送

## Part 4 交付报告

向用户输出汇总：
1. 需求：一句话
2. 变更：文件列表 + 每个文件做了什么
3. 验证：证据摘要（PASS 项与修复轮次）
4. 提交：commit hash、分支、PR/MR 链接或手动 push 指引
5. 遗留：未解决项与建议

最后把本报告写入 stages/stage3-report.md，并更新 _progress.md 标记阶段 3 done。
