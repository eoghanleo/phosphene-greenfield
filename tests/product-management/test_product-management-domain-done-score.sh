#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/helpers.sh"

run_test "product_management_done_score_with_vpd_input"
run_test "product_management_done_score_deterministic"

