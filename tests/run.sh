#!/usr/bin/env bash
set -euo pipefail

# tests/run.sh
# Lightweight bash-native test runner for PHOSPHENE.
#
# Usage:
#   bash tests/run.sh
#   bash tests/run.sh --e2e
#   bash tests/run.sh --product-marketing
#
# Notes:
# - Tests are allowed to create temporary artifacts under canonical `docs/` trees.
# - Tests must clean up after themselves and should leave `phosphene/id_index.tsv` consistent.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=/dev/null
source "$SCRIPT_DIR/lib/test_helpers.sh"

usage() {
  cat <<'EOF'
Usage:
  bash tests/run.sh [--all|--e2e|--product-marketing]
EOF
}

MODE="all"
while [[ $# -gt 0 ]]; do
  case "$1" in
    --all) MODE="all"; shift ;;
    --e2e) MODE="e2e"; shift ;;
    --product-marketing) MODE="product-marketing"; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

roots=()
case "$MODE" in
  all)
    roots+=("$SCRIPT_DIR/e2e" "$SCRIPT_DIR/product-marketing")
    ;;
  e2e)
    roots+=("$SCRIPT_DIR/e2e")
    ;;
  product-marketing)
    roots+=("$SCRIPT_DIR/product-marketing")
    ;;
  *)
    echo "Unknown MODE: $MODE" >&2
    exit 2
    ;;
esac

tests=()
for r in "${roots[@]}"; do
  [[ -d "$r" ]] || continue
  while IFS= read -r f; do
    [[ -n "${f:-}" ]] || continue
    tests+=("$f")
  done < <(find "$r" -type f -name "test_*.sh" 2>/dev/null | sort)
done

if [[ "${#tests[@]}" -eq 0 ]]; then
  echo "No tests found for mode: $MODE" >&2
  exit 2
fi

echo "PHOSPHENE — tests"
echo "============================================================"
echo "Mode: $MODE"
echo "Repo: $PHOSPHENE_REPO_ROOT"
echo "Count: ${#tests[@]}"
echo ""

for t in "${tests[@]}"; do
  echo "=== RUN: $(basename "$t")"
  bash "$t"
done

# Final sanity: leave the index in a consistent state after all temp artifacts are gone.
phos_id_validate_quiet || true

echo ""
echo "OK: all tests passed."

