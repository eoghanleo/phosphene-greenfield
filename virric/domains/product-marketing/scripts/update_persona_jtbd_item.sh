#!/usr/bin/env bash
set -euo pipefail

# update_persona_jtbd_item.sh
# Updates an existing JTBD row (JOB/PAIN/GAIN) in a Persona (PER-*) file.
#
# Usage:
#   ./virric/domains/product-marketing/scripts/update_persona_jtbd_item.sh --persona <file> --jtbd-id JTBD-PAIN-0001-PER-0003 [--text "..."] [--importance 1..5]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../virric-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/virric_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./virric/domains/product-marketing/scripts/update_persona_jtbd_item.sh --persona <file> --jtbd-id JTBD-<TYPE>-####-PER-#### [--text "..."] [--importance 1..5]
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }

ROOT="$(virric_find_project_root)"

PERSONA=""
JTBD_ID=""
TEXT=""
IMPORTANCE=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --persona) PERSONA="${2:-}"; shift 2 ;;
    --jtbd-id) JTBD_ID="${2:-}"; shift 2 ;;
    --text) TEXT="${2:-}"; shift 2 ;;
    --importance) IMPORTANCE="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "$PERSONA" ]] || { echo "Error: --persona is required" >&2; usage; exit 2; }
[[ -n "$JTBD_ID" ]] || { echo "Error: --jtbd-id is required" >&2; usage; exit 2; }
[[ -n "$TEXT" || -n "$IMPORTANCE" ]] || fail "Provide at least one of --text or --importance"

if [[ "$PERSONA" != /* ]]; then PERSONA="$ROOT/$PERSONA"; fi
[[ -f "$PERSONA" ]] || fail "Not a file: $PERSONA"

if [[ -n "$IMPORTANCE" && ! "$IMPORTANCE" =~ ^[1-5]$ ]]; then
  fail "--importance must be an integer 1..5 (got: $IMPORTANCE)"
fi
if [[ -n "$TEXT" && "$TEXT" == *"|"* ]]; then
  fail "--text must not contain '|' (pipe) characters; markdown tables will break"
fi

PERSONA_PATH="$PERSONA" JTBD_ID="$JTBD_ID" NEW_TEXT="$TEXT" NEW_IMPORTANCE="$IMPORTANCE" python3 - <<'PY'
import os, re, sys
from pathlib import Path

p = Path(os.environ["PERSONA_PATH"])
jtbd_id = os.environ["JTBD_ID"].strip()
new_text = os.environ.get("NEW_TEXT", "")
new_imp = os.environ.get("NEW_IMPORTANCE", "")

content = p.read_text(encoding="utf-8")

pm = re.search(r"^ID:\s*(PER-\d{4})\s*$", content, flags=re.M)
if not pm:
  print(f"FAIL: {p.name}: missing/invalid 'ID: PER-####'", file=sys.stderr)
  sys.exit(1)
persona_id = pm.group(1)

# Ensure suffix matches persona ID
if not jtbd_id.endswith(f"-{persona_id}"):
  print(f"FAIL: {p.name}: jtbd-id suffix must match persona ID ({persona_id}): {jtbd_id}", file=sys.stderr)
  sys.exit(1)

m = re.match(r"^(JTBD-(JOB|PAIN|GAIN)-\d{4})-" + re.escape(persona_id) + r"$", jtbd_id)
if not m:
  print(f"FAIL: invalid jtbd-id format: {jtbd_id}", file=sys.stderr)
  sys.exit(1)

jtbd_type = m.group(2)
section = {"JOB":"## Jobs", "PAIN":"## Pains", "GAIN":"## Gains"}[jtbd_type]

lines = content.splitlines(True)

def find_line_exact(s):
  for i, ln in enumerate(lines):
    if ln.rstrip("\n") == s:
      return i
  return None

start = find_line_exact(section)
if start is None:
  print(f"FAIL: {p.name}: missing section {section}", file=sys.stderr)
  sys.exit(1)

end = len(lines)
for i in range(start + 1, len(lines)):
  if lines[i].startswith("## "):
    end = i
    break

changed = False
for i in range(start, end):
  ln = lines[i]
  # Match a row like: | JTBD-PAIN-0001-PER-0003 | text | 4 |
  if re.match(r"^\|\s*" + re.escape(jtbd_id) + r"\s*\|", ln):
    parts = [p.strip() for p in ln.strip("\n").split("|")]
    # parts: ["", id, text, importance, ""]
    if len(parts) < 5:
      print(f"FAIL: malformed table row: {ln.rstrip()}", file=sys.stderr)
      sys.exit(1)
    if new_text:
      parts[2] = new_text
      changed = True
    if new_imp:
      parts[3] = new_imp
      changed = True
    # Reconstruct with canonical spacing
    lines[i] = f"| {parts[1]} | {parts[2]} | {parts[3]} |\n"
    break
else:
  print(f"FAIL: {p.name}: JTBD row not found: {jtbd_id}", file=sys.stderr)
  sys.exit(1)

if not changed:
  print(f"WARN: no changes applied (empty updates?)", file=sys.stderr)

p.write_text("".join(lines), encoding="utf-8")
print(f"Updated JTBD row: {jtbd_id} -> {p}")
PY

"$ROOT/virric/domains/product-marketing/scripts/validate_persona.sh" "$PERSONA" >/dev/null
echo "OK: validated $PERSONA"

