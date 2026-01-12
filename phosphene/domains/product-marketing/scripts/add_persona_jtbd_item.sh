#!/usr/bin/env bash
set -euo pipefail

# add_persona_jtbd_item.sh
# Inserts a new JTBD row into a Persona (PER-*) file under the correct section/table.
#
# JTBD IDs are "long natural keys":
#   JTBD-<TYPE>-####-<PersonaID>
# where <TYPE> is JOB|PAIN|GAIN and <PersonaID> is the persona's ID (e.g., PER-0003).
#
# Usage:
#   ./phosphene/domains/product-marketing/scripts/add_persona_jtbd_item.sh \
#     --persona <path/to/PER-0003.md> \
#     --type JOB|PAIN|GAIN \
#     --text "..." \
#     --importance 1..5

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../phosphene-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/phosphene_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./phosphene/domains/product-marketing/scripts/add_persona_jtbd_item.sh --persona <file> --type JOB|PAIN|GAIN --text "..." --importance 1..5
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }

ROOT="$(phosphene_find_project_root)"

PERSONA=""
TYPE=""
TEXT=""
IMPORTANCE=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --persona) PERSONA="${2:-}"; shift 2 ;;
    --type) TYPE="${2:-}"; shift 2 ;;
    --text) TEXT="${2:-}"; shift 2 ;;
    --importance) IMPORTANCE="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "$PERSONA" ]] || { echo "Error: --persona is required" >&2; usage; exit 2; }
[[ -n "$TYPE" ]] || { echo "Error: --type is required" >&2; usage; exit 2; }
[[ -n "$TEXT" ]] || { echo "Error: --text is required" >&2; usage; exit 2; }
[[ -n "$IMPORTANCE" ]] || { echo "Error: --importance is required" >&2; usage; exit 2; }

case "$TYPE" in
  JOB|PAIN|GAIN) ;;
  *) fail "--type must be JOB|PAIN|GAIN (got: $TYPE)" ;;
esac

if ! [[ "$IMPORTANCE" =~ ^[1-5]$ ]]; then
  fail "--importance must be an integer 1..5 (got: $IMPORTANCE)"
fi

if [[ "$TEXT" == *"|"* ]]; then
  fail "--text must not contain '|' (pipe) characters; markdown tables will break"
fi

if [[ "$PERSONA" != /* ]]; then
  PERSONA="$ROOT/$PERSONA"
fi
[[ -f "$PERSONA" ]] || fail "Not a file: $PERSONA"

PERSONA_PATH="$PERSONA" JTBD_TYPE="$TYPE" JTBD_TEXT="$TEXT" JTBD_IMPORTANCE="$IMPORTANCE" python3 - <<'PY'
import os
import re
import sys
from pathlib import Path

persona_path = Path(os.environ["PERSONA_PATH"])
jtbd_type = os.environ["JTBD_TYPE"]
text = os.environ["JTBD_TEXT"]
importance = os.environ["JTBD_IMPORTANCE"]

content = persona_path.read_text(encoding="utf-8")
lines = content.splitlines(True)  # keep newlines

# Parse persona ID from header
m = re.search(r"^ID:\s*(PER-\d{4})\s*$", content, flags=re.M)
if not m:
  print(f"FAIL: {persona_path.name}: missing/invalid 'ID: PER-####'", file=sys.stderr)
  sys.exit(1)
persona_id = m.group(1)

section_map = {
  "JOB": "## Jobs",
  "PAIN": "## Pains",
  "GAIN": "## Gains",
}
section_header = section_map[jtbd_type]

# Determine next local counter for this TYPE within this persona
pat = re.compile(rf"JTBD-{jtbd_type}-(\d{{4}})-{re.escape(persona_id)}")
nums = [int(mm.group(1)) for mm in pat.finditer(content)]
next_num = (max(nums) + 1) if nums else 1
next_id = f"JTBD-{jtbd_type}-{next_num:04d}-{persona_id}"
row = f"| {next_id} | {text} | {importance} |\n"

# Find section block [start, end)
start = None
for i, ln in enumerate(lines):
  if ln.rstrip("\n") == section_header:
    start = i
    break
if start is None:
  print(f"FAIL: {persona_path.name}: missing section '{section_header}'", file=sys.stderr)
  sys.exit(1)

end = len(lines)
for i in range(start + 1, len(lines)):
  if lines[i].startswith("## "):
    end = i
    break

block = lines[start:end]

# Find insertion point inside the table
insert_at = None

# Prefer after the last JTBD row in the block
row_prefix = f"| JTBD-{jtbd_type}-"
for j in range(len(block) - 1, -1, -1):
  if block[j].lstrip().startswith(row_prefix):
    insert_at = start + j + 1
    break

# Otherwise, insert after the markdown table separator line
if insert_at is None:
  for j, ln in enumerate(block):
    if re.match(r"^\|\s*---", ln):
      insert_at = start + j + 1
      break

if insert_at is None:
  print(f"FAIL: {persona_path.name}: could not find a markdown table to insert into under '{section_header}'", file=sys.stderr)
  sys.exit(1)

lines.insert(insert_at, row)
persona_path.write_text("".join(lines), encoding="utf-8")

print(f"Added: {next_id} -> {persona_path}")
PY

# Re-validate after insertion (best-effort; keep deterministic)
"$ROOT/phosphene/domains/product-marketing/scripts/validate_persona.sh" "$PERSONA" >/dev/null
echo "OK: validated $PERSONA"

