#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/test_helpers.sh"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/done_receipt_helpers.sh"

ROOT="$PHOSPHENE_REPO_ROOT"
IDEA_SCRIPT="$ROOT/.codex/skills/phosphene/viridian/ideation/modulator/scripts/create_idea.sh"
BOOTSTRAP_SCRIPT="$ROOT/.codex/skills/phosphene/viridian/ideation/modulator/scripts/ideation_matrix_bootstrap.sh"
SET_IDEA_SCRIPT="$ROOT/.codex/skills/phosphene/viridian/ideation/modulator/scripts/ideation_matrix_set_idea_paragraph.sh"
SET_STRESS_SCRIPT="$ROOT/.codex/skills/phosphene/viridian/ideation/modulator/scripts/ideation_matrix_set_stress_test.sh"
VALIDATE_SCRIPT="$ROOT/.github/scripts/validate_idea.sh"
DONE_SCORE_SCRIPT="$ROOT/.github/scripts/ideation-domain-done-score.sh"
EMIT_SCRIPT="$ROOT/.codex/skills/phosphene/viridian/ideation/modulator/scripts/ideation_emit_done_receipt.sh"

cleanup_paths=()
cleanup() {
  for p in "${cleanup_paths[@]:-}"; do
    [[ -n "${p:-}" ]] || continue
    [[ -e "$p" ]] || continue
    rm -rf "$p" || true
  done
  phos_id_validate_quiet || true
}
trap cleanup EXIT

out="$("$IDEA_SCRIPT" --title "Test Idea")"
idea_path="$(printf "%s\n" "$out" | tail -n 1 | sed -E 's/^Created idea: //')"
[[ -f "$idea_path" ]] || phos_fail "idea not created"
cleanup_paths+=("$idea_path")

idea_id="$(grep -E '^ID:[[:space:]]*IDEA-[0-9]{4}[[:space:]]*$' "$idea_path" | head -n 1 | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"
[[ -n "${idea_id:-}" ]] || phos_fail "missing IDEA ID"

issue_number="101"

tmp="$(mktemp)"
awk -v n="$issue_number" '
  BEGIN{ updated=0; }
  /^IssueNumber:/ { print "IssueNumber: " n; updated=1; next }
  { print }
  END{ if (updated==0) exit 1 }
' "$idea_path" > "$tmp"
mv "$tmp" "$idea_path"

spark_dir="$ROOT/phosphene/signals/sparks"
mkdir -p "$spark_dir"
spark_id="$(printf "SPARK-%06d" "$issue_number")"
spark_path="$spark_dir/${spark_id}.md"
cat > "$spark_path" <<EOF
ID: ${spark_id}
IssueNumber: ${issue_number}
WorkID: ${idea_id}
Lane: viridian
UpstreamSignalID:
InputWorkIDs:
ExplorationAxisIDs: AX-001,AX-002,AX-003,AX-004,AX-005,AX-006,AX-007,AX-008,AX-009,AX-010
CreatedUTC: 2026-02-01T00:00:00Z

## Issue snapshot

Test ideation input snapshot.
EOF
cleanup_paths+=("$spark_path")

bash "$BOOTSTRAP_SCRIPT" --file "$idea_path" >/dev/null

axis_ids=(AX-001 AX-002 AX-003 AX-004 AX-005 AX-006 AX-007 AX-008 AX-009 AX-010)
for axis_id in "${axis_ids[@]}"; do
  for ring in adjacent orthogonal extrapolatory; do
    para="First sentence: explore via ${ring} dynamics. Second sentence: infuse the ${axis_id} axis as a context stance. Third sentence: anchor tightly to the SPARK prompt and constraints."
    bash "$SET_IDEA_SCRIPT" --file "$idea_path" --axis-id "$axis_id" --ring "$ring" --paragraph "$para" >/dev/null
  done
done

for n in $(seq -w 1 30); do
  cand="CAND-${n}"
  bash "$SET_STRESS_SCRIPT" --file "$idea_path" --cand-id "$cand" \
    --failure-mode "Failure mode for ${cand} under constraints." \
    --value-core "Value core for ${cand} if everything else fails." \
    --differentiator "Differentiator for ${cand} compared to baseline." >/dev/null
done

bash "$VALIDATE_SCRIPT" "$idea_path"
done_out=""
if ! done_out="$(bash "$DONE_SCORE_SCRIPT" --file "$idea_path" --min-score 0 2>&1)"; then
  echo "$done_out"
  exit 1
fi

where_line="$("$ROOT/phosphene/phosphene-core/bin/phosphene" id where "$idea_id" | head -n 1)"
[[ -n "${where_line:-}" ]] || phos_fail "id where failed for $idea_id"

bus="$(phos_temp_bus)"
cleanup_paths+=("$bus")
phos_append_prism_branch_invoked "ideation" "viridian" "$idea_id" "101" "$bus"
bash "$EMIT_SCRIPT" --issue-number 101 --work-id "$idea_id" --bus "$bus"
phos_validate_bus "$bus"

echo "OK: ideation create/validate/done receipt test passed."
