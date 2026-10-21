# Builder 采访指南（通用版）

目标：通过一次采访，把「该模块如何开发、如何验证」固化为随仓入库的
autodev-{模块名} Skill。采访前必须先自行探索模块，所有问题都要附上
基于探索结果的推荐默认值，用户可直接采纳。

## 采访前的探索

依次检查并记录：
1. 构建与依赖：package.json / go.mod / pom.xml / requirements.txt / Makefile / Cargo.toml
2. 脚本命令：README 与上述文件里的 build / test / lint 命令
3. 目录结构：源码、测试、配置的位置
4. 已有规范：.editorconfig、eslint、ruff 等配置
5. 分支与提交习惯：git log 最近 20 条的 message 风格、分支命名

## 问题清单（不超过 7 问，逐项 AskUserQuestion）

1. 模块定位：一句话说明该模块负责什么（默认：由目录结构与 README 推断）
2. 技术栈与运行方式（默认：按构建文件推断的语言与框架）
3. 构建/启动命令（默认：从 Makefile 或 package.json scripts 提取）
4. 测试与静态检查命令（默认：从 scripts 与 CI 配置提取；没有则建议补一个最小测试入口）
5. 验证通过标准：哪些命令全绿才算完成（默认：测试 + lint）
6. 提交约定：commit message 风格与目标分支（默认：Conventional Commits + 默认分支）
7. 需求来源约定：以后主要用自然语言还是 issue 链接（默认：两者都支持）

## 生成产物

采访完成后：
1. 按 templates/ 的 skill-main 与三个阶段模板，生成
   {模块目录}/.agents/skills/autodev-{模块名}/
2. frontmatter 的 metadata.builder_version 写入安装目录 meta-info.json 的 version
3. 复制 templates/scripts/check-deps.sh 到生成目录的 scripts/ 下
4. 覆盖已存在的同名 Skill 前必须向用户确认
