# 代码生成轨迹模板

每次 AI 生成代码后，复制本模板填写，追加到 docs/traces/。

## 字段

- ts: 时间
- task: 任务一句话
- model: 模型名
- prompt_digest: 提示词摘要（50字内）
- files_changed: 变更文件列表
- redline: redline-check.sh 结果（pass / fail+清单）
- review: 人工复核轮次
- rework: 是否返工及原因

## 样本（单行 JSON）

    {"ts":"2026-11-04","task":"待办页加拖拽排序","model":"glm-4-flash","prompt_digest":"拖拽+持久化","files_changed":["app.js"],"redline":"pass","review":1,"rework":false}
