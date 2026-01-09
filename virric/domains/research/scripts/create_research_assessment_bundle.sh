#!/usr/bin/env bash
set -euo pipefail

# create_research_assessment_bundle.sh
# Creates a Research Assessment (RA) bundle folder populated from templates.
#
# Usage (run from repo root):
#   ./virric/domains/research/scripts/create_research_assessment_bundle.sh --title "..." [--id RA-001] [--owner ""] [--priority Medium]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../virric-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/virric_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./virric/domains/research/scripts/create_research_assessment_bundle.sh --title "..." [--id RA-001] [--owner "..."] [--priority Medium]

Creates:
  virric/domains/research/docs/research-assessments/RA-001-<slug>/
    00-coversheet.md
    10-reference-solutions.md
    20-competitive-landscape.md
    30-pitches/ (empty)
    40-hypotheses.md
    50-evidence-bank.md
    60-candidate-personas/ (empty; CPE-*.md)
    90-methods.md
    RA-001.md (assembled view; re-runnable)
EOF
}

slugify() {
  # Lowercase, keep alnum and dashes, collapse spaces/underscores to dash.
  # macOS bash 3.2 compatible.
  echo "$1" \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//; s/-+/-/g'
}

ID=""
TITLE=""
OWNER=""
PRIORITY="Medium"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --id) ID="${2:-}"; shift 2 ;;
    --title) TITLE="${2:-}"; shift 2 ;;
    --owner) OWNER="${2:-}"; shift 2 ;;
    --priority) PRIORITY="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

if [[ -z "${TITLE}" ]]; then
  echo "Error: --title is required." >&2
  usage
  exit 2
fi

ROOT="$(virric_find_project_root)"

if [[ -z "${ID}" ]]; then
  "$ROOT/virric/domains/research/scripts/research_id_registry.sh" validate >/dev/null
  # Allocate next legal RA id from global index
  ID="$("$ROOT/virric/domains/research/scripts/research_id_registry.sh" next --type ra)"
fi

if ! [[ "$ID" =~ ^RA-[0-9]{3}$ ]]; then
  echo "Error: --id must look like RA-001" >&2
  exit 2
fi

DOCS_DIR="$ROOT/virric/domains/research/docs/research-assessments"
TEMPLATE_DIR="$ROOT/virric/domains/research/templates/research-assessment-bundle"

if [[ ! -d "$TEMPLATE_DIR" ]]; then
  echo "Error: Missing templates folder: $TEMPLATE_DIR" >&2
  exit 1
fi

mkdir -p "$DOCS_DIR"

SLUG="$(slugify "$TITLE")"
BUNDLE_DIR="$DOCS_DIR/${ID}-${SLUG}"

if [[ -e "$BUNDLE_DIR" ]]; then
  echo "Error: bundle already exists: $BUNDLE_DIR" >&2
  exit 1
fi

mkdir -p "$BUNDLE_DIR/30-pitches"
mkdir -p "$BUNDLE_DIR/60-candidate-personas"

DATE="$(date +%F)"

render_template() {
  local src="$1"
  local dst="$2"
  sed \
    -e "s/{{ID}}/${ID}/g" \
    -e "s/{{TITLE}}/${TITLE}/g" \
    -e "s/{{UPDATED}}/${DATE}/g" \
    -e "s/{{PRIORITY}}/${PRIORITY}/g" \
    -e "s/{{OWNER}}/${OWNER}/g" \
    "$src" > "$dst"
}

render_template "$TEMPLATE_DIR/00-coversheet.md" "$BUNDLE_DIR/00-coversheet.md"
render_template "$TEMPLATE_DIR/10-reference-solutions.md" "$BUNDLE_DIR/10-reference-solutions.md"
render_template "$TEMPLATE_DIR/20-competitive-landscape.md" "$BUNDLE_DIR/20-competitive-landscape.md"
render_template "$TEMPLATE_DIR/40-hypotheses.md" "$BUNDLE_DIR/40-hypotheses.md"
render_template "$TEMPLATE_DIR/50-evidence-bank.md" "$BUNDLE_DIR/50-evidence-bank.md"
render_template "$TEMPLATE_DIR/90-methods.md" "$BUNDLE_DIR/90-methods.md"

echo "# Pitches folder" > "$BUNDLE_DIR/30-pitches/README.md"
echo "" >> "$BUNDLE_DIR/30-pitches/README.md"
echo "Create pitch files here (e.g. \`PITCH-0001.md\`) and reference EvidenceIDs from \`50-evidence-bank.md\`." >> "$BUNDLE_DIR/30-pitches/README.md"

echo "# Candidate personas folder (CPE)" > "$BUNDLE_DIR/60-candidate-personas/README.md"
echo "" >> "$BUNDLE_DIR/60-candidate-personas/README.md"
echo "Create Candidate Persona (CPE-*) files here as 1:1 proposals for canonical personas in <product-marketing>." >> "$BUNDLE_DIR/60-candidate-personas/README.md"
echo "" >> "$BUNDLE_DIR/60-candidate-personas/README.md"
echo "Preferred:" >> "$BUNDLE_DIR/60-candidate-personas/README.md"
echo "  ./virric/domains/research/scripts/create_candidate_persona.sh --bundle \"$BUNDLE_DIR\" --name \"...\" --segment SEG-0001" >> "$BUNDLE_DIR/60-candidate-personas/README.md"

echo "Created RA bundle: $BUNDLE_DIR"
echo "Next:"
echo "  - validate: ./virric/domains/research/scripts/validate_research_assessment_bundle.sh \"$BUNDLE_DIR\""
echo "  - assemble: ./virric/domains/research/scripts/assemble_research_assessment_bundle.sh \"$BUNDLE_DIR\""

