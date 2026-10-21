# Go 编码规范（提炼版）

来源：Effective Go（go.dev/doc/effective_go）、Go Code Review Comments。
Rule 级不得违反。

## 格式与命名（Rule）

- gofmt/goimports 强制通过；导出符号有 doc comment
- 命名短而准：驼峰、不用下划线；缩写保持一致（Id/URL/HTTP 全大写或全小写）
- 接口定义在使用方；返回具体类型

## 错误与并发（Rule）

- if err != nil 必须显式处理，禁止用 _ 丢弃 error；
  错误传递用 fmt.Errorf 配 %w 包装保留错误链
- context.Context 作为首个参数层层传递；请求链路设置超时
- goroutine 必须有明确退出路径（ctx/信号/channel），防止泄漏；
  共享状态用 mutex 或 channel 保护，map 并发读写必须加锁

## 工程实践（Rule）

- 包循环依赖禁止；全局可变状态最小化
- 单元测试与被测文件同目录 _test.go；表驱动测试优先
- go vet 通过；建议接入 golangci-lint/staticcheck
