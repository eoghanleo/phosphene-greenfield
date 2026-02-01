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
  local issue_number
  issue_number="$(grep -E '^IssueNumber:[[:space:]]*[0-9]+' "$file" | head -n 1 | sed -E 's/^IssueNumber:[[:space:]]*//; s/[[:space:]]*$//')"
  [[ -n "${issue_number:-}" ]] || fail "Cannot parse IssueNumber header in $file"
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

  for h in "## Problem / opportunity" "## Target user hypotheses" "## Next research questions" "## Creative exploration matrix" "## Revision passes"; do
    if ! awk -v h="$h" '$0==h { found=1 } END{ exit found?0:1 }' "$file"; then
      fail "Missing required heading (${h}) in $file"
    fi
  done

  local spark_id spark_path
  spark_id="$(printf "SPARK-%06d" "$issue_number")"
  spark_path="$ROOT/phosphene/signals/sparks/${spark_id}.md"
  [[ -f "$spark_path" ]] || fail "Missing SPARK snapshot for issue ${issue_number} (${spark_id}.md) for $file"

  local axis_ids_raw
  axis_ids_raw="$(awk -v key="ExplorationAxisIDs" '
    BEGIN{ found=0; }
    NF==0 { exit }
    $0 ~ ("^" key ":") {
      sub("^" key ":[[:space:]]*", "", $0);
      print $0;
      found=1;
      exit
    }
    END{ if (found==0) exit 1 }
  ' "$spark_path" 2>/dev/null || true)"
  [[ -n "${axis_ids_raw:-}" ]] || fail "Missing ExplorationAxisIDs in SPARK header: $spark_path (required for matrix validation)"

  axis_ids_raw="$(printf "%s" "$axis_ids_raw" | tr -d '\r')"
  axis_ids_clean="$(printf "%s" "$axis_ids_raw" | tr -d '[:space:]')"
  axis_count="$(printf "%s" "$axis_ids_clean" | tr ',' '\n' | awk 'NF{c++} END{print c+0}')"
  if [[ "$axis_count" -ne 10 ]]; then
    fail "ExplorationAxisIDs must contain exactly 10 AX-### IDs (found ${axis_count}) in $spark_path"
  fi
  axis_unique_count="$(printf "%s" "$axis_ids_clean" | tr ',' '\n' | sort -u | awk 'NF{c++} END{print c+0}')"
  if [[ "$axis_unique_count" -ne 10 ]]; then
    fail "ExplorationAxisIDs must contain 10 unique AX-### IDs (found ${axis_unique_count} unique) in $spark_path"
  fi

  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "$tmp_dir"' RETURN
  expected="$tmp_dir/expected.tsv"
  found="$tmp_dir/found.tsv"
  : > "$expected"
  : > "$found"

  axis_index=0
  while IFS= read -r axis_id; do
    axis_id="$(printf "%s" "$axis_id" | sed -E 's/^[[:space:]]+|[[:space:]]+$//g')"
    [[ -n "${axis_id:-}" ]] || continue
    if ! [[ "$axis_id" =~ ^AX-[0-9]{3}$ ]]; then
      fail "Invalid axis id in ExplorationAxisIDs: $axis_id (expected AX-###) in $spark_path"
    fi
    axis_index=$((axis_index + 1))
    for ring in adjacent orthogonal extrapolatory; do
      ring_index=0
      case "$ring" in
        adjacent) ring_index=1 ;;
        orthogonal) ring_index=2 ;;
        extrapolatory) ring_index=3 ;;
      esac
      n=$(( (axis_index - 1) * 3 + ring_index ))
      cand_id="$(printf "CAND-%02d" "$n")"
      printf "%s\t%s\t%s\n" "$cand_id" "$ring" "$axis_id" >> "$expected"
    done
  done < <(printf "%s\n" "$axis_ids_raw" | tr ',' '\n')

  awk -F'|' -v start="## Creative exploration matrix" -v out="$found" '
    function trim(s){ gsub(/^[[:space:]]+|[[:space:]]+$/, "", s); return s; }
    function sent_count(s){
      c=0;
      for (i=1;i<=length(s);i++){
        ch=substr(s,i,1);
        if (ch=="." || ch=="!" || ch=="?") c++;
      }
      return c;
    }
    BEGIN{ inside=0; count=0; }
    $0==start { inside=1; next }
    inside && $0 ~ /^## / { exit }
    !inside { next }
    $0 !~ /^\|/ { next }
    {
      n=split($0, a, /\|/);
      if (n != 10) { print "Invalid matrix row (unexpected pipe count; avoid | in cells)" > "/dev/stderr"; exit 2 }
      id=trim(a[2]); ring=tolower(trim(a[3])); axis_id=trim(a[4]); axis=trim(a[5]);
      failm=trim(a[6]); core=trim(a[7]); diff=trim(a[8]); idea=trim(a[9]);
      if (id=="" || id=="CandID" || id ~ /^-+$/) next;
      if (id !~ /^CAND-[0-9]{2}$/) { print "Invalid CandID in matrix table: " id > "/dev/stderr"; exit 2 }
      if (ring !~ /^(adjacent|orthogonal|extrapolatory)$/) { print "Invalid Ring in matrix table: " ring " for " id > "/dev/stderr"; exit 2 }
      if (axis_id !~ /^AX-[0-9]{3}$/) { print "Invalid AxisID in matrix table: " axis_id " for " id > "/dev/stderr"; exit 2 }
      if (axis=="" || axis ~ /^<.*>$/) { print "Missing Axis cell for " id > "/dev/stderr"; exit 2 }
      if (failm=="" || failm ~ /^<.*>$/) { print "Missing FailureMode for " id > "/dev/stderr"; exit 2 }
      if (core=="" || core ~ /^<.*>$/) { print "Missing ValueCore for " id > "/dev/stderr"; exit 2 }
      if (diff=="" || diff ~ /^<.*>$/) { print "Missing Differentiator for " id > "/dev/stderr"; exit 2 }
      if (idea=="" || idea ~ /^<.*>$/) { print "Missing Idea paragraph for " id > "/dev/stderr"; exit 2 }
      sc=sent_count(idea);
      if (sc < 3) { print "Idea paragraph must be >= 3 sentences for " id " (found " sc ")" > "/dev/stderr"; exit 2 }
      printf "%s\t%s\t%s\n", id, ring, axis_id >> out;
      count++;
    }
    END{
      if (count != 30) { print "Matrix must contain exactly 30 rows; found " count > "/dev/stderr"; exit 2 }
    }
  ' "$file" || fail "Creative exploration matrix invalid in $file"

  if ! diff -u <(sort "$expected") <(sort "$found") >/dev/null 2>&1; then
    fail "Creative exploration matrix does not match required axes×rings combinations for issue ${issue_number} (SPARK: ${spark_id}) in $file"
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
