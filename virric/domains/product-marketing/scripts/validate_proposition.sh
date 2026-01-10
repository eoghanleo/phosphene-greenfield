#!/usr/bin/env bash
set -euo pipefail

# validate_proposition.sh
# Validates a <product-marketing> Proposition (PROP-*) artifact for structural compliance.
#
# Usage:
#   ./virric/domains/product-marketing/scripts/validate_proposition.sh <proposition_file>
#   ./virric/domains/product-marketing/scripts/validate_proposition.sh --all

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../virric-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/virric_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./virric/domains/product-marketing/scripts/validate_proposition.sh <proposition_file>
  ./virric/domains/product-marketing/scripts/validate_proposition.sh --all

Checks:
  - required headers exist (ID/Title/Status/Updated/Dependencies/Owner/EditPolicy)
  - required sections exist:
      ## Formal Pitch
      ## Target Persona(s)
      ## Related Segment(s)
      ## Gain Boosters
      ## Pain Relievers
      ## Capabilities
      ## Notes
  - tables exist with expected headers
  - IDs are natural keys:
      BoosterID: BOOST-####-PROP-####
      RelieverID: REL-####-PROP-####
      CapabilityID: CAP-####-PROP-####
  - CapabilityType is one of: feature|function|standard|experience
  - mapped JTBD arrays are comma-separated lists of JTBD-(GAIN|PAIN)-####-PER-#### (whitespace ok around commas)
EOF
}

fail() { echo "FAIL: $*" >&2; exit 1; }
warn() { echo "WARN: $*" >&2; }

ROOT="$(virric_find_project_root)"

