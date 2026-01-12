#!/usr/bin/env bash
set -euo pipefail

# update_proposition_capability.sh
# Updates an existing Capability row in the "## Capabilities" table.
#
# Usage:
#   ./phosphene/domains/product-marketing/scripts/update_proposition_capability.sh --proposition <file> --capability-id CAP-0001-PROP-0001 [--type feature|function|standard|experience] [--capability "..."]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../phosphene-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/phosphene_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./phosphene/domains/product-marketing/scripts/update_proposition_capability.sh --proposition <file> --capability-id CAP-0001-PROP-0001 [--type feature|function|standard|experience] [--capability "..."]
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }

ROOT="$(phosphene_find_project_root)"

PROP=""
CID=""
CTYPE=""
CAP=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --proposition) PROP="${2:-}"; shift 2 ;;
    --capability-id) CID="${2:-}"; shift 2 ;;
    --type) CTYPE="${2:-}"; shift 2 ;;
    --capability) CAP="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "$PROP" ]] || { echo "Error: --proposition is required" >&2; usage; exit 2; }
[[ -n "$CID" ]] || { echo "Error: --capability-id is required" >&2; usage; exit 2; }
[[ -n "$CTYPE" || -n "$CAP" ]] || fail "Provide at least one of --type or --capability"

if [[ -n "$CTYPE" ]]; then
  case "$CTYPE" in
    feature|function|standard|experience) ;;
    *) fail "--type must be one of feature|function|standard|experience" ;;
  esac
fi
if [[ -n "$CAP" && "$CAP" == *"|"* ]]; then fail "--capability must not contain '|'"; fi

if [[ "$PROP" != /* ]]; then PROP="$ROOT/$PROP"; fi
[[ -f "$PROP" ]] || fail "Not a file: $PROP"

PROP_PATH="$PROP" CAPABILITY_ID="$CID" NEW_TYPE="$CTYPE" NEW_CAP="$CAP" python3 - <<'PY'
import os, re, sys
from pathlib import Path

p = Path(os.environ["PROP_PATH"])
cid = os.environ["CAPABILITY_ID"].strip()
new_type = os.environ.get("NEW_TYPE", "").strip()
new_cap = os.environ.get("NEW_CAP", "").strip()

content = p.read_text(encoding="utf-8")
m = re.search(r"^ID:\s*(PROP-\d{4})\s*$", content, flags=re.M)
if not m:
  print(f"FAIL: {p.name}: missing/invalid 'ID: PROP-####'", file=sys.stderr)
  sys.exit(1)
prop_id = m.group(1)

if not re.fullmatch(rf"CAP-\d{{4}}-{re.escape(prop_id)}", cid):
  print(f"FAIL: capability-id must match proposition ID suffix ({prop_id}): {cid}", file=sys.stderr)
  sys.exit(1)

lines = content.splitlines(True)

def bounds(h):
  s = None
  for i, ln in enumerate(lines):
    if ln.rstrip("\n") == h:
      s = i
      break
  if s is None:
    return None, None
  e = len(lines)
  for i in range(s + 1, len(lines)):
    if lines[i].startswith("## "):
      e = i
      break
  return s, e

start, end = bounds("## Capabilities")
if start is None:
  print(f"FAIL: {p.name}: missing '## Capabilities'", file=sys.stderr)
  sys.exit(1)

row_re = re.compile(r"^\|\s*" + re.escape(cid) + r"\s*\|")
for i in range(start, end):
  ln = lines[i]
  if row_re.match(ln):
    parts = [x.strip() for x in ln.strip("\n").split("|")]
    if len(parts) < 5:
      print(f"FAIL: malformed table row: {ln.rstrip()}", file=sys.stderr)
      sys.exit(1)
    if new_type:
      parts[2] = new_type
    if new_cap:
      parts[3] = new_cap
    lines[i] = f"| {parts[1]} | {parts[2]} | {parts[3]} |\n"
    break
else:
  print(f"FAIL: {p.name}: CapabilityID row not found: {cid}", file=sys.stderr)
  sys.exit(1)

p.write_text("".join(lines), encoding="utf-8")
print(f"Updated capability {cid} -> {p}")
PY

"$ROOT/phosphene/domains/product-marketing/scripts/validate_proposition.sh" "$PROP" >/dev/null
echo "OK: validated $PROP"

