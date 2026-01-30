#!/usr/bin/env bash
set -euo pipefail

# tests/run.sh
# Lightweight bash-native test runner for PHOSPHENE.
#
# Usage:
#   bash tests/run.sh
#   bash tests/run.sh --e2e
#   bash tests/run.sh --product-marketing
#   bash tests/run.sh --product-management
#   bash tests/run.sh --product-vision
#   bash tests/run.sh --product-strategy
#   bash tests/run.sh --product-architecture
#   bash tests/run.sh --product-evaluation
#   bash tests/run.sh --feature-management
#   bash tests/run.sh --test-management
#   bash tests/run.sh --scrum-management
#   bash tests/run.sh --coverage
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
  bash tests/run.sh [--all|--e2e|--ideation|--research|--product-vision|--product-strategy|--product-architecture|--product-evaluation|--feature-management|--test-management|--scrum-management|--product-marketing|--product-management] [--coverage]
EOF
}

MODE="all"
ENABLE_COVERAGE=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    --all) MODE="all"; shift ;;
    --e2e) MODE="e2e"; shift ;;
    --ideation) MODE="ideation"; shift ;;
    --research) MODE="research"; shift ;;
    --product-vision) MODE="product-vision"; shift ;;
    --product-strategy) MODE="product-strategy"; shift ;;
    --product-architecture) MODE="product-architecture"; shift ;;
    --product-evaluation) MODE="product-evaluation"; shift ;;
    --feature-management) MODE="feature-management"; shift ;;
    --test-management) MODE="test-management"; shift ;;
    --scrum-management) MODE="scrum-management"; shift ;;
    --product-marketing) MODE="product-marketing"; shift ;;
    --product-management) MODE="product-management"; shift ;;
    --coverage) ENABLE_COVERAGE=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

if [[ "$ENABLE_COVERAGE" -eq 1 ]]; then
  COV_ROOT="$SCRIPT_DIR/.coverage"
  COV_RAW="$COV_ROOT/raw"
  rm -rf "$COV_ROOT" 2>/dev/null || true
  mkdir -p "$COV_RAW"

  export PHOS_COVERAGE_ENABLED=1
  export PHOS_COVERAGE_DIR="$COV_RAW"
  export PHOS_COVERAGE_OUT="$COV_ROOT"

  # Ensure children shells pick up the DEBUG trap.
  export BASH_ENV="$SCRIPT_DIR/lib/coverage_env.sh"

  # Ensure subprocesses can resolve repo-relative paths for filtering + reporting.
  export PHOSPHENE_REPO_ROOT
fi

roots=()
case "$MODE" in
  all)
    roots+=(
      "$SCRIPT_DIR/e2e"
      "$SCRIPT_DIR/ideation"
      "$SCRIPT_DIR/research"
      "$SCRIPT_DIR/product-vision"
      "$SCRIPT_DIR/product-strategy"
      "$SCRIPT_DIR/product-architecture"
      "$SCRIPT_DIR/product-evaluation"
      "$SCRIPT_DIR/feature-management"
      "$SCRIPT_DIR/test-management"
      "$SCRIPT_DIR/scrum-management"
      "$SCRIPT_DIR/product-marketing"
      "$SCRIPT_DIR/product-management"
    )
    ;;
  e2e)
    roots+=("$SCRIPT_DIR/e2e")
    ;;
  ideation)
    roots+=("$SCRIPT_DIR/ideation")
    ;;
  research)
    roots+=("$SCRIPT_DIR/research")
    ;;
  product-vision)
    roots+=("$SCRIPT_DIR/product-vision")
    ;;
  product-strategy)
    roots+=("$SCRIPT_DIR/product-strategy")
    ;;
  product-architecture)
    roots+=("$SCRIPT_DIR/product-architecture")
    ;;
  product-evaluation)
    roots+=("$SCRIPT_DIR/product-evaluation")
    ;;
  feature-management)
    roots+=("$SCRIPT_DIR/feature-management")
    ;;
  test-management)
    roots+=("$SCRIPT_DIR/test-management")
    ;;
  scrum-management)
    roots+=("$SCRIPT_DIR/scrum-management")
    ;;
  product-marketing)
    roots+=("$SCRIPT_DIR/product-marketing")
    ;;
  product-management)
    roots+=("$SCRIPT_DIR/product-management")
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

if [[ "$ENABLE_COVERAGE" -eq 1 ]]; then
  echo ""
  echo "=== COVERAGE ==="
  bash "$SCRIPT_DIR/lib/coverage_report.sh"
fi

echo ""
echo "OK: all tests passed."

