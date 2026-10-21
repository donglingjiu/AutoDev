# TypeScript / JavaScript 编码规范（提炼版）

来源：Airbnb JavaScript Style Guide（github.com/airbnb/javascript）、
TypeScript strict 模式实践。Rule 级不得违反。

## 类型（Rule）

- tsconfig 开 strict；禁止 any（不确定类型用 unknown 再收窄）
- 公共函数/组件 props 必须有显式类型；优先 type/interface 而非 any 断言
- 相等判断用 ===；判空统一 null 与 undefined 策略（?? 与 ?.）

## 语法（Rule）

- 优先 const；需要重绑定才用 let，禁 var
- 字符串拼接用模板字符串；对象/数组解构赋值
- 异步统一 async/await；promise 必须处理 reject 或 catch
- 模块用 ESM import/export，禁 require 混用

## React（Rule，模块含前端时）

- 函数组件 + hooks；不用 class 组件
- props 定义类型并给默认值；列表渲染 key 必须稳定唯一（禁用数组下标当 key 随机增删场景）
- useEffect 依赖数组完整；事件回调命名 handleXxx

## 工程实践（Rule）

- eslint + prettier 配置入库并通过；提交前无 lint 报错
