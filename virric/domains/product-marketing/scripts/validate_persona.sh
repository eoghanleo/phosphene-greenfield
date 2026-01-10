#!/usr/bin/env bash
set -euo pipefail

# validate_persona.sh
# Validates a <product-marketing> Persona (PER-*) artifact for structural compliance.
#
# Usage:
#   ./virric/domains/product-marketing/scripts/validate_persona.sh <persona_file>
#   ./virric/domains/product-marketing/scripts/validate_persona.sh --all

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../virric-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/virric_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./virric/domains/product-marketing/scripts/validate_persona.sh <persona_file>
  ./virric/domains/product-marketing/scripts/validate_persona.sh --all

Checks:
  - required headers exist (ID/Title/Status/Updated/Dependencies/Owner)
  - required sections exist:
      ## Snapshot summary
      ## Jobs
      ## Pains
      ## Gains
      ## Evidence and links
      ## Notes
  - Jobs/Pains/Gains include a table with JTBD-ID + Importance
  - IDs follow: JTBD-JOB-####-PER-#### / JTBD-PAIN-####-PER-#### / JTBD-GAIN-####-PER-#### (suffix must match the persona ID)
  - Importance is integer 1..5
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }
warn() { echo "WARN: $*" >&2; }

ROOT="$(virric_find_project_root)"

validate_file() {
  local f="$1"
  [[ -f "$f" ]] || fail "Not a file: $f"

  # Header checks (only require presence somewhere in first ~20 lines)
  local head
  head="$(head -n 25 "$f")"
  echo "$head" | grep -qE '^ID:[[:space:]]*PER-[0-9]{4}[[:space:]]*$' || fail "$(basename "$f"): missing/invalid 'ID: PER-####'"
  local persona_id
  persona_id="$(echo "$head" | grep -E '^ID:[[:space:]]*PER-[0-9]{4}[[:space:]]*$' | head -n 1 | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"
  [[ -n "${persona_id:-}" ]] || fail "$(basename "$f"): could not parse persona ID"
  echo "$head" | grep -qE '^Title:[[:space:]]*.+$' || fail "$(basename "$f"): missing 'Title:'"
  echo "$head" | grep -qE '^Status:[[:space:]]*.+$' || fail "$(basename "$f"): missing 'Status:'"
  echo "$head" | grep -qE '^Updated:[[:space:]]*([0-9]{4}-[0-9]{2}-[0-9]{2}|YYYY-MM-DD)[[:space:]]*$' || fail "$(basename "$f"): missing/invalid 'Updated:'"
  echo "$head" | grep -qE '^Dependencies:' || fail "$(basename "$f"): missing 'Dependencies:'"
  echo "$head" | grep -qE '^Owner:' || fail "$(basename "$f"): missing 'Owner:'"

  # Section checks
  for h in \
    "## Snapshot summary" \
    "## Jobs" \
    "## Pains" \
    "## Gains" \
    "## Evidence and links" \
    "## Notes"
  do
    grep -qF "$h" "$f" || fail "$(basename "$f"): missing section '$h'"
  done

  # Extract table rows per section, then validate ID patterns + Importance.
  # We parse as:
  # - find section start line
  # - read until next '## ' heading
  # - from that chunk, pull markdown table rows where col1 matches JTBD-...
  local tmp
  tmp="$(mktemp)"
  trap 'rm -f "${tmp:-}"' RETURN

  extract_rows() {
    local section="$1"
    awk -v section="$section" '
      BEGIN { inside=0; }
      $0 == section { inside=1; next; }
      inside && $0 ~ /^## / { exit; }
      inside { print; }
    ' "$f"
  }

  check_table() {
    local section="$1"
    local prefix="$2"   # JTBD-JOB|JTBD-PAIN|JTBD-GAIN (without -####)
    local pid="$3"      # PER-#### (must match suffix in JTBD-ID)

    extract_rows "$section" > "$tmp"

    # Must have a table header containing JTBD-ID and Importance
    grep -qE '[|][[:space:]]*JTBD-ID[[:space:]]*[|]' "$tmp" || fail "$(basename "$f"): $section missing table header 'JTBD-ID'"
    grep -qE '[|][[:space:]]*Importance[[:space:]]*[|]' "$tmp" || fail "$(basename "$f"): $section missing table header 'Importance'"

    # Validate each data row where first cell is JTBD-...
    local bad=0
    awk -v section="$section" -v prefix="$prefix" -v pid="$pid" -v file="$(basename "$f")" '
      BEGIN { FS="|"; }
      $0 ~ /^[|][[:space:]]*JTBD-[A-Z]+-[0-9]{4}-PER-[0-9]{4}[[:space:]]*[|]/ {
        id=$2; imp=$4;
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", id);
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", imp);
        if (id !~ ("^" prefix "-[0-9]{4}-" pid "$")) {
          print "WARN: " file ": " section " invalid JTBD-ID for section: " id > "/dev/stderr";
          bad=1;
        }
        if (imp !~ /^[1-5]$/) {
          print "WARN: " file ": " section " invalid Importance (1..5): " imp > "/dev/stderr";
          bad=1;
        }
        if (seen[id]++ > 0) {
          print "WARN: " file ": duplicate JTBD-ID within file: " id > "/dev/stderr";
          bad=1;
        }
      }
      END { exit bad; }
    ' "$tmp" || bad=1

    [[ "$bad" -eq 0 ]] || fail "$(basename "$f"): $section has invalid rows (see WARN lines)"
  }

  check_table "## Jobs"  "JTBD-JOB"  "$persona_id"
  check_table "## Pains" "JTBD-PAIN" "$persona_id"
  check_table "## Gains" "JTBD-GAIN" "$persona_id"

  echo "OK: $f"
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" || -z "${1:-}" ]]; then
  usage
  exit 0
fi

if [[ "${1:-}" == "--all" ]]; then
  dir="$ROOT/virric/domains/product-marketing/docs/personas"
  [[ -d "$dir" ]] || fail "Missing personas dir: $dir"
  found=0
  while IFS= read -r -d '' f; do
    found=1
    validate_file "$f"
  done < <(find "$dir" -type f -name "PER-*.md" -print0)
  if [[ "$found" -eq 0 ]]; then
    warn "No personas found under $dir"
  fi
  exit 0
fi

target="$1"
if [[ "$target" != /* ]]; then
  target="$ROOT/$target"
fi
validate_file "$target"

