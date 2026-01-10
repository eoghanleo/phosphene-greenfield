#!/usr/bin/env bash
set -euo pipefail

# remove_persona_evidence_link.sh
# Removes a supporting ID from the Persona "## Evidence and links" section.
#
# Buckets follow the same rules as add_persona_evidence_link.sh.
#
# Usage:
#   ./virric/domains/product-marketing/scripts/remove_persona_evidence_link.sh --persona <file> --id E-0001

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../virric-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/virric_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./virric/domains/product-marketing/scripts/remove_persona_evidence_link.sh --persona <file> --id <stable-id>
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }

ROOT="$(virric_find_project_root)"

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

# Remove from any bucket where it appears (EvidenceIDs/CandidatePersonaIDs/DocumentIDs)
removed = 0
for i, ln in enumerate(block):
  if re.match(r"^\-\s+" + re.escape(sid) + r"\s*$", ln.rstrip("\n")):
    block[i] = ""  # mark
    removed += 1

block = [ln for ln in block if ln != ""]
lines[evidence_start:evidence_end] = block
p.write_text("".join(lines), encoding="utf-8")

if removed == 0:
  print(f"WARN: not found (no-op): {sid}", file=sys.stderr)
else:
  print(f"Removed supporting ID: {sid} ({removed} occurrence(s)) -> {p}")
PY

"$ROOT/virric/domains/product-marketing/scripts/validate_persona.sh" "$PERSONA" >/dev/null
echo "OK: validated $PERSONA"

