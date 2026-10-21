#!/usr/bin/env bash
# 用法: detect-skill.sh <本地模块目录> <模块名>
# 输出: MISS | NEED_UPDATE <cur> <new> | UP_TO_DATE <skill_dir> | BUILDER_UNAVAILABLE
set -u
MOD_DIR="$1"; MOD_NAME="$2"
HOME_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BUILDER_META="$HOME_DIR/meta-info.json"

SKILL_DIR=""
for base in .agents/skills .claude/skills .comate/skills; do
  cand="$MOD_DIR/$base/autodev-$MOD_NAME"
  [ -f "$cand/SKILL.md" ] && { SKILL_DIR="$cand"; break; }
done
[ -z "$SKILL_DIR" ] && { echo "MISS"; exit 0; }

CUR=$(grep -m1 'builder_version:' "$SKILL_DIR/SKILL.md" \
      | sed 's/.*builder_version:[[:space:]]*//; s/"//g; s/'"'"'//g' | tr -d '[:space:]')
NEW=""
[ -f "$BUILDER_META" ] && NEW=$(sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "$BUILDER_META" | head -1)

if [ -z "$NEW" ]; then
  echo "BUILDER_UNAVAILABLE"
elif [ -z "$CUR" ] || [ "$CUR" = "Unknown" ]; then
  echo "NEED_UPDATE $CUR $NEW"
elif [ "$CUR" = "$NEW" ]; then
  echo "UP_TO_DATE $SKILL_DIR"
elif [ "$(printf '%s\n%s\n' "$CUR" "$NEW" | sort -V | head -1)" = "$CUR" ]; then
  echo "NEED_UPDATE $CUR $NEW"
else
  echo "UP_TO_DATE $SKILL_DIR"
fi
