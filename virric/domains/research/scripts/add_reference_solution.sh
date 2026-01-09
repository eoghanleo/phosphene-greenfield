#!/usr/bin/env bash
set -euo pipefail

# add_reference_solution.sh
# Allocates the next legal RefSolID and appends a placeholder row to 10-reference-solutions.md
#
# Usage:
#   ./virric/domains/research/scripts/add_reference_solution.sh --bundle <bundle_dir> --name "..." [--type Market] [--pointer "https://..."]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/virric_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./virric/domains/research/scripts/add_reference_solution.sh --bundle <bundle_dir> --name "..." [--type Market|Academic] [--pointer "https://..."]
EOF
}

BUNDLE=""
NAME=""
RTYPE="Market"
POINTER=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --bundle) BUNDLE="${2:-}"; shift 2 ;;
    --name) NAME="${2:-}"; shift 2 ;;
    --type) RTYPE="${2:-}"; shift 2 ;;
    --pointer) POINTER="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "$BUNDLE" && -n "$NAME" ]] || { echo "Error: --bundle and --name are required" >&2; exit 2; }

ROOT="$(virric_find_project_root)"
if [[ "$BUNDLE" != /* ]]; then BUNDLE="$ROOT/$BUNDLE"; fi
[[ -d "$BUNDLE" ]] || { echo "Error: not a directory: $BUNDLE" >&2; exit 1; }

"$ROOT/virric/domains/research/scripts/research_id_registry.sh" validate >/dev/null
RSID="$("$ROOT/virric/domains/research/scripts/research_id_registry.sh" next --type refsol)"

FILE="$BUNDLE/10-reference-solutions.md"
[[ -f "$FILE" ]] || { echo "Error: missing $FILE" >&2; exit 1; }

if [[ -z "$POINTER" ]]; then POINTER="<link>"; fi

if ! grep -qE '^[|][[:space:]]*RefSolID[[:space:]]*[|]' "$FILE"; then
  echo "Error: refsol table header not found in $FILE" >&2
  exit 1
fi

echo "| ${RSID} | ${RTYPE} | ${NAME} | <...> | <...> | <...> | ${POINTER} |" >> "$FILE"
echo "Added RefSolID: $RSID"

