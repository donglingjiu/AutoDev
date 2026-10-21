# Java 编码规范（提炼版）

来源：阿里巴巴 Java 开发手册 github.com/alibaba/p3c、Google Java Style。
Rule 级不得违反；与模块既有风格冲突时以模块为准并保持局部一致。

## 命名（Rule）

- 类 UpperCamelCase；方法/变量 lowerCamelCase；常量 UPPER_SNAKE_CASE；包名全小写
- 禁止拼音英文混用命名；布尔成员不加 is 前缀（序列化陷阱）
- 禁止魔法值：出现两次以上的字面量提为常量

## 语法与实践（Rule）

- if/else/for/while 单行也必须带大括号
- POJO 属性用包装类型；RPC 方法返回与参数禁用原生类型
- 集合遍历中禁止直接 add/remove，用 Iterator、removeIf 或收集后再改
- 初始化可预估容量的集合显式指定 initialCapacity
- SimpleDateFormat 线程不安全：并发场景用 DateTimeFormatter
- 线程池用 ThreadPoolExecutor 显式创建并指定参数，禁用 Executors 快捷工厂
- 禁止捕获异常后空处理；事务方法内 catch 吞异常会导致回滚失效，必须重抛
- 对外 API 用 Optional 表达可能为空；equals 常量在前防 NPE

## 格式（Advice）

- 4 空格缩进，单行不超过 120 字符；公共方法补 Javadoc
- 接入 SpotBugs/PMD/Checkstyle 任一静态检查
