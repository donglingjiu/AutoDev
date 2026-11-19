# 迭代优化日志（OPTIMIZATION_LOG）

> 每次优化追加一条：变更 / 对标来源 / 优点 / 缺点与限制 / 影响面。新条目置顶。

---

## [2026-11-05] OPT-001 LLMOps 指标规范

### 变更
- 新增 references/llmops-metrics.md：token/latency/cost/error/cache 指标 schema + metrics.json 上报约定 + 报警阈值
- 新增 CI 结构校验

### 对标来源
- Dify 全链路 LLMOps 观测

### 优点
1. 模块 Skill 交付物统一携带 metrics.json，观测口径一致
2. 三层聚合（per-run/module/model）直接可映射监控大屏
3. cost 派生自单价表，换模型只改表不改采集

### 缺点 / 已知限制
1. 当前仅为规范文档，采集代码待下游（nebula-tools metrics.go）实现
2. 首字延迟需流式接口配合（未含实现）
3. 单价表需人工维护，模型调价存在滞后风险

### 影响面
- nebula-tools 监控大屏与报警按本规范落地


---

## [2026-11-06] OPT-002 通用需求交付机读契约 contract.json

### 变更
- 新增 contract.json（nova-builder-contract/v1）：入参规范 + 四模式分支（MISS/NEED_UPDATE/UP_TO_DATE/BUILDER_UNAVAILABLE）+ 五步流程 + 四条硬性约束 + 产物路径（.autodev-state.json / .agents/skills/autodev-{module}/）+ detect 脚本与 templates 映射
- 新增 scripts/validate_contract.py：模式键完整性/步骤计数/detect 脚本与模板存在性
- meta-info.json 已存在（v1.0），不动

### 对标来源
- OpenHands Agent 分支选择（状态机显式分支）
- 自身 SKILL.md Step1-5 + 三模式的形式化

### 优点
1. nebula-tools 工作台 S5 可机读模式分支与硬约束，Post-Hook 校验有据可依
2. detect-skill.sh 与 templates 的存在性进入 CI，引用悬空当场暴露

### 缺点 / 已知限制
1. 模式分支的语义执行仍靠 Agent 运行时；契约只锁结构
2. 模块 Skill 固化路径约定（.agents/skills/）暂无结构校验
