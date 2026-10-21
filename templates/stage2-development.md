# 阶段 2：开发（准备 → 实现 → 自主验证 → 收敛）

## Part 0 任务恢复检查

读 $MOD_DIR/stages/_progress.md：有未完成 Part 从该处继续；否则全新开始。

## Part 1 开发前准备

1. 读模块文档与阶段 1 产出（stage1-part3.md 验证方案、stage1-part4.md 开发计划）
2. 编码规范强制前置（不可跳过）：
   - 必读 references/coding-standards/ 下与模块语言对应的文件，
     文件清单由 Builder 生成时写入：{coding_standards_files}
   - 通用必读：architecture-guidelines.md
   - 模块对外提供 HTTP API 时必读 restful-api.md
   - 产出代码逐条遵守 Rule 级条目（Advice 级尽量遵守）；
     与模块既有风格冲突时以模块既有约定为准并保持局部一致；
     多语言模块各按各的规范文件

## Part 2 编码实现

按开发计划的里程碑顺序实现；每完成一个里程碑记录：变更文件清单 + 变更说明。
变更必须收敛在需求范围内，发现范围外问题记入遗留清单而不是顺手改。

## Part 3 自主验证

按 stage1-part3.md 的验证方案逐项执行：
1. 静态检查（lint/编译）→ 单元测试 → 功能验证，顺序执行
2. 每项记录：命令原文 + 输出摘要 + PASS/FAIL，写入 stages/stage2-verify-{n}.md
3. 失败处理：根因分析 → 修复 → 重新验证；连续 3 轮失败停止并上报用户
4. 模块规范了静态检查工具的，以模块规范为准

## Part 4 完成标志

全部验证 PASS + git status 确认无范围外变更文件 →
更新 _progress.md 标记阶段 2 done，进入阶段 3。
