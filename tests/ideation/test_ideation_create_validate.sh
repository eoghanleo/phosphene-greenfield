#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/test_helpers.sh"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/done_receipt_helpers.sh"

ROOT="$PHOSPHENE_REPO_ROOT"
IDEA_SCRIPT="$ROOT/.codex/skills/phosphene/viridian/ideation/modulator/scripts/create_idea.sh"
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

bash "$VALIDATE_SCRIPT" "$idea_path"
bash "$DONE_SCORE_SCRIPT" --docs-root "$ROOT/phosphene/domains/ideation/output" --min-score 0 >/dev/null

where_line="$("$ROOT/phosphene/phosphene-core/bin/phosphene" id where "$idea_id" | head -n 1)"
[[ -n "${where_line:-}" ]] || phos_fail "id where failed for $idea_id"

bus="$(phos_temp_bus)"
cleanup_paths+=("$bus")
phos_append_prism_branch_invoked "ideation" "viridian" "$idea_id" "101" "$bus"
bash "$EMIT_SCRIPT" --issue-number 101 --work-id "$idea_id" --bus "$bus"
phos_validate_bus "$bus"

echo "OK: ideation create/validate/done receipt test passed."
