#!/usr/bin/env bash
set -euo pipefail

# tests/lib/coverage_report.sh
# Aggregates raw line-hit logs produced by tests/lib/coverage_env.sh into a report.
#
# Inputs (env):
#   PHOSPHENE_REPO_ROOT (required)
#   PHOS_COVERAGE_DIR   (required)  - directory containing hits.*.tsv
#   PHOS_COVERAGE_OUT   (optional)  - output directory (default: <tests>/.coverage)
#
# Outputs:
#   - report.tsv : per-file totals/hits/percent
#   - summary.txt: human summary

fail() { echo "FAIL: $*" >&2; exit 2; }

ROOT="${PHOSPHENE_REPO_ROOT:-}"
RAW_DIR="${PHOS_COVERAGE_DIR:-}"
[[ -n "$ROOT" ]] || fail "PHOSPHENE_REPO_ROOT is required"
[[ -n "$RAW_DIR" ]] || fail "PHOS_COVERAGE_DIR is required"
[[ -d "$RAW_DIR" ]] || fail "missing raw coverage dir: $RAW_DIR"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TESTS_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
OUT_DIR="${PHOS_COVERAGE_OUT:-$TESTS_DIR/.coverage}"

mkdir -p "$OUT_DIR"

HITS_ALL="$OUT_DIR/hits_all.tsv"
REPORT_TSV="$OUT_DIR/report.tsv"
SUMMARY_TXT="$OUT_DIR/summary.txt"

# Collect hits (file\tline). Some runs may have zero files if coverage was misconfigured.
cat "$RAW_DIR"/hits.*.tsv 2>/dev/null \
  | awk -F'\t' 'NF>=2 {print $1 "\t" $2}' \
  | LC_ALL=C sort -u > "$HITS_ALL" || true

if [[ ! -s "$HITS_ALL" ]]; then
  fail "no coverage hits found (is tests/run.sh --coverage setting BASH_ENV + PHOS_COVERAGE_ENABLED?)"
fi

# Decide which files are in-scope for coverage.
# - all *.sh under phosphene/
# - plus key bash entrypoints without .sh (currently: phosphene/phosphene-core/bin/phosphene)
TARGETS_FILE="$OUT_DIR/targets.txt"
{
  find "$ROOT/phosphene" -type f -name "*.sh" 2>/dev/null | LC_ALL=C sort
  if [[ -f "$ROOT/phosphene/phosphene-core/bin/phosphene" ]]; then
    echo "$ROOT/phosphene/phosphene-core/bin/phosphene"
  fi
} | awk 'NF{print}' | LC_ALL=C sort -u > "$TARGETS_FILE"

count_executable_lines() {
  # Approximate executable line count:
  # - ignore blank lines
  # - ignore comment-only lines (leading ws + #)
  # - ignore shebang
  local f="$1"
  awk '
    function ltrim(s){ sub(/^[[:space:]]+/, "", s); return s; }
    {
      line=$0;
      t=ltrim(line);
      if (t=="") next;
      if (t ~ /^#!/) next;
      if (t ~ /^#/) next;
      c++;
    }
    END{ print c+0 }
  ' "$f"
}

# Build report header.
printf "file\texecutable_lines\thit_lines\tpercent\n" > "$REPORT_TSV"

overall_exec=0
overall_hit=0

while IFS= read -r f; do
  [[ -n "${f:-}" ]] || continue
  [[ -f "$f" ]] || continue

  exec_lines="$(count_executable_lines "$f")"

  # Hits: any unique hit line for this file.
  # Note: trap records pre-exec line numbers; denominator is "executable lines" heuristic.
  hit_lines="$(awk -F'\t' -v file="$f" '$1==file {c++} END{print c+0}' "$HITS_ALL")"

  percent="$(awk -v h="$hit_lines" -v e="$exec_lines" 'BEGIN{ if (e<=0) printf "0.00"; else printf "%.2f", (100.0*h/e) }')"

  printf "%s\t%d\t%d\t%s\n" "${f#"$ROOT/"}" "$exec_lines" "$hit_lines" "$percent" >> "$REPORT_TSV"

  overall_exec=$((overall_exec + exec_lines))
  overall_hit=$((overall_hit + hit_lines))
done < "$TARGETS_FILE"

overall_percent="$(awk -v h="$overall_hit" -v e="$overall_exec" 'BEGIN{ if (e<=0) printf "0.00"; else printf "%.2f", (100.0*h/e) }')"

{
  echo "PHOSPHENE — bash line-hit coverage"
  echo "============================================================"
  echo "Targets: $(wc -l < "$TARGETS_FILE" | awk '{print $1}') files"
  echo "Hits:    $(wc -l < "$HITS_ALL" | awk '{print $1}') unique (file,line) pairs"
  echo ""
  echo "Overall (heuristic): ${overall_hit}/${overall_exec} = ${overall_percent}%"
  echo ""
  echo "Report:  ${REPORT_TSV}"
  echo "Raw:     ${RAW_DIR}"
} > "$SUMMARY_TXT"

cat "$SUMMARY_TXT"

