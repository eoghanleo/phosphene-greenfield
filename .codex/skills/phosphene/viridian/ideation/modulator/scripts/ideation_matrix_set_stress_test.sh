#!/usr/bin/env bash
set -euo pipefail

# ideation_matrix_set_stress_test.sh
# Set FailureMode / ValueCore / Differentiator columns for a CandID row in the matrix.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/../../../../../../.." && pwd)"

usage() {
  cat <<'EOF'
Usage:
  ./.codex/skills/phosphene/viridian/ideation/modulator/scripts/ideation_matrix_set_stress_test.sh \
    --file <path/to/IDEA-####-*.md> \
    --cand-id CAND-XX \
    --failure-mode "..." \
    --value-core "..." \
    --differentiator "..."

Notes:
- Values are normalized to a single line (newlines -> spaces).
EOF
}

IDEA_FILE=""
CAND_ID=""
FAILURE_MODE=""
VALUE_CORE=""
DIFFERENTIATOR=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --file) IDEA_FILE="${2:-}"; shift 2 ;;
    --cand-id) CAND_ID="${2:-}"; shift 2 ;;
    --failure-mode) FAILURE_MODE="${2:-}"; shift 2 ;;
    --value-core) VALUE_CORE="${2:-}"; shift 2 ;;
    --differentiator) DIFFERENTIATOR="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "${IDEA_FILE:-}" ]] || { echo "Error: --file is required" >&2; usage; exit 2; }
[[ -f "$IDEA_FILE" ]] || { echo "Error: file not found: $IDEA_FILE" >&2; exit 1; }
[[ "$CAND_ID" =~ ^CAND-[0-9]{2}$ ]] || { echo "Error: --cand-id must look like CAND-01" >&2; exit 2; }
[[ -n "${FAILURE_MODE:-}" ]] || { echo "Error: --failure-mode is required" >&2; exit 2; }
[[ -n "${VALUE_CORE:-}" ]] || { echo "Error: --value-core is required" >&2; exit 2; }
[[ -n "${DIFFERENTIATOR:-}" ]] || { echo "Error: --differentiator is required" >&2; exit 2; }

normalize_one_line() {
  printf "%s" "$1" | tr '\r\n' '  ' | sed -E 's/[[:space:]]+/ /g; s/^[[:space:]]+//; s/[[:space:]]+$//'
}

FAILURE_MODE="$(normalize_one_line "$FAILURE_MODE")"
VALUE_CORE="$(normalize_one_line "$VALUE_CORE")"
DIFFERENTIATOR="$(normalize_one_line "$DIFFERENTIATOR")"
if [[ "$FAILURE_MODE" == *"|"* || "$VALUE_CORE" == *"|"* || "$DIFFERENTIATOR" == *"|"* ]]; then
  echo "Error: stress-test fields contain '|' which breaks markdown tables. Remove/replace it." >&2
  exit 2
fi

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

START_HEADING="## Creative exploration matrix"
out_tmp="$tmp_dir/out.md"

awk -v start="$START_HEADING" -v cand="$CAND_ID" -v fm="$FAILURE_MODE" -v vc="$VALUE_CORE" -v df="$DIFFERENTIATOR" '
  function trim(s){ gsub(/^[[:space:]]+|[[:space:]]+$/, "", s); return s; }
  BEGIN{ in_section=0; updated=0; }
  $0==start { in_section=1; print; next }
  in_section && $0 ~ /^## / { in_section=0 }
  in_section && $0 ~ /^\|/ {
    n=split($0, a, /\|/);
    cid=trim(a[2]);
    if (cid==cand) {
      if (n < 10) { print "ERROR: malformed table row for " cand > "/dev/stderr"; exit 2 }
      a[6] = " " fm " ";
      a[7] = " " vc " ";
      a[8] = " " df " ";
      line="|";
      for (i=2;i<=9;i++){ line=line a[i] "|"; }
      print line;
      updated=1;
      next
    }
  }
  { print }
  END{ if (updated==0) { print "ERROR: did not find CandID row to update: " cand > "/dev/stderr"; exit 3 } }
' "$IDEA_FILE" > "$out_tmp"

mv "$out_tmp" "$IDEA_FILE"
echo "OK: updated stress-test columns for ${CAND_ID} in: $IDEA_FILE"

