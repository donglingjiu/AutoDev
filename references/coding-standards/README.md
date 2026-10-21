# 编码规范索引（全部为公开来源）

开发前按模块语言挑对应文件作为 checklist；模块提供 HTTP API 时必读 restful-api.md，
通用约束见 architecture-guidelines.md。Builder 生成模块 Skill 时把实际携带的文件
列表写入模板的 {coding_standards_files} 占位符。

## 已内置（提炼版）

| 文件 | 适用 | 主要来源 |
|---|---|---|
| java.md | Java | 阿里巴巴 Java 开发手册、Google Java Style |
| python.md | Python | PEP 8、Google Python Style |
| go.md | Go | Effective Go、Go Code Review Comments |
| typescript.md | TypeScript/JavaScript | Airbnb JavaScript Style、TS strict 实践 |
| php.md | PHP | PSR-1 / PSR-12 / PSR-4、PHP 官方文档 |
| vue.md | Vue 3 | Vue 官方 Style Guide、Composition API |
| shell.md | Shell | Google Shell Style Guide、ShellCheck |
| restful-api.md | HTTP API 设计 | Microsoft / Zalando / Google AIP、RFC 7807 |
| architecture-guidelines.md | 通用架构 | 12-Factor、业界通行实践 |

## 未内置语言的官方规范（按需查阅或自行补充）

| 语言 | 来源 |
|---|---|
| C++ | google.github.io/styleguide/cppguide.html |
| Kotlin | kotlinlang.org/docs/coding-conventions.html |
| Swift | swift.org/documentation/api-design-guidelines |
| Rust | rust-lang.github.io/api-guidelines |
| React | react.dev 与 Airbnb Style Guide |
| HTML/CSS | google.github.io/styleguide/htmlcssguide.html |
| Scala | docs.scala-lang.org/style |
