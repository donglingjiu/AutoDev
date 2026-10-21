# PHP 编码规范（提炼版）

来源：PSR-1 / PSR-12（php-fig.org/psr）、PSR-4 自动加载、PHP 官方文档。
Rule 级不得违反；与模块既有风格冲突时以模块为准并保持局部一致。

## 文件与命名空间（Rule）

- 所有 PHP 文件以完整标签开头，文件末尾不写闭合标签
- 命名空间遵循 PSR-4，与 composer.json 的 autoload 目录一一对应
- declare(strict_types=1) 必须写在文件最前面

## 命名（Rule）

- 类 PascalCase、文件名与类名一致；方法与函数 camelCase；
  常量 UPPER_SNAKE_CASE；变量 lowerCamelCase
- 接口名不加 I 前缀；全项目统一风格

## 语法（Rule）

- 4 空格缩进，单行不超过 120 字符
- 数组一律用短语法方括号，不用旧式 array 写法
- 严格比较用全等与不全等，禁止弱比较造成的隐式类型转换
- 函数与方法的参数、返回值必须写类型声明
- 类属性必须写类型声明（PHP 7.4 及以上）

## 安全（Rule）

- SQL 一律用预处理语句或 ORM 参数绑定，禁止字符串拼接
- 输出转义：HTML 用 htmlspecialchars；JSON 响应统一编码并抛出转换异常
- 禁止对用户输入使用 eval、shell_exec、system
- 上传文件校验 MIME 与扩展名白名单，存储到非 web 可执行目录

## 工程实践（Rule）

- composer.json 与 composer.lock 一并入库锁版本
- php -l 语法检查通过；建议接入 phpstan 或 psalm 静态分析
- 单元测试用 PHPUnit，tests 目录与 src 对应

## Advice

- 用 PHP-CS-Fixer 统一风格
- 异常统一继承项目自定义基类；框架项目用框架异常体系
