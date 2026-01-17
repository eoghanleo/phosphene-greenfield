#!/usr/bin/env bash
set -euo pipefail

# create_new_proposition.sh
# Creates a Proposition (PROP-*) doc from the canonical template, allocating IDs via the global registry.
#
# Usage:
#   ./phosphene/domains/product-marketing/scripts/create_new_proposition.sh --title "..." --vpd VPD-001 [--id PROP-0001] [--owner "..."] [--status Draft] [--dependencies "PER-0001,RA-001"] [--output-dir <dir>]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../phosphene-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/phosphene_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./phosphene/domains/product-marketing/scripts/create_new_proposition.sh --title "..." --vpd VPD-001 [--id PROP-0001] [--owner "..."] [--status Draft] [--dependencies "..."] [--output-dir <dir>]
EOF
}

slugify() {
  echo "$1" \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//; s/-+/-/g'
}

ROOT="$(phosphene_find_project_root)"

TITLE=""
ID=""
OWNER=""
STATUS="Draft"
DEPENDENCIES=""
VPD=""
OUT_DIR=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --title) TITLE="${2:-}"; shift 2 ;;
    --id) ID="${2:-}"; shift 2 ;;
    --owner) OWNER="${2:-}"; shift 2 ;;
    --status) STATUS="${2:-}"; shift 2 ;;
    --vpd) VPD="${2:-}"; shift 2 ;;
    --dependencies) DEPENDENCIES="${2:-}"; shift 2 ;;
    --output-dir) OUT_DIR="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "$TITLE" ]] || { echo "Error: --title is required" >&2; usage; exit 2; }

[[ -n "${VPD}" ]] || { echo "Error: --vpd is required (WTBD parent; expected VPD-001)" >&2; usage; exit 2; }
if ! [[ "$VPD" =~ ^VPD-[0-9]{3}$ ]]; then
  echo "Error: --vpd must look like VPD-001" >&2
  exit 2
fi

if [[ -n "${OUT_DIR}" && "$OUT_DIR" != /* ]]; then OUT_DIR="$ROOT/$OUT_DIR"; fi
if [[ -z "${OUT_DIR}" ]]; then
  vpd_cover="$("$ROOT/phosphene/phosphene-core/bin/phosphene" id where "$VPD" 2>/dev/null | head -n 1 | awk -F'\t' '{print $3}')"
  [[ -n "${vpd_cover:-}" ]] || { echo "Error: cannot locate $VPD in repo. Create a VPD bundle first." >&2; exit 1; }
  OUT_DIR="$ROOT/$(dirname "$vpd_cover")/20-propositions"
fi
mkdir -p "$OUT_DIR"

# Ensure VPD is always present in Dependencies.
if ! echo ",${DEPENDENCIES}," | grep -qF ",${VPD},"; then
  if [[ -n "${DEPENDENCIES}" ]]; then
    DEPENDENCIES="${VPD},${DEPENDENCIES}"
  else
    DEPENDENCIES="${VPD}"
  fi
fi

if [[ -z "${ID}" ]]; then
  "$ROOT/phosphene/phosphene-core/bin/phosphene" id validate >/dev/null
  ID="$("$ROOT/phosphene/phosphene-core/bin/phosphene" id next --type proposition)"
fi

if ! [[ "$ID" =~ ^PROP-[0-9]{4}$ ]]; then
  echo "Error: --id must look like PROP-0001" >&2
  exit 2
fi

DATE="$(date +%F)"
SLUG="$(slugify "$TITLE")"
OUT="$OUT_DIR/${ID}-${SLUG}.md"

if [[ -e "$OUT" ]]; then
  echo "Error: already exists: $OUT" >&2
  exit 1
fi

TEMPLATE="$ROOT/phosphene/domains/product-marketing/templates/value-proposition-design-bundle/proposition.md"
[[ -f "$TEMPLATE" ]] || { echo "Error: missing template: $TEMPLATE" >&2; exit 1; }

cp "$TEMPLATE" "$OUT"

# Fill in the header block (bash-only).
TMP_EDIT="$(mktemp)"
awk -v pid="$ID" -v title="$TITLE" -v status="$STATUS" -v updated="$DATE" -v deps="$DEPENDENCIES" -v owner="$OWNER" '
  BEGIN { in_header=1; }
  {
    if (in_header) {
      if ($0 ~ /^ID:[[:space:]]*/) { print "ID: " pid; next; }
      if ($0 ~ /^Title:/) { print "Title: " title; next; }
      if ($0 ~ /^Status:/) { print "Status: " status; next; }
      if ($0 ~ /^Updated:/) { print "Updated: " updated; next; }
      if ($0 ~ /^Dependencies:/) { print "Dependencies: " deps; next; }
      if ($0 ~ /^Owner:/) { print "Owner: " owner; next; }
    }
    print
    if (in_header && $0 == "") { in_header=0; }
  }
' "$OUT" > "$TMP_EDIT"

# Validate (strict: scripts must not create strict-invalid artifacts)
set +e
"$ROOT/phosphene/domains/product-marketing/scripts/validate_proposition.sh" --strict "$TMP_EDIT" >/dev/null
rc=$?
set -e
if [[ $rc -ne 0 ]]; then
  rm -f "$TMP_EDIT" "$OUT" || true
  exit $rc
fi

mv "$TMP_EDIT" "$OUT"
echo "Created proposition: $OUT"

