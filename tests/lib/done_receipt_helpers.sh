#!/usr/bin/env bash
set -euo pipefail

# tests/lib/done_receipt_helpers.sh
# Helpers for DONE receipt emitter tests.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/test_helpers.sh"

BUS_TOOL="$PHOSPHENE_REPO_ROOT/phosphene/phosphene-core/bin/signal_bus.sh"
HASH_TOOL="$PHOSPHENE_REPO_ROOT/phosphene/phosphene-core/bin/signal_hash.sh"

phos_temp_bus() {
  local bus
  bus="$(mktemp)"
  : > "$bus"
  echo "$bus"
}

phos_append_prism_branch_invoked() {
  local domain="$1"
  local lane="$2"
  local work_id="$3"
  local issue_number="$4"
  local bus="$5"

  [[ -n "${domain:-}" ]] || return 1
  [[ -n "${lane:-}" ]] || return 1
  [[ -n "${work_id:-}" ]] || return 1
  [[ -n "${issue_number:-}" ]] || return 1
  [[ -n "${bus:-}" ]] || return 1

  local phos_id="PHOS-TEST"
  local output_key="prism:branch-invoked:${domain}:issue:${issue_number}:phos:${phos_id}"
  local signal_id
  signal_id="$(
    bash "$HASH_TOOL" signal-id \
      --run-marker "$work_id" \
      --output-key "$output_key"
  )"

  local created_utc
  created_utc="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
  local line
  line="{\"signal_version\":1,\"signal_id\":\"${signal_id}\",\"signal_type\":\"phosphene.prism.${domain}.branch_invoked.v1\",\"work_id\":\"${work_id}\",\"domain\":\"${domain}\",\"issue_number\":${issue_number},\"lane\":\"${lane}\",\"intent\":\"test\",\"phos_id\":\"${phos_id}\",\"parents\":[],\"run_marker\":\"${work_id}\",\"output_key\":\"${output_key}\",\"created_utc\":\"${created_utc}\"}"

  bash "$BUS_TOOL" append --bus "$bus" --line "$line"
}

phos_validate_bus() {
  local bus="$1"
  bash "$BUS_TOOL" validate --bus "$bus"
}
