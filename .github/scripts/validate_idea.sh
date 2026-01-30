#!/usr/bin/env bash
#
# IDEA Validation Script (bash-only)
# Validates ideation artifacts adhere to header and section requirements.
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
LIB_DIR="$ROOT/phosphene/phosphene-core/lib"
# shellcheck source=/dev/null
source "$LIB_DIR/phosphene_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./.github/scripts/validate_idea.sh [--all] [FILE|DIRECTORY]
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }

ROOT="$(phosphene_find_project_root)" || fail "Not in a PHOSPHENE project."
DEFAULT_DIR="$ROOT/phosphene/domains/ideation/output/ideas"

ALL=0
TARGET=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --all) ALL=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) TARGET="$1"; shift ;;
  esac
done

validate_file() {
  local file="$1"
  [[ -f "$file" ]] || return 1

  local id
  id="$(grep -E '^ID:[[:space:]]*IDEA-[0-9]{4}[[:space:]]*$' "$file" | head -n 1 | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"
  [[ -n "${id:-}" ]] || fail "Missing or invalid ID header in $file"

  if ! grep -q "^Title: " "$file"; then
    fail "Missing Title header in $file"
  fi
  if ! grep -q "^Status: " "$file"; then
    fail "Missing Status header in $file"
  fi
  if ! grep -q "^Updated: " "$file"; then
    fail "Missing Updated header in $file"
  fi
  if ! grep -q "^Dependencies: " "$file"; then
    fail "Missing Dependencies header in $file"
  fi

  local base
  base="$(basename "$file")"
  if ! [[ "$base" =~ ^${id} ]]; then
    fail "Filename does not start with ID ($id): $base"
  fi

  for h in "## Problem / opportunity" "## Target user hypotheses" "## Next research questions"; do
    if ! grep -qE "^${h}$" "$file"; then
      fail "Missing required heading (${h}) in $file"
    fi
  done
}

files=()
if [[ "$ALL" -eq 1 ]]; then
  [[ -d "$DEFAULT_DIR" ]] || fail "Missing ideation directory: $DEFAULT_DIR"
  while IFS= read -r f; do files+=("$f"); done < <(find "$DEFAULT_DIR" -type f -name "IDEA-*.md" | sort)
elif [[ -n "${TARGET:-}" ]]; then
  if [[ -f "$TARGET" ]]; then
    files=("$TARGET")
  elif [[ -d "$TARGET" ]]; then
    while IFS= read -r f; do files+=("$f"); done < <(find "$TARGET" -type f -name "IDEA-*.md" | sort)
  else
    fail "Target not found: $TARGET"
  fi
else
  [[ -d "$DEFAULT_DIR" ]] || fail "Missing ideation directory: $DEFAULT_DIR"
  while IFS= read -r f; do files+=("$f"); done < <(find "$DEFAULT_DIR" -type f -name "IDEA-*.md" | sort)
fi

if [[ "${#files[@]}" -eq 0 ]]; then
  fail "No IDEA files found to validate."
fi

for f in "${files[@]}"; do
  validate_file "$f"
done

echo "OK: validated ${#files[@]} IDEA file(s)"
