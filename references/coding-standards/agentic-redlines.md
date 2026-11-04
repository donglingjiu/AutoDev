# Agentic 代码红线（AI 生成代码强制规范）

适用于所有 AI 生成/修改的代码，交付前必须通过 scripts/redline-check.sh。

## 红线清单

| # | 规则 | 说明 |
|---|---|---|
| R1 | 禁止 eval / new Function | 动态执行不可控 |
| R2 | 禁止白名单外外部 fetch | 白名单见 redline-check.sh |
| R3 | 输入输出需 schema 校验 | zod / ajv / 手写 validator（人工确认项） |
| R4 | 禁止硬编码密钥 | sk- 前缀 key 一律拒绝 |
| R5 | 谨慎 innerHTML | 赋值需确认已净化（XSS） |

## 执行

    bash scripts/redline-check.sh <file-or-dir>

返回非0 = 存在红线，禁止交付。

## 与 web-delivery-team 的关系

JS 版本见 web-delivery-team/scripts/redline-check.js（浏览器/Node 双端）；
本脚本为 shell 版，用于 CI 与本地静态扫描，规则保持一致。
