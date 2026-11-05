# LLMOps 指标规范

对标：Dify 全链路 LLMOps 观测（token / 延迟 / 成本看板）

## 指标 Schema（每模块 Skill / 每次 LLM 调用）
| 指标 | 类型 | 采集点 |
|---|---|---|
| tokens_in / tokens_out | counter | llmproxy 调用返回后 |
| latency_first_ms | gauge | 流式首 token 延迟 |
| latency_total_ms | gauge | 请求全量延迟 |
| cost | derived | tokens x 模型单价表 |
| error_rate | ratio | 非 200 / 超时 / 截断 |
| cache_hit | ratio | 前缀缓存命中（如支持） |

## 上报约定
- 每模块 deliver 阶段输出 metrics.json 附到交付物目录
- 聚合口径三层：per-run / per-module / per-model
- 报警阈值建议：latency P99 > 8s；error_rate > 5%；cost 超预算 120%

## 模型单价表（示例，部署时按需维护）
| provider | model | in $/1M | out $/1M |
|---|---|---|---|
| openai | gpt-4o | 2.50 | 10.00 |
| anthropic | claude-3.5-sonnet | 3.00 | 15.00 |
| deepseek | deepseek-chat | 0.14 | 0.28 |
