#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/test_helpers.sh"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/done_receipt_helpers.sh"

ROOT="$PHOSPHENE_REPO_ROOT"
CREATE_SCRIPT="$ROOT/.codex/skills/phosphene/cerulean/feature-management/modulator/scripts/create_feature_request.sh"
VALIDATE_SCRIPT="$ROOT/.github/scripts/validate_feature_request.sh"
DONE_SCORE_SCRIPT="$ROOT/.github/scripts/feature-management-domain-done-score.sh"
EMIT_SCRIPT="$ROOT/.codex/skills/phosphene/cerulean/feature-management/modulator/scripts/feature-management_emit_done_receipt.sh"

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

out="$("$CREATE_SCRIPT" --title "Test Feature Request" --description "Test FR description")"
clean_out="$(printf "%s\n" "$out" | sed -E 's/\x1b\[[0-9;]*m//g')"
fr_path="$(printf "%s\n" "$clean_out" | grep -E 'Location: ' | tail -n 1 | sed -E 's/.*Location: //')"
[[ -f "$fr_path" ]] || phos_fail "feature request not created"
cleanup_paths+=("$fr_path")

backlog_root="$(cd "$(dirname "$fr_path")/.." && pwd)"
backlog_tree="$backlog_root/backlog_tree.md"
cleanup_paths+=("$backlog_tree")

fr_id="$(grep -E '^ID:[[:space:]]*FR-[0-9]{3}[[:space:]]*$' "$fr_path" | head -n 1 | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"
[[ -n "${fr_id:-}" ]] || phos_fail "missing FR ID"

bash "$VALIDATE_SCRIPT" --strict "$fr_path"
bash "$DONE_SCORE_SCRIPT" --docs-root "$ROOT/phosphene/domains/feature-management/output" --min-score 0 >/dev/null

where_line="$("$ROOT/phosphene/phosphene-core/bin/phosphene" id where "$fr_id" | head -n 1)"
[[ -n "${where_line:-}" ]] || phos_fail "id where failed for $fr_id"

bus="$(phos_temp_bus)"
cleanup_paths+=("$bus")
phos_append_prism_branch_invoked "feature-management" "cerulean" "$fr_id" "150" "$bus"
bash "$EMIT_SCRIPT" --issue-number 150 --work-id "$fr_id" --bus "$bus"
phos_validate_bus "$bus"

echo "OK: feature-management create/validate/done receipt test passed."
