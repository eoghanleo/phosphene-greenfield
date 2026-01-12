#!/usr/bin/env bash
set -euo pipefail

# update_proposition_formal_pitch.sh
# Replaces the "## Formal Pitch" section content in a Proposition (PROP-*) file.
#
# Usage:
#   ./phosphene/domains/product-marketing/scripts/update_proposition_formal_pitch.sh --proposition <file> --pitch-file <md_file>
#   ./phosphene/domains/product-marketing/scripts/update_proposition_formal_pitch.sh --proposition <file> --pitch "<single line>"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../phosphene-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/phosphene_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./phosphene/domains/product-marketing/scripts/update_proposition_formal_pitch.sh --proposition <file> --pitch-file <md_file>
  ./phosphene/domains/product-marketing/scripts/update_proposition_formal_pitch.sh --proposition <file> --pitch "<single line>"
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }

ROOT="$(phosphene_find_project_root)"

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

TMP_OUT="$(mktemp)"
set +e
PROP_PATH="$PROP" OUT_PATH="$TMP_OUT" NEW_BLOCK="$CONTENT" python3 - <<'PY'
import os, sys
from pathlib import Path

p = Path(os.environ["PROP_PATH"])
out_path = Path(os.environ["OUT_PATH"])
new_block = os.environ["NEW_BLOCK"].rstrip("\n") + "\n"

text = p.read_text(encoding="utf-8")
lines = text.splitlines(True)

def find_line_exact(s):
  for i, ln in enumerate(lines):
    if ln.rstrip("\n") == s:
      return i
  return None

def assert_balanced_fences(s: str, label: str):
  n = sum(1 for ln in s.splitlines() if ln.startswith("```"))
  if n % 2 != 0:
    print(f"FAIL: {p.name}: {label} contains an unbalanced ``` fence count", file=sys.stderr)
    sys.exit(1)

def extract_vscript_block(start: int, end: int):
  i = start + 1
  while i < end and lines[i].strip() == "":
    i += 1
  if i < end and lines[i].startswith("```"):
    j = i
    block = [lines[j]]
    j += 1
    while j < end:
      block.append(lines[j])
      if lines[j].startswith("```"):
        j += 1
        break
      j += 1
    if any("[V-SCRIPT]:" in ln for ln in block):
      return block
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

vscript = extract_vscript_block(start, end)
if vscript is None:
  vscript = [
    "```text\n",
    "[V-SCRIPT]:\n",
    "update_proposition_formal_pitch.sh\n",
    "```\n",
  ]

assert_balanced_fences(new_block, "formal pitch content")

# Keep (or reinsert) the [V-SCRIPT] block at the top of the section, then replace the rest.
out = []
out.extend(lines[: start + 1])
out.append("\n")
out.extend(vscript)
out.append("\n")
out.append(new_block if new_block.strip() else "\n")
out.append("\n")
out.extend(lines[end:])

out_path.write_text("".join(out), encoding="utf-8")
print(f"Updated formal pitch -> {out_path}")
PY

py_rc=$?
if [[ $py_rc -ne 0 ]]; then
  rm -f "$TMP_OUT"
  exit $py_rc
fi

"$ROOT/phosphene/domains/product-marketing/scripts/validate_proposition.sh" --strict "$TMP_OUT" >/dev/null
val_rc=$?
if [[ $val_rc -ne 0 ]]; then
  rm -f "$TMP_OUT"
  exit $val_rc
fi

mv "$TMP_OUT" "$PROP"
set -e

echo "OK: strict-validated $PROP"

