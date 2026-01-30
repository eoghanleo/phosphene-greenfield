#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/test_helpers.sh"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/done_receipt_helpers.sh"

ROOT="$PHOSPHENE_REPO_ROOT"
CREATE_SCRIPT="$ROOT/.codex/skills/phosphene/cadmium/product-evaluation/modulator/scripts/create_product_evaluation.sh"
VALIDATE_SCRIPT="$ROOT/.github/scripts/validate_product_evaluation.sh"
DONE_SCORE_SCRIPT="$ROOT/.github/scripts/product-evaluation-domain-done-score.sh"
EMIT_SCRIPT="$ROOT/.codex/skills/phosphene/cadmium/product-evaluation/modulator/scripts/product-evaluation_emit_done_receipt.sh"

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

out="$("$CREATE_SCRIPT" --title "Test Product Evaluation")"
eval_path="$(printf "%s\n" "$out" | tail -n 1 | sed -E 's/^Created product evaluation: //')"
[[ -f "$eval_path" ]] || phos_fail "evaluation not created"
cleanup_paths+=("$eval_path")

eval_id="$(grep -E '^ID:[[:space:]]*EVAL-[0-9]{3}[[:space:]]*$' "$eval_path" | head -n 1 | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"
[[ -n "${eval_id:-}" ]] || phos_fail "missing EVAL ID"

bash "$VALIDATE_SCRIPT" "$eval_path"
bash "$DONE_SCORE_SCRIPT" --docs-root "$ROOT/phosphene/domains/product-evaluation/output" --min-score 0 >/dev/null

where_line="$("$ROOT/phosphene/phosphene-core/bin/phosphene" id where "$eval_id" | head -n 1)"
[[ -n "${where_line:-}" ]] || phos_fail "id where failed for $eval_id"

bus="$(phos_temp_bus)"
cleanup_paths+=("$bus")
phos_append_prism_branch_invoked "product-evaluation" "cadmium" "$eval_id" "140" "$bus"
bash "$EMIT_SCRIPT" --issue-number 140 --work-id "$eval_id" --bus "$bus"
phos_validate_bus "$bus"

echo "OK: product-evaluation create/validate/done receipt test passed."
