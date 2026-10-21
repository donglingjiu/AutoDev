# RESTful API 设计规范（提炼版）

来源：Microsoft REST API Guidelines（github.com/microsoft/api-guidelines）、
Zalando RESTful API Guidelines（github.com/zalando/restful-api-guidelines）、
Google AIP（google.aip.dev）、RFC 7807。Rule 级条目不得违反。

## 资源与路径（Rule）

- 路径用复数名词资源，不放动词：GET /v1/users/{id}/orders；动作类用子资源表达
    POST /v1/users/{id}/password-reset
- 路径段 kebab-case，查询参数与 JSON 字段 camelCase，全 API 统一
- 版本入路径：/v1/...；废弃接口先标 deprecated 并给迁移期

## 方法与状态码（Rule）

- 语义：GET 只读安全；POST 创建/非幂等；PUT 全量幂等；PATCH 局部；DELETE 幂等
- 200 成功带体；201 创建（返回资源，可带 Location）；204 无体；202 已受理异步
- 400 参数错误；401 未认证；403 无权限；404 不存在；409 冲突；
  422 校验失败；429 限流；500 服务器错误。不许 200 包错误体

## 响应与错误（Rule）

- 错误结构统一：优先 RFC 7807 problem+json，或团队统一 envelope：
  code、message、details、traceId 四要素必备
- 时间一律 ISO 8601 UTC（2025-01-15T08:00:00Z）；金额用字符串/整数分，不用浮点

## 分页、过滤、幂等（Rule）

- 列表必须分页：page+size 或 cursor，响应含 total/next 游标
- 过滤/排序参数白名单校验，禁止直传 SQL 片段
- POST 需要幂等时使用 Idempotency-Key 请求头

## 安全（Rule）

- 鉴权信息走 Authorization 头，URL 与日志中不出现 token/密码
- 输入全部校验；响应不泄漏内部实现细节（堆栈、SQL、内网地址）

## Advice

- 批量操作提供 batch 端点控制请求数；大导出走异步任务（202 + 进度查询）
- 变更只增不改语义；新增字段给默认值保证旧客户端兼容
