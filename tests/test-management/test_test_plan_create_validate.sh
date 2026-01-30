#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/test_helpers.sh"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/done_receipt_helpers.sh"

ROOT="$PHOSPHENE_REPO_ROOT"
CREATE_SCRIPT="$ROOT/.codex/skills/phosphene/cadmium/test-management/modulator/scripts/create_test_plan.sh"
VALIDATE_SCRIPT="$ROOT/.github/scripts/validate_test_plan.sh"
DONE_SCORE_SCRIPT="$ROOT/.github/scripts/test-management-domain-done-score.sh"
EMIT_SCRIPT="$ROOT/.codex/skills/phosphene/cadmium/test-management/modulator/scripts/test-management_emit_done_receipt.sh"

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

out="$("$CREATE_SCRIPT" --title "Test Plan")"
tp_path="$(printf "%s\n" "$out" | tail -n 1 | sed -E 's/^Created test plan: //')"
[[ -f "$tp_path" ]] || phos_fail "test plan not created"
cleanup_paths+=("$tp_path")

tp_id="$(grep -E '^ID:[[:space:]]*TP-[0-9]{3}[[:space:]]*$' "$tp_path" | head -n 1 | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"
[[ -n "${tp_id:-}" ]] || phos_fail "missing TP ID"

bash "$VALIDATE_SCRIPT" "$tp_path"
bash "$DONE_SCORE_SCRIPT" --docs-root "$ROOT/phosphene/domains/test-management/output" --min-score 0 >/dev/null

where_line="$("$ROOT/phosphene/phosphene-core/bin/phosphene" id where "$tp_id" | head -n 1)"
[[ -n "${where_line:-}" ]] || phos_fail "id where failed for $tp_id"

bus="$(phos_temp_bus)"
cleanup_paths+=("$bus")
phos_append_prism_branch_invoked "test-management" "cadmium" "$tp_id" "160" "$bus"
bash "$EMIT_SCRIPT" --issue-number 160 --work-id "$tp_id" --bus "$bus"
phos_validate_bus "$bus"

echo "OK: test-management create/validate/done receipt test passed."
