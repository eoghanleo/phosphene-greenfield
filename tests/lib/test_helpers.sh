#!/usr/bin/env bash

# tests/lib/test_helpers.sh
# Shared helpers for bash-native PHOSPHENE test scripts.
#
# Note: This file is intended to be *sourced* by test scripts.

phos_fail() { echo "FAIL: $*" >&2; exit 1; }

phos_find_repo_root() {
  # Walk upward from a starting directory until we find the PHOSPHENE repo root.
  local start="${1:-}"
  local d
  [[ -n "${start:-}" ]] || return 1

  d="$start"
  while true; do
    if [[ -f "$d/phosphene/phosphene-core/lib/phosphene_env.sh" ]]; then
      echo "$d"
      return 0
    fi
    [[ "$d" == "/" ]] && return 1
    d="$(cd "$d/.." && pwd)"
  done
}

TEST_HELPERS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PHOSPHENE_REPO_ROOT="$(phos_find_repo_root "$TEST_HELPERS_DIR")" || phos_fail "could not locate repo root from: $TEST_HELPERS_DIR"

phos_id_validate_quiet() {
  # Rebuild the global ID index from the current working tree state.
  "$PHOSPHENE_REPO_ROOT/phosphene/phosphene-core/bin/phosphene" id validate >/dev/null 2>&1
}

