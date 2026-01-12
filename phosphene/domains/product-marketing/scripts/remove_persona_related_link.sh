#!/usr/bin/env bash
set -euo pipefail

# remove_persona_related_link.sh
# Removes a link under "## Evidence and links" → "### Links".
#
# Usage:
#   ./phosphene/domains/product-marketing/scripts/remove_persona_related_link.sh --persona <file> --link "<url-or-path>"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../phosphene-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/phosphene_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./phosphene/domains/product-marketing/scripts/remove_persona_related_link.sh --persona <file> --link "<url-or-path>"
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }

ROOT="$(phosphene_find_project_root)"

PERSONA=""
LINK=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --persona) PERSONA="${2:-}"; shift 2 ;;
    --link) LINK="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "$PERSONA" ]] || { echo "Error: --persona is required" >&2; usage; exit 2; }
[[ -n "$LINK" ]] || { echo "Error: --link is required" >&2; usage; exit 2; }

if [[ "$PERSONA" != /* ]]; then PERSONA="$ROOT/$PERSONA"; fi
[[ -f "$PERSONA" ]] || fail "Not a file: $PERSONA"

PERSONA_PATH="$PERSONA" LINK_VALUE="$LINK" python3 - <<'PY'
import os, re, sys
from pathlib import Path

p = Path(os.environ["PERSONA_PATH"])
link = os.environ["LINK_VALUE"].strip()

text = p.read_text(encoding="utf-8")
lines = text.splitlines(True)

def find_line_exact(s):
  for i, ln in enumerate(lines):
    if ln.rstrip("\n") == s:
      return i
  return None

evidence_start = find_line_exact("## Evidence and links")
if evidence_start is None:
  print(f"FAIL: {p.name}: missing '## Evidence and links'", file=sys.stderr)
  sys.exit(1)

evidence_end = len(lines)
for i in range(evidence_start + 1, len(lines)):
  if lines[i].startswith("## "):
    evidence_end = i
    break

block = lines[evidence_start:evidence_end]

removed = 0
for i, ln in enumerate(block):
  if re.match(r"^\-\s+" + re.escape(link) + r"\s*$", ln.rstrip("\n")):
    block[i] = ""
    removed += 1

block = [ln for ln in block if ln != ""]
lines[evidence_start:evidence_end] = block
p.write_text("".join(lines), encoding="utf-8")

if removed == 0:
  print(f"WARN: not found (no-op): {link}", file=sys.stderr)
else:
  print(f"Removed link: {link} ({removed} occurrence(s)) -> {p}")
PY

"$ROOT/phosphene/domains/product-marketing/scripts/validate_persona.sh" "$PERSONA" >/dev/null
echo "OK: validated $PERSONA"

