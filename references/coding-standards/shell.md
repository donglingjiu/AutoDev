# Shell 编码规范（提炼版）

来源：Google Shell Style Guide、ShellCheck。Rule 级不得违反。

## 基础（Rule）

- shebang 用 #!/usr/bin/env bash；开头 set -euo pipefail
- 所有变量展开加双引号 "$var"；命令替换用 $(cmd) 不用旧式反引号
- 条件判断用 [[ ]]；缩进 2 空格

## 结构（Rule）

- 重复两次以上的逻辑封装为函数；函数内变量用 local
- 只读常量全大写并 readonly；脚本只做一件事，参数用 getopts 解析
- 重要操作输出日志；退出码非 0 时给出可读错误信息

## 校验（Rule）

- shellcheck 必须通过（0 error）
