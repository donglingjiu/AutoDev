# 任务跟踪约定（生成的模块 Skill 适用）

## 运行时数据目录

- 路径：~/.autodev-{模块名}/data/
- 用途：Cookie、凭证、下载的附件等运行时产物
- 权限：目录 chmod 700，凭证文件 chmod 600
- 禁止写入 Skill 安装目录或模块仓库；禁止回显凭证内容

## 进度文件 _progress.md 模板

    # {模块名} 自主开发进度
    - 需求条目：{需求一句话摘要}
    - 输入形态：自然语言 / issue 链接
    ## 阶段 1 计划
    | Part | 状态 | 产出文件 |
    |---|---|---|
    | Part 2 需求确认 | pending | stage1-part2.md |
    | Part 3 验证方案 | pending | stage1-part3.md |
    | Part 4 开发计划 | pending | stage1-part4.md |
    | Part 5 计划落盘 | pending | stage1-part5.md |
    ## 阶段 2 开发
    | 开发里程碑 | 状态 | 验证记录 |
    ## 阶段 3 交付
    | Part | 状态 | 产出 |
    | 提交 | pending | commit hash |
    | 交付报告 | pending | stage3-report.md |

## 恢复规则

中断后重启时：读 _progress.md，找第一个非 done 项继续；
已 done 的 Part 不重做；状态与产出文件冲突时以产出文件为准。
