#!/usr/bin/env bash
set -euo pipefail

# add_proposition_capability.sh
# Adds a Capability row to the "## Capabilities" table.
#
# Usage:
#   ./phosphene/domains/product-marketing/scripts/add_proposition_capability.sh --proposition <file> --type feature|function|standard|experience --capability "..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../phosphene-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/phosphene_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./phosphene/domains/product-marketing/scripts/add_proposition_capability.sh --proposition <file> --type feature|function|standard|experience --capability "..."
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }

ROOT="$(phosphene_find_project_root)"

PROP=""
CTYPE=""
CAP=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --proposition) PROP="${2:-}"; shift 2 ;;
    --type) CTYPE="${2:-}"; shift 2 ;;
    --capability) CAP="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "$PROP" ]] || { echo "Error: --proposition is required" >&2; usage; exit 2; }
[[ -n "$CTYPE" ]] || { echo "Error: --type is required" >&2; usage; exit 2; }
[[ -n "$CAP" ]] || { echo "Error: --capability is required" >&2; usage; exit 2; }

case "$CTYPE" in
  feature|function|standard|experience) ;;
  *) fail "--type must be one of feature|function|standard|experience" ;;
esac
if [[ "$CAP" == *"|"* ]]; then fail "--capability must not contain '|'"; fi

if [[ "$PROP" != /* ]]; then PROP="$ROOT/$PROP"; fi
[[ -f "$PROP" ]] || fail "Not a file: $PROP"

PROP_PATH="$PROP" CAP_TEXT="$CAP" CAP_TYPE="$CTYPE" python3 - <<'PY'
import os, re, sys
from pathlib import Path

p = Path(os.environ["PROP_PATH"])
cap = os.environ["CAP_TEXT"].strip()
ctype = os.environ["CAP_TYPE"].strip()

content = p.read_text(encoding="utf-8")
m = re.search(r"^ID:\s*(PROP-\d{4})\s*$", content, flags=re.M)
if not m:
  print(f"FAIL: {p.name}: missing/invalid 'ID: PROP-####'", file=sys.stderr)
  sys.exit(1)
prop_id = m.group(1)

nums = [int(mm.group(1)) for mm in re.finditer(rf"CAP-(\d{{4}})-{re.escape(prop_id)}", content)]
next_num = (max(nums) + 1) if nums else 1
cid = f"CAP-{next_num:04d}-{prop_id}"

lines = content.splitlines(True)

def find_line_exact(s):
  for i, ln in enumerate(lines):
    if ln.rstrip("\n") == s:
      return i
  return None

start = find_line_exact("## Capabilities")
if start is None:
  print(f"FAIL: {p.name}: missing '## Capabilities'", file=sys.stderr)
  sys.exit(1)
end = len(lines)
for i in range(start + 1, len(lines)):
  if lines[i].startswith("## "):
    end = i
    break

insert_at = None
for i in range(end - 1, start, -1):
  if re.match(r"^\|\s*CAP-\d{4}-PROP-\d{4}\s*\|", lines[i]):
    insert_at = i + 1
    break
if insert_at is None:
  for i in range(start, end):
    if re.match(r"^\|\s*---", lines[i]):
      insert_at = i + 1
      break
if insert_at is None:
  print(f"FAIL: {p.name}: could not find capabilities table to insert into", file=sys.stderr)
  sys.exit(1)

row = f"| {cid} | {ctype} | {cap} |\n"
lines.insert(insert_at, row)
p.write_text("".join(lines), encoding="utf-8")
print(f"Added capability {cid} -> {p}")
PY

"$ROOT/phosphene/domains/product-marketing/scripts/validate_proposition.sh" "$PROP" >/dev/null
echo "OK: validated $PROP"

