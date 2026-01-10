#!/usr/bin/env bash
set -euo pipefail

# research_id_registry.sh
# Builds and queries a global ID index for VIRRIC artifacts (authoritative definitions only).
#
# Scope:
# - Scans virric/domains/**/docs/** (excludes templates) for authoritative ID definitions:
#   - RA IDs: 00-coversheet.md (ID: RA-###)
#   - Pitch IDs: files named PITCH-*.md (ID: PITCH-#### recommended)
#   - Evidence IDs: 50-evidence-bank.md table first column (E-####)
#   - RefSol IDs: 10-reference-solutions.md table first column (RS-####)
#   - Segment IDs: 40-hypotheses.md segment table first column (SEG-####) (research hypotheses; stable IDs)
#   - Candidate Persona IDs: files named CPE-*.md (ID: CPE-####) (research → marketing handoff candidates)
#   - Persona IDs: files named PER-*.md (ID: PER-####) (canonical personas live in <product-marketing>)
#   - Proposition IDs: files named PROP-*.md (ID: PROP-####) (canonical propositions live in <product-marketing>)
#
# This avoids false “duplicates” from assembled views (RA-###.md) and raw dumps.
#
# Commands:
#   build                Build/refresh index TSV (default)
#   validate             Fail if duplicate authoritative definitions exist
#   next --type <t>      Print next legal ID for type (ra|pitch|evidence|refsol|segment|cpe|persona|proposition)
#   where <ID>           Print authoritative path(s) for an ID (any type)
#
# Output:
#   virric/id_index.tsv (repo-wide global index)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../virric-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/virric_env.sh"

ROOT="$(virric_find_project_root)"
INDEX_TSV="$ROOT/virric/id_index.tsv"

usage() {
  cat <<'EOF'
Usage:
  ./virric/domains/research/scripts/research_id_registry.sh [build|validate|where <ID>|next --type <type>]

Types:
  ra | pitch | evidence | refsol | segment | cpe | persona | proposition
EOF
}

