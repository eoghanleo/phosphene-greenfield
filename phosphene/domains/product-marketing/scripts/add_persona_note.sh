#!/usr/bin/env bash
set -euo pipefail

# add_persona_note.sh
# Appends a note entry under "## Notes" in a Persona (PER-*) file.
#
# Usage:
#   ./phosphene/domains/product-marketing/scripts/add_persona_note.sh --persona <file> --note "..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../phosphene-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/phosphene_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./phosphene/domains/product-marketing/scripts/add_persona_note.sh --persona <file> --note "..."
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }

ROOT="$(phosphene_find_project_root)"

PERSONA=""
NOTE=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --persona) PERSONA="${2:-}"; shift 2 ;;
    --note) NOTE="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "$PERSONA" ]] || { echo "Error: --persona is required" >&2; usage; exit 2; }
[[ -n "$NOTE" ]] || { echo "Error: --note is required" >&2; usage; exit 2; }

if [[ "$PERSONA" != /* ]]; then PERSONA="$ROOT/$PERSONA"; fi
[[ -f "$PERSONA" ]] || fail "Not a file: $PERSONA"

PERSONA_PATH="$PERSONA" NOTE_VALUE="$NOTE" python3 - <<'PY'
import os, sys
from datetime import datetime, timezone
from pathlib import Path

p = Path(os.environ["PERSONA_PATH"])
note = os.environ["NOTE_VALUE"].rstrip()
if not note:
  print("FAIL: empty note", file=sys.stderr)
  sys.exit(1)

ts = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
entry = f"- {ts}: {note}\n"

text = p.read_text(encoding="utf-8")
lines = text.splitlines(True)

def find_line_exact(s):
  for i, ln in enumerate(lines):
    if ln.rstrip("\n") == s:
      return i
  return None

start = find_line_exact("## Notes")
if start is None:
  print(f"FAIL: {p.name}: missing '## Notes'", file=sys.stderr)
  sys.exit(1)

end = len(lines)
for i in range(start + 1, len(lines)):
  if lines[i].startswith("## "):
    end = i
    break

# Append at the end of Notes block (ensure it ends with a newline)
if end > 0 and lines[end-1] != "\n":
  lines.insert(end, "\n")
  end += 1

lines.insert(end, entry)
p.write_text("".join(lines), encoding="utf-8")
print(f"Added note -> {p}")
PY

"$ROOT/phosphene/domains/product-marketing/scripts/validate_persona.sh" "$PERSONA" >/dev/null
echo "OK: validated $PERSONA"

