#!/usr/bin/env bash
set -euo pipefail

# tests/e2e/test_prism_posture_config.sh
# Validate prism posture config wiring (branch creation flag).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/test_helpers.sh"

CONFIG="$PHOSPHENE_REPO_ROOT/phosphene/config/global.yml"
[[ -f "$CONFIG" ]] || phos_fail "missing global config: $CONFIG"

CONFIG_HELPER="$PHOSPHENE_REPO_ROOT/phosphene/phosphene-core/bin/phosphene_config.sh"
[[ -f "$CONFIG_HELPER" ]] || phos_fail "missing config helper: $CONFIG_HELPER"

value="$(bash "$CONFIG_HELPER" get --color global --key prism.create_branch --default false)"
if [[ "$value" != "false" ]]; then
  phos_fail "expected prism.create_branch=false (got: $value)"
fi

grep -q "PHOSPHENE_PRISM_CREATE_BRANCH" "$PHOSPHENE_REPO_ROOT/.github/workflows/gantry.prism.product-marketing.yml" \
  || phos_fail "product-marketing prism missing posture env"
grep -q "PHOSPHENE_PRISM_CREATE_BRANCH" "$PHOSPHENE_REPO_ROOT/.github/workflows/gantry.prism.product-management.yml" \
  || phos_fail "product-management prism missing posture env"

echo "OK: prism posture config wired."

