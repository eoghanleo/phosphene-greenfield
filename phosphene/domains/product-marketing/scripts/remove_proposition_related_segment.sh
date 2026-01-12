#!/usr/bin/env bash
set -euo pipefail

# remove_proposition_related_segment.sh
# Removes a SEG-#### entry from "## Related Segment(s)" in a proposition.
#
# Usage:
#   ./phosphene/domains/product-marketing/scripts/remove_proposition_related_segment.sh --proposition <file> --segment SEG-0001

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../phosphene-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/phosphene_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./phosphene/domains/product-marketing/scripts/remove_proposition_related_segment.sh --proposition <file> --segment SEG-0001
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
import os, re
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
end = len(lines)
for i in range(start + 1, len(lines)):
  if lines[i].startswith("## "):
    end = i
    break

block = lines[start:end]
new_block = []
removed = 0
for ln in block:
  if re.match(r"^\-\s+" + re.escape(item) + r"\s*$", ln.rstrip("\n")):
    removed += 1
    continue
  new_block.append(ln)

lines[start:end] = new_block
p.write_text("".join(lines), encoding="utf-8")
print(f"Removed related segment {item} ({removed} occurrence(s)) -> {p}")
PY

"$ROOT/phosphene/domains/product-marketing/scripts/validate_proposition.sh" "$PROP" >/dev/null
echo "OK: validated $PROP"

