# Vue 编码规范（提炼版）

来源：Vue 3 官方 Style Guide（vuejs.org/style-guide）、Composition API 最佳实践。
Rule 级不得违反。

## 组件（Rule）

- 组件名至少两个单词，SFC 文件用 PascalCase 命名，例如 UserProfile.vue，
  禁止单词名或全小写文件名
- template 中引用组件用 PascalCase 自闭合写法
- props 用 defineProps 显式声明类型与默认值；
  emits 用 defineEmits 显式声明全部事件

## 语法（Rule）

- Vue 3 统一 Composition API 加 setup 语法糖，禁止与 Options API 混用
- v-for 必须绑定稳定唯一 key；列表会增删时禁用数组下标当 key
- v-if 与 v-for 不得用于同一元素（优先级陷阱），过滤用 computed
- 响应式分工：ref 用于单值，reactive 用于对象，不混用同一状态
- 监听 DOM 原生事件用 kebab-case 写法

## 结构（Rule）

- SFC 三块顺序固定：script 在前、template 居中、style 收尾
- style 默认加 scoped；全局样式集中独立文件
- 组件逻辑超过 200 行时，可复用逻辑抽离为 composable（useXxx）

## 状态与路由（Rule）

- 跨组件状态用 Pinia（官方推荐），组件内状态留在组件内部
- 路由组件一律懒加载，用动态 import 写法减少首屏体积

## 工程实践（Rule）

- eslint-plugin-vue 推荐规则与 prettier 校验通过
- 与 TypeScript 协作时 props、emits 全部带类型

## Advice

- 模板表达式保持简单，复杂逻辑放 computed
- 大列表考虑虚拟滚动方案
