#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/helpers.sh"

run_test "product-marketing-domain-done-score"
run_test "product-marketing-domain-done-score-deterministic"
