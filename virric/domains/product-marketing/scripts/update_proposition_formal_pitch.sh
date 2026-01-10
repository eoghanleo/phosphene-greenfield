#!/usr/bin/env bash
set -euo pipefail

# update_proposition_formal_pitch.sh
# Replaces the "## Formal Pitch" section content in a Proposition (PROP-*) file.
#
# Usage:
#   ./virric/domains/product-marketing/scripts/update_proposition_formal_pitch.sh --proposition <file> --pitch-file <md_file>
#   ./virric/domains/product-marketing/scripts/update_proposition_formal_pitch.sh --proposition <file> --pitch "<single line>"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../virric-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/virric_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./virric/domains/product-marketing/scripts/update_proposition_formal_pitch.sh --proposition <file> --pitch-file <md_file>
  ./virric/domains/product-marketing/scripts/update_proposition_formal_pitch.sh --proposition <file> --pitch "<single line>"
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }

ROOT="$(virric_find_project_root)"

PROP=""
PITCH_FILE=""
PITCH=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --proposition) PROP="${2:-}"; shift 2 ;;
    --pitch-file) PITCH_FILE="${2:-}"; shift 2 ;;
    --pitch) PITCH="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "$PROP" ]] || { echo "Error: --proposition is required" >&2; usage; exit 2; }
if [[ "$PROP" != /* ]]; then PROP="$ROOT/$PROP"; fi
[[ -f "$PROP" ]] || fail "Not a file: $PROP"

CONTENT=""
if [[ -n "$PITCH_FILE" ]]; then
  if [[ "$PITCH_FILE" != /* ]]; then PITCH_FILE="$ROOT/$PITCH_FILE"; fi
  [[ -f "$PITCH_FILE" ]] || fail "Not a file: $PITCH_FILE"
  CONTENT="$(cat "$PITCH_FILE")"
else
  [[ -n "$PITCH" ]] || fail "Provide --pitch-file or --pitch"
  CONTENT="$PITCH"
fi

PROP_PATH="$PROP" NEW_BLOCK="$CONTENT" python3 - <<'PY'
import os, sys
from pathlib import Path

p = Path(os.environ["PROP_PATH"])
new_block = os.environ["NEW_BLOCK"].rstrip("\n") + "\n"

text = p.read_text(encoding="utf-8")
lines = text.splitlines(True)

def find_line_exact(s):
  for i, ln in enumerate(lines):
    if ln.rstrip("\n") == s:
      return i
  return None

start = find_line_exact("## Formal Pitch")
if start is None:
  print(f"FAIL: {p.name}: missing '## Formal Pitch'", file=sys.stderr)
  sys.exit(1)

end = len(lines)
for i in range(start + 1, len(lines)):
  if lines[i].startswith("## "):
    end = i
    break

# Keep any [V-SCRIPT] fenced block at the top of the section, then replace the rest.
out = []
out.extend(lines[: start + 1])
out.append("\n")

i = start + 1
while i < end and lines[i].strip() == "":
  i += 1

if i < end and lines[i].startswith("```"):
  # copy fenced block verbatim
  while i < end:
    out.append(lines[i])
    if lines[i].startswith("```") and i != start + 1:
      # end fence
      i += 1
      break
    i += 1
  out.append("\n")

out.append(new_block if new_block.strip() else "\n")
out.append("\n")
out.extend(lines[end:])

p.write_text("".join(out), encoding="utf-8")
print(f"Updated formal pitch: {p}")
PY

"$ROOT/virric/domains/product-marketing/scripts/validate_proposition.sh" "$PROP" >/dev/null
echo "OK: validated $PROP"

