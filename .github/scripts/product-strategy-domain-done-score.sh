#!/usr/bin/env bash
set -euo pipefail

# product-strategy-domain-done-score.sh
# Minimal programmatic scoring for <product-strategy> artifacts.

export LC_ALL=C
export LANG=C
export TZ=UTC

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_FOR_LIB="$(cd "$SCRIPT_DIR/../.." && pwd)"
LIB_DIR="$ROOT_FOR_LIB/phosphene/phosphene-core/lib"
# shellcheck source=/dev/null
source "$LIB_DIR/phosphene_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./.github/scripts/product-strategy-domain-done-score.sh [--docs-root <dir>] [--file <path>] [--min-score <0..100>] [--quiet]
EOF
}

fail() { echo "FAIL: $*" >&2; exit 2; }

ROOT="$(phosphene_find_project_root)"
DOCS_ROOT="$ROOT/phosphene/domains/product-strategy/output"
FILE=""
MIN_SCORE="10"
QUIET=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --docs-root) DOCS_ROOT="${2:-}"; shift 2 ;;
    --file) FILE="${2:-}"; shift 2 ;;
    --min-score) MIN_SCORE="${2:-}"; shift 2 ;;
    --quiet) QUIET=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

if [[ -n "${FILE:-}" ]]; then
  if [[ "$FILE" != /* ]]; then FILE="$ROOT/$FILE"; fi
  [[ -f "$FILE" ]] || fail "Missing file: $FILE"
else
  if [[ "$DOCS_ROOT" != /* ]]; then DOCS_ROOT="$ROOT/$DOCS_ROOT"; fi
  [[ -d "$DOCS_ROOT" ]] || fail "Missing docs root dir: $DOCS_ROOT"
fi

if ! [[ "$MIN_SCORE" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
  fail "--min-score must be numeric (0..100)"
fi

files=()
if [[ -n "${FILE:-}" ]]; then
  files=("$FILE")
else
  while IFS= read -r f; do
    [[ -n "${f:-}" ]] || continue
    files+=("$f")
  done < <(find "$DOCS_ROOT" -type f -name "ROADMAP-*.md" 2>/dev/null | sort)
fi

n_files="${#files[@]}"
if [[ "$n_files" -eq 0 ]]; then
  fail "No ROADMAP artifacts found under: $DOCS_ROOT"
fi

word_count="$(cat "${files[@]}" 2>/dev/null | wc -w | awk '{print $1}')"
score="$(awk -v n="$n_files" -v w="$word_count" 'BEGIN{
  s = (n * 12) + (w / 70);
  if (s > 100) s = 100;
  printf "%.2f\n", s;
}')"

result="$(awk -v s="$score" -v m="$MIN_SCORE" 'BEGIN{ if (s+0 >= m+0) print "PASS"; else print "FAIL" }')"

if [[ "$QUIET" -ne 1 ]]; then
  echo "PHOSPHENE — Done Score  <product-strategy>"
  echo "============================================================"
  echo "Result:    ${result}   Overall: ${score}/100   Threshold: ${MIN_SCORE}"
  echo ""
  echo "Inputs:"
  echo "  - roadmap files: ${n_files}"
  echo "  - total words: ${word_count}"
fi

awk -v s="$score" -v m="$MIN_SCORE" 'BEGIN{ exit (s+0 >= m+0) ? 0 : 1 }'
