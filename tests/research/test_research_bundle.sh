#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/test_helpers.sh"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/done_receipt_helpers.sh"

ROOT="$PHOSPHENE_REPO_ROOT"
CREATE_SCRIPT="$ROOT/.codex/skills/phosphene/viridian/research/modulator/scripts/create_research_assessment_bundle.sh"
VALIDATE_SCRIPT="$ROOT/.github/scripts/validate_research_assessment_bundle.sh"
DONE_SCORE_SCRIPT="$ROOT/.github/scripts/research-domain-done-score.sh"
EMIT_SCRIPT="$ROOT/.codex/skills/phosphene/viridian/research/modulator/scripts/research_emit_done_receipt.sh"

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

out="$("$CREATE_SCRIPT" --title "Test Research Bundle" --owner "test")"
bundle_path="$(printf "%s\n" "$out" | grep -E '^Created RA bundle:' | tail -n 1 | sed -E 's/^Created RA bundle: //')"
[[ -d "$bundle_path" ]] || phos_fail "RA bundle not created"
cleanup_paths+=("$bundle_path")

ra_id="$(grep -E '^ID:[[:space:]]*RA-[0-9]{3}[[:space:]]*$' "$bundle_path/00-coversheet.md" | head -n 1 | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"
[[ -n "${ra_id:-}" ]] || phos_fail "missing RA ID"

bash "$VALIDATE_SCRIPT" "$bundle_path"
bash "$DONE_SCORE_SCRIPT" --docs-root "$ROOT/phosphene/domains/research/output/research-assessments" --min-score 0 >/dev/null

where_line="$("$ROOT/phosphene/phosphene-core/bin/phosphene" id where "$ra_id" | head -n 1)"
[[ -n "${where_line:-}" ]] || phos_fail "id where failed for $ra_id"

bus="$(phos_temp_bus)"
cleanup_paths+=("$bus")
phos_append_prism_branch_invoked "research" "viridian" "$ra_id" "102" "$bus"
bash "$EMIT_SCRIPT" --issue-number 102 --work-id "$ra_id" --bus "$bus"
phos_validate_bus "$bus"

echo "OK: research bundle test passed."
