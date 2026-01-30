#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/test_helpers.sh"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/done_receipt_helpers.sh"

ROOT="$PHOSPHENE_REPO_ROOT"
CREATE_SCRIPT="$ROOT/.codex/skills/phosphene/beryl/product-vision/modulator/scripts/create_product_vision.sh"
VALIDATE_SCRIPT="$ROOT/.github/scripts/validate_product_vision.sh"
DONE_SCORE_SCRIPT="$ROOT/.github/scripts/product-vision-domain-done-score.sh"
EMIT_SCRIPT="$ROOT/.codex/skills/phosphene/beryl/product-vision/modulator/scripts/product-vision_emit_done_receipt.sh"

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

out="$("$CREATE_SCRIPT" --title "Test Product Vision")"
vision_path="$(printf "%s\n" "$out" | tail -n 1 | sed -E 's/^Created product vision: //')"
[[ -f "$vision_path" ]] || phos_fail "vision not created"
cleanup_paths+=("$vision_path")

vision_id="$(grep -E '^ID:[[:space:]]*VISION-[0-9]{3}[[:space:]]*$' "$vision_path" | head -n 1 | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"
[[ -n "${vision_id:-}" ]] || phos_fail "missing VISION ID"

bash "$VALIDATE_SCRIPT" "$vision_path"
bash "$DONE_SCORE_SCRIPT" --docs-root "$ROOT/phosphene/domains/product-vision/output" --min-score 0 >/dev/null

where_line="$("$ROOT/phosphene/phosphene-core/bin/phosphene" id where "$vision_id" | head -n 1)"
[[ -n "${where_line:-}" ]] || phos_fail "id where failed for $vision_id"

bus="$(phos_temp_bus)"
cleanup_paths+=("$bus")
phos_append_prism_branch_invoked "product-vision" "beryl" "$vision_id" "110" "$bus"
bash "$EMIT_SCRIPT" --issue-number 110 --work-id "$vision_id" --bus "$bus"
phos_validate_bus "$bus"

echo "OK: product-vision create/validate/done receipt test passed."
