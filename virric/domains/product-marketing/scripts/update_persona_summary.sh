#!/usr/bin/env bash
set -euo pipefail

# update_persona_summary.sh
# Replaces the "## Snapshot summary" section content in a Persona (PER-*) file.
#
# Usage:
#   ./virric/domains/product-marketing/scripts/update_persona_summary.sh --persona <file> --summary-file <md_file>
#   ./virric/domains/product-marketing/scripts/update_persona_summary.sh --persona <file> --summary "<single line>"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../virric-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/virric_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./virric/domains/product-marketing/scripts/update_persona_summary.sh --persona <file> --summary-file <md_file>
  ./virric/domains/product-marketing/scripts/update_persona_summary.sh --persona <file> --summary "<single line>"
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }

ROOT="$(virric_find_project_root)"

PERSONA=""
SUMMARY_FILE=""
SUMMARY=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --persona) PERSONA="${2:-}"; shift 2 ;;
    --summary-file) SUMMARY_FILE="${2:-}"; shift 2 ;;
    --summary) SUMMARY="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "$PERSONA" ]] || { echo "Error: --persona is required" >&2; usage; exit 2; }
if [[ "$PERSONA" != /* ]]; then PERSONA="$ROOT/$PERSONA"; fi
[[ -f "$PERSONA" ]] || fail "Not a file: $PERSONA"

CONTENT=""
if [[ -n "$SUMMARY_FILE" ]]; then
  if [[ "$SUMMARY_FILE" != /* ]]; then SUMMARY_FILE="$ROOT/$SUMMARY_FILE"; fi
  [[ -f "$SUMMARY_FILE" ]] || fail "Not a file: $SUMMARY_FILE"
  CONTENT="$(cat "$SUMMARY_FILE")"
else
  [[ -n "$SUMMARY" ]] || fail "Provide --summary-file or --summary"
  CONTENT="$SUMMARY"
fi

PERSONA_PATH="$PERSONA" NEW_BLOCK="$CONTENT" python3 - <<'PY'
import os, sys
from pathlib import Path

p = Path(os.environ["PERSONA_PATH"])
new_block = os.environ["NEW_BLOCK"].rstrip("\n") + "\n"

text = p.read_text(encoding="utf-8")
lines = text.splitlines(True)

def find_line_exact(s):
  for i, ln in enumerate(lines):
    if ln.rstrip("\n") == s:
      return i
  return None

start = find_line_exact("## Snapshot summary")
if start is None:
  print(f"FAIL: {p.name}: missing '## Snapshot summary'", file=sys.stderr)
  sys.exit(1)

end = len(lines)
for i in range(start + 1, len(lines)):
  if lines[i].startswith("## "):
    end = i
    break

# Replace content after heading with a blank line + new block + blank line, preserving next sections.
out = []
out.extend(lines[: start + 1])
out.append("\n")
out.append(new_block if new_block.strip() else "\n")
out.append("\n")
out.extend(lines[end:])

p.write_text("".join(out), encoding="utf-8")
print(f"Updated snapshot summary: {p}")
PY

"$ROOT/virric/domains/product-marketing/scripts/validate_persona.sh" "$PERSONA" >/dev/null
echo "OK: validated $PERSONA"

