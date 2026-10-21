# AutoDev 通用需求交付 Skill

给定一个代码仓库和一段需求，自动检测/构建模块级自主开发 Skill，
按 计划 → 开发 → 交付 三阶段完成开发、自主验证并提交变更。
模块 Skill 一次构建、随仓入库（.agents/skills/）、长期复用。

## 包结构

    SKILL.md                    主入口：编排逻辑（检测/三分支/约束）
    meta-info.json              版本元数据（builder 版本来源）
    scripts/detect-skill.sh     模块 Skill 检测与版本比对
    templates/skill-main.md     生成的模块 Skill 主模板
    templates/stage1-planning.md    阶段1：需求确认/验证方案/开发计划
    templates/stage2-development.md 阶段2：开发与自主验证
    templates/stage3-summary.md     阶段3：提交/PR/交付报告
    templates/task-tracking.md      进度跟踪与恢复约定
    templates/scripts/check-deps.sh 依赖检查
    references/interview-guide.md   Builder 采访指南
    tasks/lessons.md                经验教训记录

## 安装（任意兼容 SKILL.md 约定的 CLI Agent）

    mkdir -p ~/.agents/skills
    cp -r <本目录> ~/.agents/skills/autodev

（Claude Code 用 ~/.claude/skills，Comate 用 ~/.comate/skills）

## 调用

对 Agent 说：

    仓库：<git 地址或本地路径>
    分支：<可选，默认 main>
    需求：<自然语言描述 或 issue 链接>

流程：检测模块 Skill → MISS 则采访构建（Builder）/ 版本落后则升级
（Updater）/ 就绪则执行开发（Runner，计划过审后动代码）。

## 版本

生成物 frontmatter 的 metadata.builder_version 与本包 meta-info.json
的 version 对齐，当前 1.0.0。版本比较使用语义化序（sort -V）。

## 版权与使用许可

本仓库内容（组织架构、专家角色设计、技能文档、模板与脚本）版权归作者所有，保留所有权利。

- 仅供个人学习与研究使用
- 未经作者书面许可，禁止商用、二次分发、打包转售
- 引用时请注明来源

版权所有 © 2026 donglingjiu
