#!/usr/bin/env bash
# redline-check.sh — AI 生成代码红线静态扫描（shell 版）
# 用法: bash scripts/redline-check.sh <file-or-dir>   返回非0=有红线
set -u
TARGET="${1:-.}"
WL='api\.openai\.com|api\.anthropic\.com|api\.deepseek\.com|open\.bigmodel\.cn|dashscope\.aliyuncs\.com|api\.moonshot\.cn'
TMP=$(mktemp); : > "$TMP"

scan() {
  f="$1"
  grep -nE '\beval *\(|new +Function *\(' "$f" 2>/dev/null | head -2 | sed "s|^|[R1] $f:|" >> "$TMP"
  grep -nE "fetch *\( *['\"]https?://" "$f" 2>/dev/null | grep -Ev "$WL" | head -2 | sed "s|^|[R2] $f:|" >> "$TMP"
  grep -nE "['\"]sk-[A-Za-z0-9]{20,}['\"]" "$f" 2>/dev/null | head -2 | sed "s|^|[R4] $f:|" >> "$TMP"
  grep -n '\.innerHTML' "$f" 2>/dev/null | head -2 | sed "s|^|[R5] $f:|" >> "$TMP"
}

if [ -f "$TARGET" ]; then scan "$TARGET"
else
  find "$TARGET" -type f \( -name '*.js' -o -name '*.ts' -o -name '*.py' -o -name '*.go' -o -name '*.html' \) \
    ! -path '*/node_modules/*' ! -path '*/.git/*' 2>/dev/null | while read -r f; do scan "$f"; done
fi

if [ -s "$TMP" ]; then
  echo "=== 红线检出（需人工复核）==="; cat "$TMP"; rm -f "$TMP"; exit 1
else
  echo "OK 未检出红线"; rm -f "$TMP"; exit 0
fi
