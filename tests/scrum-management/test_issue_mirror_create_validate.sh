#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/test_helpers.sh"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/done_receipt_helpers.sh"

ROOT="$PHOSPHENE_REPO_ROOT"
CREATE_SCRIPT="$ROOT/.codex/skills/phosphene/amaranth/scrum-management/modulator/scripts/create_issue_mirror.sh"
VALIDATE_SCRIPT="$ROOT/.github/scripts/validate_issue_mirror.sh"
DONE_SCORE_SCRIPT="$ROOT/.github/scripts/scrum-management-domain-done-score.sh"
EMIT_SCRIPT="$ROOT/.codex/skills/phosphene/amaranth/scrum-management/modulator/scripts/scrum-management_emit_done_receipt.sh"

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

out="$("$CREATE_SCRIPT" --title "Test Issue Mirror")"
issue_path="$(printf "%s\n" "$out" | tail -n 1 | sed -E 's/^Created issue mirror: //')"
[[ -f "$issue_path" ]] || phos_fail "issue mirror not created"
cleanup_paths+=("$issue_path")

issue_id="$(grep -E '^ID:[[:space:]]*ISSUE-[0-9]{3}[[:space:]]*$' "$issue_path" | head -n 1 | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"
[[ -n "${issue_id:-}" ]] || phos_fail "missing ISSUE ID"

bash "$VALIDATE_SCRIPT" "$issue_path"
bash "$DONE_SCORE_SCRIPT" --docs-root "$ROOT/phosphene/domains/scrum-management/output" --min-score 0 >/dev/null

bus="$(phos_temp_bus)"
cleanup_paths+=("$bus")
phos_append_prism_branch_invoked "scrum-management" "amaranth" "$issue_id" "170" "$bus"
bash "$EMIT_SCRIPT" --issue-number 170 --work-id "$issue_id" --bus "$bus"
phos_validate_bus "$bus"

echo "OK: scrum-management create/validate/done receipt test passed."
