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
  if ! grep -q "^IssueNumber: " "$file"; then
    fail "Missing IssueNumber header in $file"
  fi
  if ! grep -qE "^IssueNumber:[[:space:]]*[0-9]+[[:space:]]*$" "$file"; then
    fail "Invalid IssueNumber header in $file (must be numeric)"
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

  for h in "## Problem / opportunity" "## Target user hypotheses" "## Next research questions" "## Divergence enumeration (pure)" "## Stress-test enumeration (all candidates)" "## Revision passes"; do
    if ! awk -v h="$h" '$0==h { found=1 } END{ exit found?0:1 }' "$file"; then
      fail "Missing required heading (${h}) in $file"
    fi
  done

  div_ids="$(mktemp)"
  stress_ids="$(mktemp)"
  trap 'rm -f "$div_ids" "$stress_ids"' RETURN

  awk -F'|' -v start="## Divergence enumeration (pure)" -v out="$div_ids" '
    function trim(s){ gsub(/^[[:space:]]+|[[:space:]]+$/, "", s); return s; }
    BEGIN{ inside=0; count=0; }
    $0==start { inside=1; next }
    inside && $0 ~ /^## / { exit }
    !inside { next }
    $0 !~ /^\|/ { next }
    {
      id=trim($2); ring=tolower(trim($3)); axes=trim($4); one=trim($5);
      if (id=="" || id=="CandID" || id ~ /^-+$/) next;
      if (id !~ /^CAND-[0-9]{2,3}$/) { print "Invalid CandID in divergence table: " id > "/dev/stderr"; exit 2 }
      if (ring !~ /^(adjacent|orthogonal|extrapolatory)$/) { print "Invalid Ring in divergence table: " ring > "/dev/stderr"; exit 2 }
      if (axes=="" || axes ~ /^<.*>$/) { print "Missing Axes for " id > "/dev/stderr"; exit 2 }
      if (one=="" || one ~ /^<.*>$/) { print "Missing OneLiner for " id > "/dev/stderr"; exit 2 }
      print id >> out;
      count++;
    }
    END{
      if (count < 12) { print "Need at least 12 divergence candidates; found " count > "/dev/stderr"; exit 2 }
    }
  ' "$file" || fail "Divergence enumeration invalid in $file"

  awk -F'|' -v start="## Stress-test enumeration (all candidates)" -v out="$stress_ids" '
    function trim(s){ gsub(/^[[:space:]]+|[[:space:]]+$/, "", s); return s; }
    BEGIN{ inside=0; count=0; }
    $0==start { inside=1; next }
    inside && $0 ~ /^## / { exit }
    !inside { next }
    $0 !~ /^\|/ { next }
    {
      id=trim($2); failm=trim($3); core=trim($4); diff=trim($5);
      if (id=="" || id=="CandID" || id ~ /^-+$/) next;
      if (id !~ /^CAND-[0-9]{2,3}$/) { print "Invalid CandID in stress-test table: " id > "/dev/stderr"; exit 2 }
      if (failm=="" || failm ~ /^<.*>$/) { print "Missing FailureMode for " id > "/dev/stderr"; exit 2 }
      if (core=="" || core ~ /^<.*>$/) { print "Missing ValueCore for " id > "/dev/stderr"; exit 2 }
      if (diff=="" || diff ~ /^<.*>$/) { print "Missing Differentiator for " id > "/dev/stderr"; exit 2 }
      print id >> out;
      count++;
    }
    END{
      if (count < 1) { print "Stress-test table empty" > "/dev/stderr"; exit 2 }
    }
  ' "$file" || fail "Stress-test enumeration invalid in $file"

  if ! diff -u <(sort -u "$div_ids") <(sort -u "$stress_ids") >/dev/null 2>&1; then
    fail "CandID mismatch between divergence and stress-test tables in $file"
  fi

  rev_count="$(awk -v start="## Revision passes" '
    BEGIN{ inside=0; c=0; }
    $0==start { inside=1; next }
    inside && $0 ~ /^## / { exit }
    inside && $0 ~ /^-[[:space:]]+/ { c++; }
    END{ print c+0; }
  ' "$file")"
  if [[ "$rev_count" -lt 2 ]]; then
    fail "Revision passes must include at least 2 bullet items in $file"
  fi
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
