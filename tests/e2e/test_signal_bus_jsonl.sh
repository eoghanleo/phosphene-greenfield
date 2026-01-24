#!/usr/bin/env bash
set -euo pipefail

# E2E TEST
# Verifies PHOSPHENE JSONL signal bus append/validate behavior (per-line tamper hashes).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/test_helpers.sh"

ROOT="$PHOSPHENE_REPO_ROOT"

fail() { echo "FAIL: $*" >&2; exit 1; }

tmp="$(mktemp -d)"
cleanup() { rm -rf "$tmp" 2>/dev/null || true; }
trap cleanup EXIT

bus_tool="$ROOT/phosphene/phosphene-core/bin/signal_bus.sh"
[[ -x "$bus_tool" ]] || fail "missing bus tool (not executable): $bus_tool"

bus="$tmp/bus.jsonl"
: > "$bus"

echo "--- append first line (auto tamper_hash insert) ---"
line1='{"signal_version":1,"signal_id":"sha256:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","signal_type":"phosphene.test.bus.v1","run_marker":"TEST-000","output_key":"test:bus:1","created_utc":"1970-01-01T00:00:00Z"}'
bash "$bus_tool" append --bus "$bus" --line "$line1"

echo "--- validate bus (should pass) ---"
bash "$bus_tool" validate --bus "$bus"

echo "--- append second line ---"
line2='{"signal_version":1,"signal_id":"sha256:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","signal_type":"phosphene.test.bus.v1","run_marker":"TEST-000","output_key":"test:bus:2","created_utc":"1970-01-01T00:00:00Z"}'
bash "$bus_tool" append --bus "$bus" --line "$line2"
bash "$bus_tool" validate --bus "$bus"

echo "--- tamper existing line (should fail) ---"
sed -E 's/"output_key":"test:bus:1"/"output_key":"tampered"/' "$bus" > "$bus.tmp"
mv "$bus.tmp" "$bus"

if bash "$bus_tool" validate --bus "$bus" >/dev/null 2>&1; then
  fail "expected bus validate to fail after tamper edit"
fi

echo "OK: signal bus JSONL test passed."

