#!/usr/bin/env bash
set -euo pipefail
fail() { echo "::error::$1"; exit 1; }
warn() { echo "::warning::$1"; }
[ -s references/llmops-metrics.md ] || fail "references/llmops-metrics.md missing or empty"
for k in tokens_in latency cost error_rate; do
  grep -q "$k" references/llmops-metrics.md || fail "llmops-metrics.md missing metric $k"
done
if [ ! -s SKILL.md ] && [ ! -s README.md ]; then warn "no SKILL.md / README.md (pre-existing)"; fi
echo "OK: AutoDev validated: llmops metrics spec"
