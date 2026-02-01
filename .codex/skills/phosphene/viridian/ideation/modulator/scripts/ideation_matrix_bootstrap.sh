#!/usr/bin/env bash
set -euo pipefail

# ideation_matrix_bootstrap.sh
# Bootstrap the Creative exploration matrix table for an IDEA artifact, using:
# - the selected axis IDs stored in the issue SPARK header (ExplorationAxisIDs)
# - the canonical axis registry (creative_exploration_axes.tsv)
#
# This rewrites ONLY the "## Creative exploration matrix" section content (table).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/../../../../../../.." && pwd)"

usage() {
  cat <<'EOF'
Usage:
  ./.codex/skills/phosphene/viridian/ideation/modulator/scripts/ideation_matrix_bootstrap.sh \
    --file <path/to/IDEA-####-*.md>

Behavior:
- Reads IssueNumber from IDEA header.
- Resolves SPARK-<IssueNumber>.md under phosphene/signals/sparks/.
- Reads ExplorationAxisIDs (10, ordered) from SPARK header.
- Rewrites the Creative exploration matrix table to contain 30 rows (3 rings x 10 axes).
EOF
}

IDEA_FILE=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --file) IDEA_FILE="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "${IDEA_FILE:-}" ]] || { echo "Error: --file is required" >&2; usage; exit 2; }
[[ -f "$IDEA_FILE" ]] || { echo "Error: file not found: $IDEA_FILE" >&2; exit 1; }

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
axis_ids_raw="$(printf "%s" "${axis_ids_raw:-}" | tr -d '\r' | tr -d '[:space:]')"
[[ -n "${axis_ids_raw:-}" ]] || { echo "Error: missing ExplorationAxisIDs in SPARK header: $spark_path" >&2; exit 1; }

AXIS_IDS=()
while IFS= read -r id; do
  [[ -n "${id:-}" ]] || continue
  AXIS_IDS+=("$id")
done < <(printf "%s" "$axis_ids_raw" | tr ',' '\n' | sed -E 's/^[[:space:]]+|[[:space:]]+$//g' | awk 'NF{print}')

if [[ "${#AXIS_IDS[@]}" -ne 10 ]]; then
  echo "Error: expected 10 ExplorationAxisIDs in SPARK header; found ${#AXIS_IDS[@]}" >&2
  exit 1
fi

AXES_REGISTRY="$ROOT/phosphene/domains/ideation/reference/creative_exploration_axes.tsv"
[[ -f "$AXES_REGISTRY" ]] || { echo "Error: missing axes registry: $AXES_REGISTRY" >&2; exit 1; }

lookup_axis_cell() {
  local axis_id="$1"
  awk -F'\t' -v id="$axis_id" '
    NR==1 { next }
    $1==id {
      axis=$3; poles=$4;
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", axis);
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", poles);
      printf "%s (%s)\n", axis, poles;
      exit 0
    }
    END{ exit 1 }
  ' "$AXES_REGISTRY"
}

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

table_tmp="$tmp_dir/matrix_table.md"
{
  echo "| CandID | Ring | AxisID | Axis | FailureMode | ValueCore | Differentiator | Idea |"
  echo "| --- | --- | --- | --- | --- | --- | --- | --- |"

  axis_index=0
  for axis_id in "${AXIS_IDS[@]}"; do
    axis_index=$((axis_index + 1))
    axis_cell="$(lookup_axis_cell "$axis_id" || true)"
    if [[ -z "${axis_cell:-}" ]]; then
      echo "Error: axis_id not found in registry: $axis_id" >&2
      exit 1
    fi

    for ring in adjacent orthogonal extrapolatory; do
      ring_index=0
      case "$ring" in
        adjacent) ring_index=1 ;;
        orthogonal) ring_index=2 ;;
        extrapolatory) ring_index=3 ;;
        *) echo "Error: unexpected ring: $ring" >&2; exit 2 ;;
      esac
      n=$(( (axis_index - 1) * 3 + ring_index ))
      cand_id="$(printf "CAND-%02d" "$n")"
      echo "| ${cand_id} | ${ring} | ${axis_id} | ${axis_cell} | <FailureMode> | <ValueCore> | <Differentiator> | <3+ sentences: combine SPARK + axis (as context infusion) + ring> |"
    done
  done
} > "$table_tmp"

START_HEADING="## Creative exploration matrix"

out_tmp="$tmp_dir/out.md"
awk -v start="$START_HEADING" -v table_file="$table_tmp" '
  BEGIN{ in_section=0; wrote=0; }
  $0==start {
    print;
    print "";
    while ((getline line < table_file) > 0) print line;
    close(table_file);
    in_section=1;
    wrote=1;
    next
  }
  in_section && $0 ~ /^## / { in_section=0 }
  in_section { next }
  { print }
  END{
    if (wrote==0) {
      print "ERROR: missing required heading: " start > "/dev/stderr";
      exit 3
    }
  }
' "$IDEA_FILE" > "$out_tmp"

mv "$out_tmp" "$IDEA_FILE"
echo "OK: bootstrapped matrix table in: $IDEA_FILE"

