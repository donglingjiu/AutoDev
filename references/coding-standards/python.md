# Python 编码规范（提炼版）

来源：PEP 8、PEP 484、Google Python Style Guide。Rule 级不得违反。

## 命名与格式（Rule）

- 模块/函数/变量 snake_case；类 PascalCase；常量 UPPER_SNAKE_CASE
- 4 空格缩进；统一用 black + isort 格式化（行宽按模块约定，默认 100）
- 字符串格式化用 f-string；路径操作用 pathlib

## 类型与异常（Rule）

- 公共函数/方法必须有类型注解；mypy（或 pyright）校验通过
- 捕获具体异常类型，禁止裸 except 与吞异常；
  自定义异常继承项目统一基类
- 资源一律用 with 管理文件/连接/锁

## 工程实践（Rule）

- 依赖写入 requirements.txt 或 lock 文件并固定版本
- 公共函数提供 Google 风格 docstring（Args/Returns/Raises）
- 单元测试用 pytest，测试文件与被测模块对应

## Advice

- 用 ruff 做 lint（替代 flake8+pylint 组合）
- 数据类优先 dataclass；避免可变默认参数
