#!/usr/bin/env bash
set -euo pipefail

# add_persona_evidence_link.sh
# Adds a supporting ID into the Persona "## Evidence and links" section.
#
# This script is intentionally generous: it routes IDs into buckets:
# - EvidenceIDs: E-####
# - CandidatePersonaIDs: CPE-####
# - DocumentIDs: anything else (RA-###, PITCH-####, RS-####, FR-###, etc.)
#
# Usage:
#   ./phosphene/domains/product-marketing/scripts/add_persona_evidence_link.sh --persona <file> --id E-0001
#   ./phosphene/domains/product-marketing/scripts/add_persona_evidence_link.sh --persona <file> --id CPE-0001
#   ./phosphene/domains/product-marketing/scripts/add_persona_evidence_link.sh --persona <file> --id RA-001

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../phosphene-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/phosphene_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./phosphene/domains/product-marketing/scripts/add_persona_evidence_link.sh --persona <file> --id <stable-id>
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }

ROOT="$(phosphene_find_project_root)"

PERSONA=""
SID=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --persona) PERSONA="${2:-}"; shift 2 ;;
    --id) SID="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "$PERSONA" ]] || { echo "Error: --persona is required" >&2; usage; exit 2; }
[[ -n "$SID" ]] || { echo "Error: --id is required" >&2; usage; exit 2; }

if [[ "$PERSONA" != /* ]]; then PERSONA="$ROOT/$PERSONA"; fi
[[ -f "$PERSONA" ]] || fail "Not a file: $PERSONA"

# Basic sanity: no whitespace
if [[ "$SID" =~ [[:space:]] ]]; then
  fail "--id must not contain whitespace"
fi

PERSONA_PATH="$PERSONA" SUPPORTING_ID="$SID" python3 - <<'PY'
import os, re, sys
from pathlib import Path

p = Path(os.environ["PERSONA_PATH"])
sid = os.environ["SUPPORTING_ID"].strip()

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

def bucket_for(x: str) -> str:
  if re.fullmatch(r"E-\d{4}", x):
    return "### EvidenceIDs"
  if re.fullmatch(r"CPE-\d{4}", x):
    return "### CandidatePersonaIDs"
  return "### DocumentIDs"

bucket = bucket_for(sid)

def ensure_subheading(h: str):
  if any(ln.rstrip("\n") == h for ln in block):
    return
  # Insert missing subheading just before "### Links" if possible, else before end.
  insert_at = None
  for j, ln in enumerate(block):
    if ln.rstrip("\n") == "### Links":
      insert_at = j
      break
  if insert_at is None:
    insert_at = len(block)
  block.insert(insert_at, h + "\n")
  block.insert(insert_at + 1, "\n")
  block.insert(insert_at + 2, "- <...>\n")
  block.insert(insert_at + 3, "\n")

# Ensure all expected headings exist
for h in ["### EvidenceIDs", "### CandidatePersonaIDs", "### DocumentIDs", "### Links"]:
  if not any(ln.rstrip("\n") == h for ln in block):
    # Create empty list placeholder
    idx = len(block)
    # Keep Links last if present
    for j, ln in enumerate(block):
      if ln.rstrip("\n") == "### Links":
        idx = j
        break
    block.insert(idx, h + "\n")
    block.insert(idx + 1, "- <...>\n")
    block.insert(idx + 2, "\n")

def collect_items(h: str):
  # Return (start_idx, end_idx, items, item_line_idxs)
  start = None
  for j, ln in enumerate(block):
    if ln.rstrip("\n") == h:
      start = j
      break
  if start is None:
    return None
  end = len(block)
  for j in range(start + 1, len(block)):
    if block[j].startswith("### "):
      end = j
      break
  items = []
  item_idxs = []
  for j in range(start + 1, end):
    m = re.match(r"^\-\s+(.*)\s*$", block[j].rstrip("\n"))
    if m:
      items.append(m.group(1))
      item_idxs.append(j)
  return start, end, items, item_idxs

start, end, items, item_idxs = collect_items(bucket)
if start is None:
  print(f"FAIL: {p.name}: could not locate bucket heading {bucket}", file=sys.stderr)
  sys.exit(1)

normalized = [x for x in items if x != "<...>"]
if sid in normalized:
  print(f"OK: already present: {sid}", file=sys.stderr)
else:
  normalized.append(sid)
  normalized = sorted(set(normalized))

  # Remove old bullet lines in this bucket
  for j in reversed(range(start + 1, end)):
    if re.match(r"^\-\s+", block[j]):
      del block[j]

  # Insert bullets right after heading
  insert_pos = start + 1
  for x in normalized:
    block.insert(insert_pos, f"- {x}\n")
    insert_pos += 1
  block.insert(insert_pos, "\n")

# Write back the modified block
lines[evidence_start:evidence_end] = block
p.write_text("".join(lines), encoding="utf-8")
print(f"Added supporting ID: {sid} -> {p}")
PY

"$ROOT/phosphene/domains/product-marketing/scripts/validate_persona.sh" "$PERSONA" >/dev/null
echo "OK: validated $PERSONA"

