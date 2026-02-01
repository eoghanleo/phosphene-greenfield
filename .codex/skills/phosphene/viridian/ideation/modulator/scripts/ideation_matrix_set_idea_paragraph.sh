#!/usr/bin/env bash
set -euo pipefail

# ideation_matrix_set_idea_paragraph.sh
# Set the Idea paragraph cell for a specific (AxisID x Ring) row in the matrix.
#
# CandID is computed deterministically from:
# - ExplorationAxisIDs order in SPARK header
# - ring order: adjacent=1, orthogonal=2, extrapolatory=3
#
# This script updates ONLY the Idea column for the computed CandID row.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/../../../../../../.." && pwd)"

usage() {
  cat <<'EOF'
Usage:
  ./.codex/skills/phosphene/viridian/ideation/modulator/scripts/ideation_matrix_set_idea_paragraph.sh \
    --file <path/to/IDEA-####-*.md> \
    --axis-id AX-### \
    --ring <adjacent|orthogonal|extrapolatory> \
    --paragraph "Three-or-more sentences..."

Notes:
- Newlines in --paragraph are converted to spaces.
- Minimum requirement: >= 3 sentence terminators (., !, ?) in the paragraph.
EOF
}

IDEA_FILE=""
AXIS_ID=""
RING=""
PARAGRAPH=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --file) IDEA_FILE="${2:-}"; shift 2 ;;
    --axis-id) AXIS_ID="${2:-}"; shift 2 ;;
    --ring) RING="${2:-}"; shift 2 ;;
    --paragraph) PARAGRAPH="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "${IDEA_FILE:-}" ]] || { echo "Error: --file is required" >&2; usage; exit 2; }
[[ -f "$IDEA_FILE" ]] || { echo "Error: file not found: $IDEA_FILE" >&2; exit 1; }
[[ "$AXIS_ID" =~ ^AX-[0-9]{3}$ ]] || { echo "Error: --axis-id must look like AX-001" >&2; exit 2; }
[[ -n "${RING:-}" ]] || { echo "Error: --ring is required" >&2; exit 2; }

case "$RING" in
  adjacent|orthogonal|extrapolatory) ;;
  *) echo "Error: --ring must be adjacent|orthogonal|extrapolatory" >&2; exit 2 ;;
esac

if [[ -z "${PARAGRAPH:-}" ]]; then
  echo "Error: --paragraph is required" >&2
  exit 2
fi

normalize_one_line() {
  printf "%s" "$1" | tr '\r\n' '  ' | sed -E 's/[[:space:]]+/ /g; s/^[[:space:]]+//; s/[[:space:]]+$//'
}

PARAGRAPH="$(normalize_one_line "$PARAGRAPH")"
[[ -n "${PARAGRAPH:-}" ]] || { echo "Error: paragraph is empty after normalization" >&2; exit 2; }
if [[ "$PARAGRAPH" == *"|"* ]]; then
  echo "Error: paragraph contains '|' which breaks markdown tables. Remove/replace it." >&2
  exit 2
fi

sent_count="$(printf "%s" "$PARAGRAPH" | awk '
  function sc(s){ c=0; for(i=1;i<=length(s);i++){ ch=substr(s,i,1); if(ch=="."||ch=="!"||ch=="?") c++; } return c; }
  { print sc($0)+0; }
')"
if [[ "${sent_count:-0}" -lt 3 ]]; then
  echo "Error: paragraph must contain >= 3 sentences (found ${sent_count})" >&2
  exit 2
fi

read_header_value() {
  local file="$1"
  local key="$2"
  local line
  while IFS= read -r line; do
    [[ -n "${line:-}" ]] || break
    if [[ "$line" =~ ^${key}: ]]; then
      echo "$line" | sed -E "s/^${key}:[[:space:]]*//"
      return 0
    fi
  done < "$file"
  return 1
}

issue_number="$(read_header_value "$IDEA_FILE" "IssueNumber" || true)"
if ! [[ "${issue_number:-}" =~ ^[0-9]+$ ]]; then
  echo "Error: missing/invalid IssueNumber header in IDEA file (must be numeric)" >&2
  exit 2
fi

spark_id="$(printf "SPARK-%06d" "$issue_number")"
spark_path="$ROOT/phosphene/signals/sparks/${spark_id}.md"
[[ -f "$spark_path" ]] || { echo "Error: missing SPARK for issue ${issue_number}: $spark_path" >&2; exit 1; }

axis_ids_raw="$(read_header_value "$spark_path" "ExplorationAxisIDs" || true)"
axis_ids_raw="$(printf "%s" "${axis_ids_raw:-}" | tr -d '\r')"
[[ -n "${axis_ids_raw:-}" ]] || { echo "Error: missing ExplorationAxisIDs in SPARK header: $spark_path" >&2; exit 1; }

AXIS_IDS=()
while IFS= read -r id; do
  [[ -n "${id:-}" ]] || continue
  AXIS_IDS+=("$id")
done < <(printf "%s" "$axis_ids_raw" | tr ',' '\n' | sed -E 's/^[[:space:]]+|[[:space:]]+$//g' | awk 'NF{print}')

axis_index=0
found=0
for id in "${AXIS_IDS[@]}"; do
  axis_index=$((axis_index + 1))
  if [[ "$id" == "$AXIS_ID" ]]; then
    found=1
    break
  fi
done
if [[ "$found" -ne 1 ]]; then
  echo "Error: axis-id not present in SPARK ExplorationAxisIDs for this run: $AXIS_ID" >&2
  exit 1
fi

ring_index=0
case "$RING" in
  adjacent) ring_index=1 ;;
  orthogonal) ring_index=2 ;;
  extrapolatory) ring_index=3 ;;
esac

n=$(( (axis_index - 1) * 3 + ring_index ))
cand_id="$(printf "CAND-%02d" "$n")"

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

START_HEADING="## Creative exploration matrix"
out_tmp="$tmp_dir/out.md"

awk -v start="$START_HEADING" -v cand="$cand_id" -v axis="$AXIS_ID" -v ring="$RING" -v idea="$PARAGRAPH" '
  function trim(s){ gsub(/^[[:space:]]+|[[:space:]]+$/, "", s); return s; }
  BEGIN{ in_section=0; updated=0; }
  $0==start { in_section=1; print; next }
  in_section && $0 ~ /^## / { in_section=0 }
  in_section && $0 ~ /^\|/ {
    n=split($0, a, /\|/);
    cid=trim(a[2]);
    if (cid==cand) {
      got_ring=trim(a[3]);
      got_axis=trim(a[4]);
      if (got_ring!=ring) { print "ERROR: ring mismatch for " cand " (table=" got_ring ", arg=" ring ")" > "/dev/stderr"; exit 2 }
      if (got_axis!=axis) { print "ERROR: axis mismatch for " cand " (table=" got_axis ", arg=" axis ")" > "/dev/stderr"; exit 2 }
      if (n < 10) { print "ERROR: malformed table row for " cand > "/dev/stderr"; exit 2 }
      a[9] = " " idea " ";
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
echo "OK: updated idea paragraph for ${cand_id} in: $IDEA_FILE"

