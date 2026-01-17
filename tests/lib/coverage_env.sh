#!/usr/bin/env bash

# tests/lib/coverage_env.sh
# Coverage hook for bash scripts (line-hit) using DEBUG trap.
#
# This file is intended to be sourced via BASH_ENV by `tests/run.sh --coverage`.
# No external tooling is required beyond bash + standard unix utilities.

# Only activate when explicitly enabled by the runner.
[[ "${PHOS_COVERAGE_ENABLED:-0}" == "1" ]] || return 0

# Required:
# - PHOSPHENE_REPO_ROOT: absolute repo root
# - PHOS_COVERAGE_DIR: directory to write per-process raw hit logs
if [[ -z "${PHOSPHENE_REPO_ROOT:-}" || -z "${PHOS_COVERAGE_DIR:-}" ]]; then
  return 0
fi

# Ensure output directory exists (best effort).
mkdir -p "$PHOS_COVERAGE_DIR" 2>/dev/null || true

# One file per process to avoid concurrent write interleaving.
PHOS_COVERAGE_RAW_FILE="${PHOS_COVERAGE_DIR}/hits.$$.$RANDOM.tsv"

__phos_cov_should_track_file() {
  local src="${1:-}"
  [[ -n "$src" ]] || return 1

  # Only count files under the repo root.
  case "$src" in
    "$PHOSPHENE_REPO_ROOT"/*) ;;
    *) return 1 ;;
  esac

  # Exclude test harness + coverage plumbing itself (we want coverage for product code).
  case "$src" in
    "$PHOSPHENE_REPO_ROOT/tests/"*) return 1 ;;
    "$PHOSPHENE_REPO_ROOT/.git/"*) return 1 ;;
  esac

  return 0
}

__phos_cov_log_hit() {
  # DEBUG trap: runs *before* each simple command.
  #
  # For the executing command, bash exposes a call stack. In practice:
  # - BASH_SOURCE[0] is this function (when we call it)
  # - BASH_SOURCE[1] is the file where the command is about to execute
  # - BASH_LINENO[0] is the line number in BASH_SOURCE[1]

  local src line

  src="${BASH_SOURCE[1]:-}"
  line="${BASH_LINENO[0]:-}"

  # Fallbacks (should rarely be needed).
  [[ -n "${src:-}" ]] || src="${BASH_SOURCE[0]:-}"
  [[ -n "${line:-}" ]] || line="${LINENO:-}"

  __phos_cov_should_track_file "$src" || return 0
  case "${line:-}" in
    (""|*[!0-9]*) return 0 ;;
  esac

  # Append "file<TAB>line". Dedupe happens in the report step.
  printf "%s\t%s\n" "$src" "$line" >>"$PHOS_COVERAGE_RAW_FILE" 2>/dev/null || true
}

trap '__phos_cov_log_hit' DEBUG

