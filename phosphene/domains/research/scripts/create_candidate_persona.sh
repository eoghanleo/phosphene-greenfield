#!/usr/bin/env bash
set -euo pipefail

# create_candidate_persona.sh
# Creates a Candidate Persona (CPE) doc inside an RA bundle.
#
# Why:
# - CPE-* are authoritative in <research> as "1:1 proposals" for canonical personas.
# - Canonical personas (PER-*) are authoritative in <product-marketing> only.
#
# Usage:
#   ./phosphene/domains/research/scripts/create_candidate_persona.sh --bundle <bundle_dir> --name "Idle Ingrid" [--segment SEG-0001]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../phosphene-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/phosphene_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./phosphene/domains/research/scripts/create_candidate_persona.sh --bundle <bundle_dir> --name "..." [--segment SEG-0001]
EOF
}

slugify() {
  echo "$1" \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//; s/-+/-/g'
}

BUNDLE=""
NAME=""
SEGMENT="SEG-XXXX"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --bundle) BUNDLE="${2:-}"; shift 2 ;;
    --name) NAME="${2:-}"; shift 2 ;;
    --segment) SEGMENT="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "$BUNDLE" ]] || { echo "Error: --bundle is required" >&2; usage; exit 2; }
[[ -n "$NAME" ]] || { echo "Error: --name is required" >&2; usage; exit 2; }

ROOT="$(phosphene_find_project_root)"
if [[ "$BUNDLE" != /* ]]; then
  BUNDLE="$ROOT/$BUNDLE"
fi
[[ -d "$BUNDLE" ]] || { echo "Error: bundle dir not found: $BUNDLE" >&2; exit 1; }

RA_ID="$(grep -E '^ID:[[:space:]]*RA-[0-9]{3}[[:space:]]*$' "$BUNDLE/00-coversheet.md" | head -n 1 | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"
[[ -n "${RA_ID:-}" ]] || { echo "Error: could not read RA ID from $BUNDLE/00-coversheet.md" >&2; exit 1; }

# Ensure global uniqueness is clean before allocating.
"$ROOT/phosphene/phosphene-core/bin/phosphene" id validate >/dev/null
CPE_ID="$("$ROOT/phosphene/phosphene-core/bin/phosphene" id next --type cpe)"

OUT_DIR="$BUNDLE/60-candidate-personas"
mkdir -p "$OUT_DIR"

OUT_FILE="$OUT_DIR/${CPE_ID}-$(slugify "$NAME").md"
if [[ -e "$OUT_FILE" ]]; then
  echo "Error: already exists: $OUT_FILE" >&2
  exit 1
fi

DATE="$(date +%F)"
TEMPLATE="$ROOT/phosphene/domains/research/templates/candidate-persona.md"
[[ -f "$TEMPLATE" ]] || { echo "Error: missing template: $TEMPLATE" >&2; exit 1; }

sed \
  -e "s/^ID: CPE-XXXX$/ID: ${CPE_ID}/" \
  -e "s/^Title: Candidate Persona — <name>$/Title: Candidate Persona — ${NAME}/" \
  -e "s/^Updated: YYYY-MM-DD$/Updated: ${DATE}/" \
  -e "s/^Dependencies: RA-XXX$/Dependencies: ${RA_ID}/" \
  -e "s/^\\- SegmentID: SEG-XXXX$/- SegmentID: ${SEGMENT}/" \
  "$TEMPLATE" > "$OUT_FILE"

# Strip template sample rows from all markdown tables (keep header + separator only).
# (Candidate persona template currently has no tables; this is future-proof.)
DOC_PATH="$OUT_FILE" python3 - <<'PY'
import os, re
from pathlib import Path

p = Path(os.environ["DOC_PATH"])
lines = p.read_text(encoding="utf-8").splitlines(True)

sep = re.compile(r"^\|\s*:?-{3,}.*\|\s*$")
out = []
i = 0
while i < len(lines):
  if lines[i].lstrip().startswith("|") and i + 1 < len(lines) and sep.match(lines[i + 1]):
    out.append(lines[i])
    out.append(lines[i + 1])
    i += 2
    while i < len(lines) and lines[i].lstrip().startswith("|"):
      i += 1
    continue
  out.append(lines[i])
  i += 1

p.write_text("".join(out), encoding="utf-8")
PY

echo "Created candidate persona: $OUT_FILE"
echo "Next:"
echo "  - add EvidenceIDs + confidence"
echo "  - reference ${CPE_ID} from hypotheses/evidence/pitches as needed"

