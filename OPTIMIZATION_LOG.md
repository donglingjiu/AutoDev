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