validate_file() {
  local f="$1"
  [[ -f "$f" ]] || fail "Not a file: $f"

  local head
  head="$(head -n 30 "$f")"
  echo "$head" | grep -qE '^ID:[[:space:]]*PROP-[0-9]{4}[[:space:]]*$' || fail "$(basename "$f"): missing/invalid 'ID: PROP-####'"
  local prop_id
  prop_id="$(echo "$head" | grep -E '^ID:[[:space:]]*PROP-[0-9]{4}[[:space:]]*$' | head -n 1 | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"
  [[ -n "${prop_id:-}" ]] || fail "$(basename "$f"): could not parse proposition ID"

  echo "$head" | grep -qE '^Title:[[:space:]]*.+$' || fail "$(basename "$f"): missing 'Title:'"
  echo "$head" | grep -qE '^Status:[[:space:]]*.+$' || fail "$(basename "$f"): missing 'Status:'"
  echo "$head" | grep -qE '^Updated:[[:space:]]*([0-9]{4}-[0-9]{2}-[0-9]{2}|YYYY-MM-DD)[[:space:]]*$' || fail "$(basename "$f"): missing/invalid 'Updated:'"
  echo "$head" | grep -qE '^Dependencies:' || fail "$(basename "$f"): missing 'Dependencies:'"
  echo "$head" | grep -qE '^Owner:' || fail "$(basename "$f"): missing 'Owner:'"
  echo "$head" | grep -qE '^EditPolicy:[[:space:]]*DO_NOT_EDIT_DIRECTLY' || fail "$(basename "$f"): missing 'EditPolicy: DO_NOT_EDIT_DIRECTLY ...' (script-first policy)"

  for h in \
    "## Formal Pitch" \
    "## Target Persona(s)" \
    "## Related Segment(s)" \
    "## Gain Boosters" \
    "## Pain Relievers" \
    "## Capabilities" \
    "## Notes"
  do
    grep -qF "$h" "$f" || fail "$(basename "$f"): missing section '$h'"
  done

  # Helper to extract lines between a heading and next '## ' heading
  extract_block() {
    local heading="$1"
    awk -v heading="$heading" '
      BEGIN { inside=0; }
      $0 == heading { inside=1; next; }
      inside && $0 ~ /^## / { exit; }
      inside { print; }
    ' "$f"
  }

  # Target personas: must be bullet lines with PER-#### (ignore V-SCRIPT blocks and blank lines)
  tp="$(extract_block "## Target Persona(s)")"
  if ! echo "$tp" | grep -qE '^[[:space:]]*-[[:space:]]*PER-[0-9]{4}[[:space:]]*$'; then
    warn "$(basename "$f"): no PER-#### entries found under '## Target Persona(s)' (ok for draft, but recommended)"
  fi

  rs="$(extract_block "## Related Segment(s)")"
  if ! echo "$rs" | grep -qE '^[[:space:]]*-[[:space:]]*SEG-[0-9]{4}[[:space:]]*$'; then
    warn "$(basename "$f"): no SEG-#### entries found under '## Related Segment(s)' (ok for draft, but recommended)"
  fi

  # Table checks
  gb="$(extract_block "## Gain Boosters")"
  echo "$gb" | grep -qE '[|][[:space:]]*BoosterID[[:space:]]*[|]' || fail "$(basename "$f"): Gain Boosters missing 'BoosterID' table header"
  echo "$gb" | grep -qF 'MappedGainIDs[]' || fail "$(basename "$f"): Gain Boosters missing 'MappedGainIDs[]' table header"

  pr="$(extract_block "## Pain Relievers")"
  echo "$pr" | grep -qE '[|][[:space:]]*RelieverID[[:space:]]*[|]' || fail "$(basename "$f"): Pain Relievers missing 'RelieverID' table header"
  echo "$pr" | grep -qF 'MappedPainIDs[]' || fail "$(basename "$f"): Pain Relievers missing 'MappedPainIDs[]' table header"

  cap="$(extract_block "## Capabilities")"
  echo "$cap" | grep -qE '[|][[:space:]]*CapabilityID[[:space:]]*[|]' || fail "$(basename "$f"): Capabilities missing 'CapabilityID' table header"
  echo "$cap" | grep -qE '[|][[:space:]]*CapabilityType[[:space:]]*[|]' || fail "$(basename "$f"): Capabilities missing 'CapabilityType' table header"

  # Validate rows: use awk table parsing by pipe.
  # Booster table: | BOOST-0001-PROP-0001 | ... | JTBD-GAIN-.... |
  echo "$gb" | awk -v prop="$prop_id" -v file="$(basename "$f")" '
    BEGIN { FS="|"; bad=0; }
    $0 ~ /^[|][[:space:]]*BOOST-[0-9]{4}-PROP-[0-9]{4}[[:space:]]*[|]/ {
      id=$2; mapped=$4;
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", id);
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", mapped);
      if (id !~ ("^BOOST-[0-9]{4}-" prop "$")) {
        print "WARN: " file ": invalid BoosterID for proposition: " id > "/dev/stderr"; bad=1;
      }
      if (mapped != "" && mapped != "<...>") {
        n=split(mapped, a, /,/);
        for (i=1; i<=n; i++) {
          x=a[i]; gsub(/^[[:space:]]+|[[:space:]]+$/, "", x);
          if (x !~ /^JTBD-GAIN-[0-9]{4}-PER-[0-9]{4}$/) {
            print "WARN: " file ": invalid MappedGainIDs[] item: " x > "/dev/stderr"; bad=1;
          }
        }
      }
      if (seen[id]++ > 0) { print "WARN: " file ": duplicate BoosterID: " id > "/dev/stderr"; bad=1; }
    }
    END { exit bad; }
  ' || fail "$(basename "$f"): Gain Boosters table has invalid rows"

  echo "$pr" | awk -v prop="$prop_id" -v file="$(basename "$f")" '
    BEGIN { FS="|"; bad=0; }
    $0 ~ /^[|][[:space:]]*REL-[0-9]{4}-PROP-[0-9]{4}[[:space:]]*[|]/ {
      id=$2; mapped=$4;
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", id);
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", mapped);
      if (id !~ ("^REL-[0-9]{4}-" prop "$")) {
        print "WARN: " file ": invalid RelieverID for proposition: " id > "/dev/stderr"; bad=1;
      }
      if (mapped != "" && mapped != "<...>") {
        n=split(mapped, a, /,/);
        for (i=1; i<=n; i++) {
          x=a[i]; gsub(/^[[:space:]]+|[[:space:]]+$/, "", x);
          if (x !~ /^JTBD-PAIN-[0-9]{4}-PER-[0-9]{4}$/) {
            print "WARN: " file ": invalid MappedPainIDs[] item: " x > "/dev/stderr"; bad=1;
          }
        }
      }
      if (seen[id]++ > 0) { print "WARN: " file ": duplicate RelieverID: " id > "/dev/stderr"; bad=1; }
    }
    END { exit bad; }
  ' || fail "$(basename "$f"): Pain Relievers table has invalid rows"

  echo "$cap" | awk -v prop="$prop_id" -v file="$(basename "$f")" '
    BEGIN { FS="|"; bad=0; }
    $0 ~ /^[|][[:space:]]*CAP-[0-9]{4}-PROP-[0-9]{4}[[:space:]]*[|]/ {
      id=$2; ctype=$3;
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", id);
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", ctype);
      if (id !~ ("^CAP-[0-9]{4}-" prop "$")) {
        print "WARN: " file ": invalid CapabilityID for proposition: " id > "/dev/stderr"; bad=1;
      }
      if (ctype !~ /^(feature|function|standard|experience)$/) {
        print "WARN: " file ": invalid CapabilityType: " ctype > "/dev/stderr"; bad=1;
      }
      if (seen[id]++ > 0) { print "WARN: " file ": duplicate CapabilityID: " id > "/dev/stderr"; bad=1; }
    }
    END { exit bad; }
  ' || fail "$(basename "$f"): Capabilities table has invalid rows"

  echo "OK: $f"
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" || -z "${1:-}" ]]; then
  usage
  exit 0
fi

if [[ "${1:-}" == "--all" ]]; then
  dir="$ROOT/virric/domains/product-marketing/docs/propositions"
  [[ -d "$dir" ]] || fail "Missing propositions dir: $dir"
  found=0
  while IFS= read -r -d '' f; do
    found=1
    validate_file "$f"
  done < <(find "$dir" -type f -name "PROP-*.md" -print0)
  if [[ "$found" -eq 0 ]]; then
    warn "No propositions found under $dir"
  fi
  exit 0
fi

target="$1"
if [[ "$target" != /* ]]; then
  target="$ROOT/$target"
fi
validate_file "$target"

