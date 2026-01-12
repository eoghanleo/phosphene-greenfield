#!/usr/bin/env bash
set -euo pipefail

# add_persona_related_link.sh
# Adds a link (URL or repo path) under "## Evidence and links" → "### Links".
#
# Usage:
#   ./phosphene/domains/product-marketing/scripts/add_persona_related_link.sh --persona <file> --link "<url-or-path>"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../phosphene-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/phosphene_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./phosphene/domains/product-marketing/scripts/add_persona_related_link.sh --persona <file> --link "<url-or-path>"
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
if not link:
  print("FAIL: empty link", file=sys.stderr)
  sys.exit(1)

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

links_h = "### Links"
links_i = None
for i, ln in enumerate(block):
  if ln.rstrip("\n") == links_h:
    links_i = i
    break
if links_i is None:
  print(f"FAIL: {p.name}: missing '{links_h}' under Evidence and links", file=sys.stderr)
  sys.exit(1)

# Determine the range of bullet lines after "### Links" until next heading or end.
end = len(block)
for j in range(links_i + 1, len(block)):
  if block[j].startswith("### "):
    end = j
    break

items = []
for j in range(links_i + 1, end):
  m = re.match(r"^\-\s+(.*)\s*$", block[j].rstrip("\n"))
  if m:
    items.append(m.group(1))

normalized = [x for x in items if x != "<...>"]
if link not in normalized:
  normalized.append(link)
normalized = sorted(set(normalized))

# Remove existing bullets in Links subsection
for j in reversed(range(links_i + 1, end)):
  if re.match(r"^\-\s+", block[j]):
    del block[j]

insert_pos = links_i + 1
for x in normalized:
  block.insert(insert_pos, f"- {x}\n")
  insert_pos += 1
block.insert(insert_pos, "\n")

lines[evidence_start:evidence_end] = block
p.write_text("".join(lines), encoding="utf-8")
print(f"Added link: {link} -> {p}")
PY

"$ROOT/phosphene/domains/product-marketing/scripts/validate_persona.sh" "$PERSONA" >/dev/null
echo "OK: validated $PERSONA"