build_index() {
  mkdir -p "$(dirname "$INDEX_TSV")"

  tmp="$(mktemp)"
  trap 'rm -f "$tmp"' RETURN

  # Scan docs only (authoritative artifacts), across all domains.
  # IMPORTANT: index should reflect the repo's official state, so we scan only *tracked* files.
  while IFS= read -r -d '' rel; do
    case "$rel" in
      virric/domains/*/docs/*.md|virric/domains/*/docs/*/*.md|virric/domains/*/docs/*/*/*.md|virric/domains/*/docs/*/*/*/*.md)
        ;;
      *)
        continue
        ;;
    esac
    f="$ROOT/$rel"
    [[ -f "$f" ]] || continue

    case "$(basename "$f")" in
      00-coversheet.md)
        ra_id="$(grep -E '^ID:[[:space:]]*RA-[0-9]{3}[[:space:]]*$' "$f" | head -n 1 | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"
        if [[ -n "${ra_id:-}" ]]; then
          printf "ra\t%s\t%s\n" "$ra_id" "$rel" >> "$tmp"
        fi
        ;;
      10-reference-solutions.md)
        # Table rows: | RS-0001 | ...
        awk -v path="$rel" '
          BEGIN { FS="|"; }
          $0 ~ /^[|][[:space:]]*RS-[0-9]{4}[[:space:]]*[|]/ {
            gsub(/^[[:space:]]+|[[:space:]]+$/, "", $2);
            print "refsol\t" $2 "\t" path;
          }
        ' "$f" >> "$tmp"
        ;;
      50-evidence-bank.md)
        # Table rows: | E-0001 | ...
        awk -v path="$rel" '
          BEGIN { FS="|"; }
          $0 ~ /^[|][[:space:]]*E-[0-9]{4}[[:space:]]*[|]/ {
            gsub(/^[[:space:]]+|[[:space:]]+$/, "", $2);
            print "evidence\t" $2 "\t" path;
          }
        ' "$f" >> "$tmp"
        ;;
      40-hypotheses.md)
        # Segment rows: | SEG-0001 | ...
        awk -v path="$rel" '
          BEGIN { FS="|"; }
          $0 ~ /^[|][[:space:]]*SEG-[0-9]{4}[[:space:]]*[|]/ {
            gsub(/^[[:space:]]+|[[:space:]]+$/, "", $2);
            print "segment\t" $2 "\t" path;
          }
        ' "$f" >> "$tmp"
        ;;
      CPE-*.md)
        # Candidate personas: prefer ID line; fall back to filename.
        cpe_id="$(grep -E '^ID:[[:space:]]*CPE-[0-9]{4}[[:space:]]*$' "$f" | head -n 1 | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"
        if [[ -z "${cpe_id:-}" ]]; then
          base="$(basename "$f" .md)"
          if [[ "$base" =~ ^(CPE-[0-9]{4}) ]]; then cpe_id="${BASH_REMATCH[1]}"; fi
        fi
        if [[ -n "${cpe_id:-}" ]]; then
          printf "candidate_persona\t%s\t%s\n" "$cpe_id" "$rel" >> "$tmp"
        fi
        ;;
      PER-*.md)
        # Canonical personas (product-marketing): prefer ID line; fall back to filename.
        per_id="$(grep -E '^ID:[[:space:]]*PER-[0-9]{4}[[:space:]]*$' "$f" | head -n 1 | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"
        if [[ -z "${per_id:-}" ]]; then
          base="$(basename "$f" .md)"
          if [[ "$base" =~ ^PER-[0-9]{4}$ ]]; then per_id="$base"; fi
        fi
        if [[ -n "${per_id:-}" ]]; then
          printf "persona\t%s\t%s\n" "$per_id" "$rel" >> "$tmp"
        fi
        ;;
      PROP-*.md)
        # Canonical propositions (product-marketing): prefer ID line; fall back to filename.
        prop_id="$(grep -E '^ID:[[:space:]]*PROP-[0-9]{4}[[:space:]]*$' "$f" | head -n 1 | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"
        if [[ -z "${prop_id:-}" ]]; then
          base="$(basename "$f" .md)"
          if [[ "$base" =~ ^PROP-[0-9]{4}$ ]]; then prop_id="$base"; fi
        fi
        if [[ -n "${prop_id:-}" ]]; then
          printf "proposition\t%s\t%s\n" "$prop_id" "$rel" >> "$tmp"
        fi
        ;;
      PITCH-*.md)
        # Prefer ID line; fall back to filename.
        pid="$(grep -E '^ID:[[:space:]]*PITCH-[0-9]{4}[[:space:]]*$' "$f" | head -n 1 | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"
        if [[ -z "${pid:-}" ]]; then
          base="$(basename "$f" .md)"
          if [[ "$base" =~ ^PITCH-[0-9]{4}$ ]]; then pid="$base"; fi
        fi
        if [[ -n "${pid:-}" ]]; then
          printf "pitch\t%s\t%s\n" "$pid" "$rel" >> "$tmp"
        fi
        ;;
      *)
        ;;
    esac
  done < <(git -C "$ROOT" ls-files -z -- "virric/domains")

  # Sort for stable diff
  sort -t $'\t' -k1,1 -k2,2 -k3,3 "$tmp" > "$INDEX_TSV"
  echo "Wrote: $INDEX_TSV" >&2
}

ensure_index() {
  if [[ ! -f "$INDEX_TSV" ]]; then
    build_index
  fi
}

validate_index() {
  # Always refresh before validating to prevent stale allocation/lookup.
  build_index
  # Duplicate authoritative definitions: same (type, id) defined in multiple distinct files.
  dups="$(awk -F'\t' '
    { key=$1 "\t" $2; count[key]++; files[key]=files[key] "\n  - " $3 }
    END {
      for (k in count) {
        if (count[k] > 1) {
          print "DUPLICATE: " k files[k];
          bad=1;
        }
      }
      exit bad;
    }
  ' "$INDEX_TSV")" || true

  if [[ -n "$dups" ]]; then
    echo "$dups" >&2
    echo "FAIL: duplicate authoritative ID definitions found." >&2
    exit 1
  fi
  echo "OK: no duplicate authoritative ID definitions"
}

next_id() {
  local t="$1"
  # Always refresh before allocating to ensure newly created/untracked files are accounted for.
  build_index

  case "$t" in
    ra)
      max="$(awk -F'\t' '$1=="ra"{ sub(/^RA-/, "", $2); if ($2+0>m) m=$2+0 } END{ print m+0 }' "$INDEX_TSV")"
      next=$((max + 1))
      printf "RA-%03d\n" "$next"
      ;;
    pitch)
      max="$(awk -F'\t' '$1=="pitch"{ sub(/^PITCH-/, "", $2); if ($2+0>m) m=$2+0 } END{ print m+0 }' "$INDEX_TSV")"
      next=$((max + 1))
      printf "PITCH-%04d\n" "$next"
      ;;
    evidence)
      max="$(awk -F'\t' '$1=="evidence"{ sub(/^E-/, "", $2); if ($2+0>m) m=$2+0 } END{ print m+0 }' "$INDEX_TSV")"
      next=$((max + 1))
      printf "E-%04d\n" "$next"
      ;;
    refsol)
      max="$(awk -F'\t' '$1=="refsol"{ sub(/^RS-/, "", $2); if ($2+0>m) m=$2+0 } END{ print m+0 }' "$INDEX_TSV")"
      next=$((max + 1))
      printf "RS-%04d\n" "$next"
      ;;
    segment)
      max="$(awk -F'\t' '$1=="segment"{ sub(/^SEG-/, "", $2); if ($2+0>m) m=$2+0 } END{ print m+0 }' "$INDEX_TSV")"
      next=$((max + 1))
      printf "SEG-%04d\n" "$next"
      ;;
    cpe|candidate_persona)
      max="$(awk -F'\t' '$1=="candidate_persona"{ sub(/^CPE-/, "", $2); if ($2+0>m) m=$2+0 } END{ print m+0 }' "$INDEX_TSV")"
      next=$((max + 1))
      printf "CPE-%04d\n" "$next"
      ;;
    persona)
      max="$(awk -F'\t' '$1=="persona"{ sub(/^PER-/, "", $2); if ($2+0>m) m=$2+0 } END{ print m+0 }' "$INDEX_TSV")"
      next=$((max + 1))
      printf "PER-%04d\n" "$next"
      ;;
    proposition)
      max="$(awk -F'\t' '$1=="proposition"{ sub(/^PROP-/, "", $2); if ($2+0>m) m=$2+0 } END{ print m+0 }' "$INDEX_TSV")"
      next=$((max + 1))
      printf "PROP-%04d\n" "$next"
      ;;
    *)
      echo "Error: unknown type: $t" >&2
      exit 2
      ;;
  esac
}

where_id() {
  local id="$1"
  build_index
  awk -F'\t' -v q="$id" '$2==q { print $1 "\t" $2 "\t" $3 }' "$INDEX_TSV"
}

CMD="${1:-build}"
shift || true

case "$CMD" in
  build) build_index ;;
  validate) validate_index ;;
  where)
    q="${1:-}"
    [[ -n "$q" ]] || { echo "Error: missing ID" >&2; exit 2; }
    where_id "$q"
    ;;
  next)
    t=""
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --type) t="${2:-}"; shift 2 ;;
        -h|--help) usage; exit 0 ;;
        *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
      esac
    done
    [[ -n "$t" ]] || { echo "Error: --type is required" >&2; exit 2; }
    next_id "$t"
    ;;
  -h|--help) usage ;;
  *) echo "Unknown command: $CMD" >&2; usage; exit 2 ;;
esac

