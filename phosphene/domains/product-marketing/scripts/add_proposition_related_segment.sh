#!/usr/bin/env bash
set -euo pipefail

# add_proposition_related_segment.sh
# Adds a SEG-#### entry under "## Related Segment(s)" in a proposition.
#
# Usage:
#   ./phosphene/domains/product-marketing/scripts/add_proposition_related_segment.sh --proposition <file> --segment SEG-0001

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../phosphene-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/phosphene_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./phosphene/domains/product-marketing/scripts/add_proposition_related_segment.sh --proposition <file> --segment SEG-0001
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }

ROOT="$(phosphene_find_project_root)"

PROP=""
SEG=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --proposition) PROP="${2:-}"; shift 2 ;;
    --segment) SEG="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "$PROP" ]] || { echo "Error: --proposition is required" >&2; usage; exit 2; }
[[ -n "$SEG" ]] || { echo "Error: --segment is required" >&2; usage; exit 2; }
[[ "$SEG" =~ ^SEG-[0-9]{4}$ ]] || fail "--segment must look like SEG-0001"

if [[ "$PROP" != /* ]]; then PROP="$ROOT/$PROP"; fi
[[ -f "$PROP" ]] || fail "Not a file: $PROP"

PROP_PATH="$PROP" ITEM="$SEG" HEADING="## Related Segment(s)" python3 - <<'PY'
import os, re, sys
from pathlib import Path

p = Path(os.environ["PROP_PATH"])
item = os.environ["ITEM"].strip()
heading = os.environ["HEADING"]

txt = p.read_text(encoding="utf-8")
lines = txt.splitlines(True)

def find_line_exact(s):
  for i, ln in enumerate(lines):
    if ln.rstrip("\n") == s:
      return i
  return None

start = find_line_exact(heading)
if start is None:
  print(f"FAIL: {p.name}: missing '{heading}'", file=sys.stderr)
  sys.exit(1)

end = len(lines)
for i in range(start + 1, len(lines)):
  if lines[i].startswith("## "):
    end = i
    break

block = lines[start:end]

items = []
for ln in block:
  m = re.match(r"^\-\s+(SEG-\d{4})\s*$", ln.rstrip("\n"))
  if m:
    items.append(m.group(1))

items = [x for x in items if x != "<...>"]
items.append(item)
items = sorted(set(items))

new_block = []
for ln in block:
  if re.match(r"^\-\s+SEG-\d{4}\s*$", ln.rstrip("\n")):
    continue
  new_block.append(ln)

insert_at = len(new_block)
for i, ln in enumerate(new_block):
  if ln.strip() == "```":
    insert_at = i + 1
  if i > 0 and new_block[i-1].strip() == "```" and ln.strip() == "":
    insert_at = i + 1

while insert_at < len(new_block) and new_block[insert_at].strip() == "":
  insert_at += 1

bullet_lines = [f"- {x}\n" for x in items] + ["\n"]
new_block[insert_at:insert_at] = bullet_lines

lines[start:end] = new_block
p.write_text("".join(lines), encoding="utf-8")
print(f"Added related segment {item} -> {p}")
PY

"$ROOT/phosphene/domains/product-marketing/scripts/validate_proposition.sh" "$PROP" >/dev/null
echo "OK: validated $PROP"

