#!/usr/bin/env bash
# 通用依赖检查：由生成的模块 Skill 在启动时调用
# 用法: bash $SKILL_DIR/scripts/check-deps.sh
set -u
FAIL=0
need() {
  if command -v "$1" >/dev/null 2>&1; then
    echo "[OK] $1"
  else
    echo "[MISS] $1  安装提示: $2"
    FAIL=1
  fi
}
# 基础依赖
need git "安装 git 或联系管理员"
# 以下按模块技术栈自行取消注释或增删
# need node "安装 Node.js LTS 版本"
# need python3 "安装 Python 3.x"
if [ "$FAIL" -ne 0 ]; then
  echo DEPS_MISSING
  exit 1
fi
echo DEPS_OK
