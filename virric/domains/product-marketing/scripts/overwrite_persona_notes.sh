#!/usr/bin/env bash
set -euo pipefail

# overwrite_persona_notes.sh
# Replaces the entire "## Notes" section content in a Persona (PER-*) file.
#
# Usage:
#   ./virric/domains/product-marketing/scripts/overwrite_persona_notes.sh --persona <file> --notes-file <md_file>

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../virric-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/virric_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./virric/domains/product-marketing/scripts/overwrite_persona_notes.sh --persona <file> --notes-file <md_file>
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }

ROOT="$(virric_find_project_root)"

PERSONA=""
NOTES_FILE=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --persona) PERSONA="${2:-}"; shift 2 ;;
    --notes-file) NOTES_FILE="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "$PERSONA" ]] || { echo "Error: --persona is required" >&2; usage; exit 2; }
[[ -n "$NOTES_FILE" ]] || { echo "Error: --notes-file is required" >&2; usage; exit 2; }

if [[ "$PERSONA" != /* ]]; then PERSONA="$ROOT/$PERSONA"; fi
if [[ "$NOTES_FILE" != /* ]]; then NOTES_FILE="$ROOT/$NOTES_FILE"; fi
[[ -f "$PERSONA" ]] || fail "Not a file: $PERSONA"
[[ -f "$NOTES_FILE" ]] || fail "Not a file: $NOTES_FILE"

CONTENT="$(cat "$NOTES_FILE")"

PERSONA_PATH="$PERSONA" NEW_NOTES="$CONTENT" python3 - <<'PY'
import os, sys
from pathlib import Path

p = Path(os.environ["PERSONA_PATH"])
new_notes = os.environ["NEW_NOTES"].rstrip("\n") + "\n"

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

out = []
out.extend(lines[: start + 1])
out.append("\n")
out.append(new_notes if new_notes.strip() else "\n")
out.append("\n")
out.extend(lines[end:])

p.write_text("".join(out), encoding="utf-8")
print(f"Overwrote notes -> {p}")
PY

"$ROOT/virric/domains/product-marketing/scripts/validate_persona.sh" "$PERSONA" >/dev/null
echo "OK: validated $PERSONA"

