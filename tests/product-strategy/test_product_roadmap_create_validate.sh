#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/test_helpers.sh"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/done_receipt_helpers.sh"

ROOT="$PHOSPHENE_REPO_ROOT"
CREATE_SCRIPT="$ROOT/.codex/skills/phosphene/beryl/product-strategy/modulator/scripts/create_product_roadmap.sh"
VALIDATE_SCRIPT="$ROOT/.github/scripts/validate_product_roadmap.sh"
DONE_SCORE_SCRIPT="$ROOT/.github/scripts/product-strategy-domain-done-score.sh"
EMIT_SCRIPT="$ROOT/.codex/skills/phosphene/beryl/product-strategy/modulator/scripts/product-strategy_emit_done_receipt.sh"

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

out="$("$CREATE_SCRIPT" --title "Test Product Roadmap")"
roadmap_path="$(printf "%s\n" "$out" | tail -n 1 | sed -E 's/^Created product roadmap: //')"
[[ -f "$roadmap_path" ]] || phos_fail "roadmap not created"
cleanup_paths+=("$roadmap_path")

roadmap_id="$(grep -E '^ID:[[:space:]]*ROADMAP-[0-9]{3}[[:space:]]*$' "$roadmap_path" | head -n 1 | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"
[[ -n "${roadmap_id:-}" ]] || phos_fail "missing ROADMAP ID"

bash "$VALIDATE_SCRIPT" "$roadmap_path"
bash "$DONE_SCORE_SCRIPT" --docs-root "$ROOT/phosphene/domains/product-strategy/output" --min-score 0 >/dev/null

where_line="$("$ROOT/phosphene/phosphene-core/bin/phosphene" id where "$roadmap_id" | head -n 1)"
[[ -n "${where_line:-}" ]] || phos_fail "id where failed for $roadmap_id"

bus="$(phos_temp_bus)"
cleanup_paths+=("$bus")
phos_append_prism_branch_invoked "product-strategy" "beryl" "$roadmap_id" "120" "$bus"
bash "$EMIT_SCRIPT" --issue-number 120 --work-id "$roadmap_id" --bus "$bus"
phos_validate_bus "$bus"

echo "OK: product-strategy create/validate/done receipt test passed."
