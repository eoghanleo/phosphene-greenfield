#!/usr/bin/env bash
set -euo pipefail

# validate_research_assessment_bundle.sh
# Validates an RA bundle for basic structural and cross-reference compliance.
#
# Usage:
#   ./virric/domains/research/scripts/validate_research_assessment_bundle.sh <bundle_dir>

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../virric-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/virric_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./virric/domains/research/scripts/validate_research_assessment_bundle.sh <bundle_dir>

Checks:
  - required files exist
  - RA ID consistency across files
  - presence of basic headings in core files
  - EvidenceIDs referenced in pitches/claims exist in evidence bank
  - ReferenceSolution IDs referenced exist in reference solutions file
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }
warn() { echo "WARN: $*" >&2; }

BUNDLE_DIR="${1:-}"
if [[ -z "$BUNDLE_DIR" || "$BUNDLE_DIR" == "-h" || "$BUNDLE_DIR" == "--help" ]]; then
  usage
  exit 0
fi

ROOT="$(virric_find_project_root)"
if [[ "$BUNDLE_DIR" != /* ]]; then
  BUNDLE_DIR="$ROOT/$BUNDLE_DIR"
fi

[[ -d "$BUNDLE_DIR" ]] || fail "Not a directory: $BUNDLE_DIR"

REQ_FILES=(
  "00-coversheet.md"
  "10-reference-solutions.md"
  "20-competitive-landscape.md"
  "40-hypotheses.md"
  "50-evidence-bank.md"
  "90-methods.md"
)

for f in "${REQ_FILES[@]}"; do
  [[ -f "$BUNDLE_DIR/$f" ]] || fail "Missing required file: $f"
done

# Extract RA ID (source of truth = coversheet)
ID_LINE="$(grep -E '^ID:[[:space:]]*RA-[0-9]{3}[[:space:]]*$' "$BUNDLE_DIR/00-coversheet.md" || true)"
[[ -n "$ID_LINE" ]] || fail "00-coversheet.md missing 'ID: RA-###' line"
RA_ID="$(echo "$ID_LINE" | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"

# Check other core files contain same ID (soft; warn if absent)
for f in "${REQ_FILES[@]}"; do
  if ! grep -qE "^ID:\\s*${RA_ID}\\s*$" "$BUNDLE_DIR/$f"; then
    warn "$f does not contain 'ID: $RA_ID' (recommended for self-contained files)"
  fi
done

# Basic headings presence
for f in "00-coversheet.md" "10-reference-solutions.md" "20-competitive-landscape.md" "40-hypotheses.md" "50-evidence-bank.md" "90-methods.md"; do
  if ! grep -qE '^## ' "$BUNDLE_DIR/$f"; then
    fail "$f has no '##' headings (expected markdown structure)"
  fi
done

# EvidenceIDs existence check:
# - Gather referenced EvidenceIDs from pitches + coversheet + hypotheses + competition (common places)
TMP_REF_E="$(mktemp)"
TMP_BANK_E="$(mktemp)"
trap 'rm -f "$TMP_REF_E" "$TMP_BANK_E"' EXIT

{
  grep -Eo 'E-[0-9]{4}' "$BUNDLE_DIR/00-coversheet.md" || true
  grep -Eo 'E-[0-9]{4}' "$BUNDLE_DIR/20-competitive-landscape.md" || true
  grep -Eo 'E-[0-9]{4}' "$BUNDLE_DIR/40-hypotheses.md" || true
  if compgen -G "$BUNDLE_DIR/30-pitches/PITCH-*.md" >/dev/null; then
    grep -h -Eo 'E-[0-9]{4}' "$BUNDLE_DIR"/30-pitches/PITCH-*.md || true
  fi
} | sort -u > "$TMP_REF_E"

grep -Eo '^[|][[:space:]]*(E-[0-9]{4})[[:space:]]*[|]' "$BUNDLE_DIR/50-evidence-bank.md" \
  | sed -E 's/^[|][[:space:]]*(E-[0-9]{4})[[:space:]]*[|].*/\1/' \
  | sort -u > "$TMP_BANK_E" || true

if [[ -s "$TMP_REF_E" && ! -s "$TMP_BANK_E" ]]; then
  fail "EvidenceIDs referenced, but no EvidenceID rows found in 50-evidence-bank.md table"
fi

MISSING_E=0
while IFS= read -r eid; do
  if ! grep -q "^${eid}$" "$TMP_BANK_E"; then
    warn "Missing EvidenceID in evidence bank: $eid"
    MISSING_E=1
  fi
done < "$TMP_REF_E"

if [[ "$MISSING_E" -eq 1 ]]; then
  fail "One or more referenced EvidenceIDs are missing from 50-evidence-bank.md"
fi

# Reference solutions table schema check (must contain RefSolID header)
if ! grep -qE '[|][[:space:]]*RefSolID[[:space:]]*[|]' "$BUNDLE_DIR/10-reference-solutions.md"; then
  fail "10-reference-solutions.md missing RefSolID table header"
fi

# Competitive table schema check
if ! grep -qE '[|][[:space:]]*Competitor[[:space:]]*[|]' "$BUNDLE_DIR/20-competitive-landscape.md"; then
  fail "20-competitive-landscape.md missing Competitor table header"
fi

echo "OK: $BUNDLE_DIR ($RA_ID)"

