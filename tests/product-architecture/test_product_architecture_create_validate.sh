#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/test_helpers.sh"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/done_receipt_helpers.sh"

ROOT="$PHOSPHENE_REPO_ROOT"
CREATE_SCRIPT="$ROOT/.codex/skills/phosphene/cerulean/product-architecture/modulator/scripts/create_product_architecture.sh"
VALIDATE_SCRIPT="$ROOT/.github/scripts/validate_product_architecture.sh"
DONE_SCORE_SCRIPT="$ROOT/.github/scripts/product-architecture-domain-done-score.sh"
EMIT_SCRIPT="$ROOT/.codex/skills/phosphene/cerulean/product-architecture/modulator/scripts/product-architecture_emit_done_receipt.sh"

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

out="$("$CREATE_SCRIPT" --title "Test Product Architecture")"
arch_path="$(printf "%s\n" "$out" | tail -n 1 | sed -E 's/^Created product architecture: //')"
[[ -f "$arch_path" ]] || phos_fail "architecture not created"
cleanup_paths+=("$arch_path")

arch_id="$(grep -E '^ID:[[:space:]]*ARCH-[0-9]{3}[[:space:]]*$' "$arch_path" | head -n 1 | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"
[[ -n "${arch_id:-}" ]] || phos_fail "missing ARCH ID"

bash "$VALIDATE_SCRIPT" "$arch_path"
bash "$DONE_SCORE_SCRIPT" --docs-root "$ROOT/phosphene/domains/product-architecture/output" --min-score 0 >/dev/null

where_line="$("$ROOT/phosphene/phosphene-core/bin/phosphene" id where "$arch_id" | head -n 1)"
[[ -n "${where_line:-}" ]] || phos_fail "id where failed for $arch_id"

bus="$(phos_temp_bus)"
cleanup_paths+=("$bus")
phos_append_prism_branch_invoked "product-architecture" "cerulean" "$arch_id" "130" "$bus"
bash "$EMIT_SCRIPT" --issue-number 130 --work-id "$arch_id" --bus "$bus"
phos_validate_bus "$bus"

echo "OK: product-architecture create/validate/done receipt test passed."
