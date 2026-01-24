#!/usr/bin/env bash
set -euo pipefail

# E2E TEST
# Verifies PHOSPHENE signal tamper-hash update/validate behavior.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/test_helpers.sh"

ROOT="$PHOSPHENE_REPO_ROOT"

fail() { echo "FAIL: $*" >&2; exit 1; }

tmp="$(mktemp -d)"
cleanup() { rm -rf "$tmp" 2>/dev/null || true; }
trap cleanup EXIT

tool="$ROOT/phosphene/phosphene-core/bin/signal_tamper_hash.sh"
[[ -x "$tool" ]] || fail "missing tamper tool (not executable): $tool"

sig="$tmp/signal.json"
cat > "$sig" <<'EOF'
{
  "signal_version": 1,
  "signal_id": "sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
  "signal_type": "phosphene.test.signal.v1",
  "from_domain": "test",
  "to_domain": "test",
  "work_id": "TEST-000",
  "parents": [],
  "run_marker": "TEST-000",
  "output_key": "test:tamper-hash",
  "created_utc": "1970-01-01T00:00:00Z"
}
EOF

echo "--- update (inserts + computes) ---"
bash "$tool" update "$sig" >/dev/null

echo "--- validate (should pass) ---"
bash "$tool" validate "$sig"

echo "--- compute matches file value ---"
expected="$(bash "$tool" compute "$sig")"
found="$(grep -oE '"tamper_hash"[[:space:]]*:[[:space:]]*"sha256:[0-9a-f]{64}"' "$sig" | head -n 1 | sed -E 's/^"tamper_hash"[[:space:]]*:[[:space:]]*"//; s/"$//')"
[[ "$found" == "$expected" ]] || fail "tamper_hash mismatch after update (found=$found expected=$expected)"

echo "--- tamper (edit without update) ---"
sed -E 's/"work_id":[[:space:]]*"TEST-000"/"work_id": "TEST-001"/' "$sig" > "$sig.tmp"
mv "$sig.tmp" "$sig"

if bash "$tool" validate "$sig" >/dev/null 2>&1; then
  fail "expected validate to fail after tamper edit"
fi

echo "--- repair (update again) ---"
bash "$tool" update "$sig" >/dev/null
bash "$tool" validate "$sig"

echo "OK: signal tamper-hash test passed."

