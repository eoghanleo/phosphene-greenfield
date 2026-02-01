#!/usr/bin/env bash
set -euo pipefail

# ideation-domain-done-score.sh
# Programmatic scoring for <ideation> two-mode artifacts.

# ----------------------------
# Shared libs (MUST)
# ----------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ds__find_repo_root_from_dir() {
  local dir="$1"
  while [[ "$dir" != "/" ]]; do
    if [[ -d "$dir/phosphene" && -f "$dir/phosphene/AGENTS.md" ]]; then
      echo "$dir"
      return 0
    fi
    dir="$(dirname "$dir")"
  done
  return 1
}

ROOT_FOR_LIB="$(ds__find_repo_root_from_dir "$SCRIPT_DIR")" || {
  echo "FAIL: Not in a PHOSPHENE project (cannot find ./phosphene at repo root from $SCRIPT_DIR)." >&2
  exit 2
}

LIB_DIR="$ROOT_FOR_LIB/phosphene/phosphene-core/lib"
# shellcheck source=/dev/null
source "$LIB_DIR/phosphene_env.sh"
# shellcheck source=/dev/null
source "$LIB_DIR/phosphene_done_score_metrics.sh"
phos_ds_env_defaults

usage() {
  cat <<'EOF'
Usage:
  ./.github/scripts/ideation-domain-done-score.sh [--docs-root <dir>] [--spark-root <dir>] [--file <path>] [--min-score <0..100>] [--quiet]
EOF
}

fail() { echo "FAIL: $*" >&2; exit 2; }

# ----------------------------
# 1) CLI + defaults
# ----------------------------
ROOT="$ROOT_FOR_LIB"
DOCS_ROOT_DEFAULT="$ROOT/phosphene/domains/ideation/output/ideas"
SPARK_ROOT_DEFAULT="$ROOT/phosphene/signals/sparks"

TARGET_PATH=""
DOCS_ROOT="$DOCS_ROOT_DEFAULT"
SPARK_ROOT="$SPARK_ROOT_DEFAULT"
FILE=""
MIN_SCORE="10"
QUIET=0
VOL_FULL_RATIO="1.00"
OUT_IN_RATIO_CAP="10.00"
PRIMARY_WORD_FLOOR="100"
PRIMARY_GATE_MULT="3"
PRIMARY_FULL_MULT="10"
CAND_GATE="12"
CAND_FULL="18"
SEC_TRACE_TARGET="3"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --docs-root) DOCS_ROOT="${2:-}"; shift 2 ;;
    --spark-root) SPARK_ROOT="${2:-}"; shift 2 ;;
    --file) FILE="${2:-}"; shift 2 ;;
    --min-score) MIN_SCORE="${2:-}"; shift 2 ;;
    --vol-full-ratio) VOL_FULL_RATIO="${2:-}"; shift 2 ;;
    --out-in-cap) OUT_IN_RATIO_CAP="${2:-}"; shift 2 ;;
    --quiet) QUIET=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *)
      if [[ -z "$TARGET_PATH" ]]; then
        TARGET_PATH="$1"
        shift
      else
        echo "Unknown arg: $1" >&2
        usage
        exit 2
      fi
      ;;
  esac
done

if ! phos_ds_assert_numeric_0_100 "$MIN_SCORE"; then
  fail "--min-score must be numeric (0..100)"
fi
if ! [[ "$VOL_FULL_RATIO" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
  fail "--vol-full-ratio must be numeric"
fi
if ! [[ "$OUT_IN_RATIO_CAP" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
  fail "--out-in-cap must be numeric"
fi

if [[ -n "${DOCS_ROOT:-}" && "$DOCS_ROOT" != /* ]]; then DOCS_ROOT="$ROOT/$DOCS_ROOT"; fi
if [[ -n "${SPARK_ROOT:-}" && "$SPARK_ROOT" != /* ]]; then SPARK_ROOT="$ROOT/$SPARK_ROOT"; fi
if [[ -n "${FILE:-}" && "$FILE" != /* ]]; then FILE="$ROOT/$FILE"; fi
if [[ -n "${TARGET_PATH:-}" && "$TARGET_PATH" != /* ]]; then TARGET_PATH="$ROOT/$TARGET_PATH"; fi

# ----------------------------
# 2) Discovery
# ----------------------------
if [[ -n "${FILE:-}" ]]; then
  [[ -f "$FILE" ]] || fail "Missing file: $FILE"
elif [[ -n "${TARGET_PATH:-}" ]]; then
  [[ -e "$TARGET_PATH" ]] || fail "Missing target path: $TARGET_PATH"
  if [[ -f "$TARGET_PATH" ]]; then
    FILE="$TARGET_PATH"
  fi
else
  [[ -d "$DOCS_ROOT" ]] || fail "Missing docs root dir: $DOCS_ROOT"
fi

OUTPUT_FILES=()
if [[ -n "${FILE:-}" ]]; then
  OUTPUT_FILES=("$FILE")
else
  while IFS= read -r f; do
    [[ -n "${f:-}" ]] || continue
    OUTPUT_FILES+=("$f")
  done < <(phos_ds_collect_files "$DOCS_ROOT" "IDEA-*.md")
fi

out_items="${#OUTPUT_FILES[@]}"
if [[ "$out_items" -eq 0 ]]; then
  fail "No IDEA artifacts found under: $DOCS_ROOT"
fi

# ----------------------------
# 3) Extraction -> canonical intermediates
# ----------------------------
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

CORPUS_TXT="$tmp/corpus_fragments.txt"
CORPUS_CLEAN_TXT="$tmp/corpus_clean.txt"
RINGS_TXT="$tmp/rings.txt"
AXES_TXT="$tmp/axes.txt"
INPUT_IDS_TXT="$tmp/input_ids.txt"
SECONDARY_PREFIXES_TXT="$tmp/secondary_prefixes.txt"
SECONDARY_IDS_TXT="$tmp/secondary_ids.txt"
IDEA_RAW_TXT="$tmp/idea_raw.txt"

: > "$CORPUS_TXT"
: > "$CORPUS_CLEAN_TXT"
: > "$RINGS_TXT"
: > "$AXES_TXT"
: > "$INPUT_IDS_TXT"
: > "$SECONDARY_PREFIXES_TXT"
: > "$SECONDARY_IDS_TXT"
: > "$IDEA_RAW_TXT"

gate_ok=1
gate_notes=()

div_total=0
stress_total=0
nrq_total=0
spark_count=0
in_words_primary=0
in_words_secondary=0

read_header_value() {
  local file="$1"
  local key="$2"
  local line
  while IFS= read -r line; do
    [[ -n "${line:-}" ]] || break
    if [[ "$line" =~ ^${key}: ]]; then
      echo "$line" | sed -E "s/^${key}:[[:space:]]*//"
      return 0
    fi
  done < "$file"
  return 1
}

spark_id_from_issue() {
  local issue="$1"
  printf "SPARK-%06d\n" "$issue"
}

append_section_safe() {
  local file="$1"
  local section="$2"
  phos_ds_append_section_text "$file" "$section" >> "$CORPUS_TXT" || true
}

for f in "${OUTPUT_FILES[@]}"; do
  [[ -f "$f" ]] || continue
  cat "$f" >> "$IDEA_RAW_TXT"
  printf "\n" >> "$IDEA_RAW_TXT"

  issue_number="$(read_header_value "$f" "IssueNumber" || true)"
  if ! [[ "${issue_number:-}" =~ ^[0-9]+$ ]]; then
    gate_ok=0
    gate_notes+=("Missing or invalid IssueNumber in $(basename "$f")")
    continue
  fi

  spark_id="$(spark_id_from_issue "$issue_number")"
  spark_path="$SPARK_ROOT/${spark_id}.md"
  if [[ ! -f "$spark_path" ]]; then
    gate_ok=0
    gate_notes+=("Missing SPARK snapshot for issue ${issue_number} (${spark_id}.md)")
  else
    spark_count=$((spark_count + 1))
    spark_words="$(phos_ds_section_words "$spark_path" "## Issue snapshot" "$PRIMARY_WORD_FLOOR")"
    if [[ "${spark_words:-0}" -eq 0 ]]; then
      gate_ok=0
      gate_notes+=("SPARK snapshot is empty for issue ${issue_number}")
    fi
    in_words_primary=$((in_words_primary + spark_words))

    input_ids_raw="$(read_header_value "$spark_path" "InputWorkIDs" || true)"
    if [[ -n "${input_ids_raw:-}" ]]; then
      printf "%s\n" "$input_ids_raw" \
        | tr ',' '\n' \
        | sed -E 's/^[[:space:]]+|[[:space:]]+$//g' \
        | grep -E '^[A-Z]{2,}-[0-9]{3,4}$' \
        | sort -u >> "$INPUT_IDS_TXT" || true
    fi
  fi

  append_section_safe "$f" "## Problem / opportunity"
  append_section_safe "$f" "## Target user hypotheses"
  append_section_safe "$f" "## Next research questions"
  append_section_safe "$f" "## Notes"

  nrq_count="$(awk -v start="## Next research questions" '
    BEGIN{ inside=0; c=0; }
    $0==start { inside=1; next }
    inside && $0 ~ /^## / { exit }
    inside && $0 ~ /^-[[:space:]]+/ { c++; }
    END{ print c+0; }
  ' "$f")"
  nrq_total=$((nrq_total + nrq_count))

  div_ids_local="$tmp/div_ids_$(basename "$f").txt"
  stress_ids_local="$tmp/stress_ids_$(basename "$f").txt"
  : > "$div_ids_local"
  : > "$stress_ids_local"

  div_count="$(awk -F'|' -v start="## Divergence enumeration (pure)" -v ids="$div_ids_local" -v rings="$RINGS_TXT" -v axes="$AXES_TXT" -v corpus="$CORPUS_TXT" '
    function trim(s){ gsub(/^[[:space:]]+|[[:space:]]+$/, "", s); return s; }
    BEGIN{ inside=0; count=0; }
    $0==start { inside=1; next }
    inside && $0 ~ /^## / { exit }
    !inside { next }
    $0 !~ /^\|/ { next }
    {
      id=trim($2); ring=tolower(trim($3)); axes_raw=trim($4); one=trim($5);
      if (id=="" || id=="CandID" || id ~ /^-+$/) next;
      if (id !~ /^CAND-[0-9]{2,3}$/) { print "Invalid CandID in divergence table: " id > "/dev/stderr"; exit 2 }
      if (ring !~ /^(adjacent|orthogonal|extrapolatory)$/) { print "Invalid Ring in divergence table: " ring > "/dev/stderr"; exit 2 }
      if (axes_raw=="" || axes_raw ~ /^<.*>$/) { print "Missing Axes for " id > "/dev/stderr"; exit 2 }
      if (one=="" || one ~ /^<.*>$/) { print "Missing OneLiner for " id > "/dev/stderr"; exit 2 }
      print id >> ids;
      print ring >> rings;
      n=split(axes_raw, arr, /[,;]+/);
      for (i=1;i<=n;i++){ a=trim(arr[i]); if (a!="") print tolower(a) >> axes; }
      print one >> corpus;
      count++;
    }
    END{ print count+0; }
  ' "$f")" || div_count=0

  if [[ "$div_count" -lt "$CAND_GATE" ]]; then
    gate_ok=0
    gate_notes+=("Need at least ${CAND_GATE} divergence candidates in $(basename "$f")")
  fi
  div_total=$((div_total + div_count))

  stress_count="$(awk -F'|' -v start="## Stress-test enumeration (all candidates)" -v ids="$stress_ids_local" -v corpus="$CORPUS_TXT" '
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
      print id >> ids;
      print failm >> corpus;
      print core >> corpus;
      print diff >> corpus;
      count++;
    }
    END{ print count+0; }
  ' "$f")" || stress_count=0

  stress_total=$((stress_total + stress_count))

  if ! diff -u <(sort -u "$div_ids_local") <(sort -u "$stress_ids_local") >/dev/null 2>&1; then
    gate_ok=0
    gate_notes+=("CandID mismatch between divergence and stress-test tables in $(basename "$f")")
  fi

  rev_count="$(awk -v start="## Revision passes" '
    BEGIN{ inside=0; c=0; }
    $0==start { inside=1; next }
    inside && $0 ~ /^## / { exit }
    inside && $0 ~ /^-[[:space:]]+/ { c++; }
    END{ print c+0; }
  ' "$f")"
  if [[ "$rev_count" -lt 2 ]]; then
    gate_ok=0
    gate_notes+=("Revision passes must include at least 2 bullet items in $(basename "$f")")
  fi
done

sort -u "$INPUT_IDS_TXT" -o "$INPUT_IDS_TXT" || true

ref_total=0
ref_hits=0
sec_ref_ids_total=0
sec_ref_ids_hit=0
if [[ -s "$INPUT_IDS_TXT" ]]; then
  ref_total="$(wc -l < "$INPUT_IDS_TXT" | awk '{print $1}')"
  while IFS= read -r id; do
    [[ -n "${id:-}" ]] || continue
    if grep -qF "$id" "$IDEA_RAW_TXT"; then
      ref_hits=$((ref_hits + 1))
    fi
    rel_path="$(./phosphene/phosphene-core/bin/phosphene id where "$id" 2>/dev/null | head -n 1 | awk -F'\t' '{print $3}' || true)"
    if [[ -z "${rel_path:-}" ]]; then
      gate_ok=0
      gate_notes+=("InputWorkID not found in id registry: $id")
      continue
    fi
    base_prefix="$(dirname "$rel_path")"
    if [[ -n "${base_prefix:-}" ]]; then
      echo "$base_prefix" >> "$SECONDARY_PREFIXES_TXT"
    fi
    abs_path="$ROOT/$rel_path"
    if [[ -d "$abs_path" ]]; then
      w="$(phos_ds_clean_markdown_tree_words "$abs_path")"
      in_words_secondary=$((in_words_secondary + w))
    elif [[ -f "$abs_path" ]]; then
      w="$(cat "$abs_path" 2>/dev/null \
        | phos_ds_strip_codeblocks_and_tables \
        | phos_ds_clean_text_common \
        | wc -w | awk '{print $1}')"
      in_words_secondary=$((in_words_secondary + w))
    else
      gate_ok=0
      gate_notes+=("InputWorkID path missing: $id ($rel_path)")
    fi
  done < "$INPUT_IDS_TXT"
fi

in_items_primary="$spark_count"
in_items_secondary="$ref_total"
in_words="$((in_words_primary + in_words_secondary))"

if [[ -s "$SECONDARY_PREFIXES_TXT" ]]; then
  sort -u "$SECONDARY_PREFIXES_TXT" -o "$SECONDARY_PREFIXES_TXT" || true
  phos_ds_index_ids_for_prefixes "$ROOT/phosphene/id_index.tsv" "$SECONDARY_PREFIXES_TXT" \
    | sort -u > "$SECONDARY_IDS_TXT" || true
  if [[ -s "$INPUT_IDS_TXT" ]]; then
    grep -v -F -f "$INPUT_IDS_TXT" "$SECONDARY_IDS_TXT" > "$SECONDARY_IDS_TXT.filtered" || true
    mv "$SECONDARY_IDS_TXT.filtered" "$SECONDARY_IDS_TXT"
  fi
  sec_ref_ids_total="$(wc -l < "$SECONDARY_IDS_TXT" | awk '{print $1}')"
  sec_ref_ids_hit="$(phos_ds_count_unique_ids_in_text "$SECONDARY_IDS_TXT" "$IDEA_RAW_TXT")"
fi

# ----------------------------
# 4) Cleaning
# ----------------------------
phos_ds_clean_text_common < "$CORPUS_TXT" \
  | phos_ds_filter_token_dump > "$CORPUS_CLEAN_TXT"

# ----------------------------
# 5) Metrics
# ----------------------------
out_words="$(wc -w < "$CORPUS_CLEAN_TXT" | awk '{print $1}')"
out_lines="$(wc -l < "$CORPUS_CLEAN_TXT" | awk '{print $1}')"
out_in_primary_ratio="$(phos_ds_ratio_clamped "$out_words" "$in_words_primary" "$OUT_IN_RATIO_CAP")"
out_in_ratio="$out_in_primary_ratio"

div_stats="$(phos_ds_entropy_stats "$CORPUS_CLEAN_TXT")"
read -r out_tokens unique_words H ent_norm uniq_ratio <<< "$div_stats"

frag_stats="$(phos_ds_fragment_stats "$CORPUS_CLEAN_TXT")"
read -r frag_count frag_avg_words two_sent_ratio <<< "$frag_stats"

uniq_rings="$(sort -u "$RINGS_TXT" | grep -c . || true)"
axis_unique="$(sort -u "$AXES_TXT" | grep -c . || true)"

ref_cov="$(phos_ds_ratio_clamped "$ref_hits" "$ref_total" 1)"
internal_cov="0"
cat_cov="0"
row_fill="0"

# ----------------------------
# 6) Normalization
# ----------------------------
CAND_TARGET="$CAND_FULL"
AXES_TARGET="6"
NRQ_TARGET="3"

s_cand="$(phos_ds_score_linear "$div_total" 0 "$CAND_TARGET")"
ring_cov="$(awk -v n="$uniq_rings" 'BEGIN{ if (n>3) n=3; if (n<0) n=0; printf "%.4f\n", n/3 }')"
s_ring="$(awk -v r="$ring_cov" 'BEGIN{ printf "%.2f\n", r*100 }')"
s_vol_text="$(phos_ds_score_linear "$out_in_primary_ratio" 0 "$PRIMARY_FULL_MULT")"
score_vol="$(awk -v a="$s_cand" -v b="$s_ring" -v c="$s_vol_text" 'BEGIN{ printf "%.2f\n", (a+b+c)/3 }')"

axis_cov="$(awk -v n="$axis_unique" -v t="$AXES_TARGET" 'BEGIN{ if (t<=0) { print 0; exit } r=n/t; if (r>1) r=1; if (r<0) r=0; printf "%.4f\n", r }')"
s_axis="$(awk -v r="$axis_cov" 'BEGIN{ printf "%.2f\n", r*100 }')"
s_ent="$(phos_ds_score_linear "$ent_norm" 0.20 0.90)"
s_uniq="$(phos_ds_score_linear "$uniq_ratio" 0.05 0.40)"
score_div="$(awk -v a="$s_axis" -v b="$s_ent" -v c="$s_uniq" 'BEGIN{ printf "%.2f\n", (a+b+c)/3 }')"

stress_ratio="$(phos_ds_ratio_clamped "$stress_total" "$div_total" 1)"
s_stress="$(awk -v r="$stress_ratio" 'BEGIN{ printf "%.2f\n", r*100 }')"
s_frag="$(phos_ds_score_linear "$frag_avg_words" 6 20)"
s_two="$(phos_ds_score_linear "$two_sent_ratio" 0.20 0.80)"
score_dep="$(awk -v a="$s_stress" -v b="$s_frag" -v c="$s_two" 'BEGIN{ printf "%.2f\n", (a+b+c)/3 }')"

s_ref="$(awk -v r="$ref_cov" 'BEGIN{ printf "%.2f\n", r*100 }')"
s_nrq="$(phos_ds_score_linear "$nrq_total" 0 "$NRQ_TARGET")"
if [[ "$sec_ref_ids_total" -gt 0 ]]; then
  s_sec_trace="$(phos_ds_score_linear "$sec_ref_ids_hit" 0 "$SEC_TRACE_TARGET")"
else
  s_sec_trace="100"
fi
score_con="$(awk -v a="$s_ref" -v b="$s_sec_trace" -v c="$s_nrq" 'BEGIN{ printf "%.2f\n", (a+b+c)/3 }')"

min_out_words="$(awk -v p="$in_words_primary" -v m="$PRIMARY_GATE_MULT" 'BEGIN{ printf "%.0f\n", p*m }')"
if [[ "$out_words" -lt "$min_out_words" ]]; then
  gate_ok=0
  gate_notes+=("Output words below minimum (${out_words} < ${min_out_words}) for primary input volume gate")
fi

# ----------------------------
# 7) Scoring + levelling
# ----------------------------
box="$(phos_ds_score_box_equal_quarters "$score_vol" "$score_div" "$score_dep" "$score_con")"
read -r overall score_vol score_div score_dep score_con <<< "$box"

# ----------------------------
# 8) Gates
# ----------------------------
result="PASS"
if [[ "$gate_ok" -ne 1 ]]; then
  result="FAIL"
fi
if awk -v s="$overall" -v m="$MIN_SCORE" 'BEGIN{ exit (s+0 >= m+0) ? 0 : 1 }'; then
  : # ok
else
  result="FAIL"
fi

# ----------------------------
# 9) Reporting
# ----------------------------
if [[ "$QUIET" -ne 1 ]]; then
  echo "PHOSPHENE — Done Score  <ideation>"
  echo "============================================================"
  echo "Result:    ${result}   Overall: ${overall}/100   Threshold: ${MIN_SCORE}"
  echo ""
  echo "Inputs:"
  echo "  - spark files: ${spark_count}"
  echo "  - input IDs: ${ref_total}"
  echo "  - primary words (floor ${PRIMARY_WORD_FLOOR}): ${in_words_primary}"
  echo "  - secondary words: ${in_words_secondary}"
  echo "  - input words total: ${in_words}"
  echo ""
  echo "Outputs:"
  echo "  - idea files: ${out_items}"
  echo "  - candidates: ${div_total}"
  echo "  - stress-tested: ${stress_total}"
  echo "  - output words: ${out_words}"
  echo "  - out/primary ratio (capped): ${out_in_primary_ratio}"
  echo ""
  echo "Subscores:"
  echo "  - volume: ${score_vol}"
  echo "  - diversity: ${score_div}"
  echo "  - depth: ${score_dep}"
  echo "  - connectivity: ${score_con}"
  echo ""
  echo "Key metrics:"
  echo "  - rings covered: ${uniq_rings}/3"
  echo "  - axes covered: ${axis_unique}/${AXES_TARGET}"
  echo "  - ent_norm: ${ent_norm}"
  echo "  - uniq_ratio: ${uniq_ratio}"
  echo "  - frag_avg_words: ${frag_avg_words}"
  echo "  - two_sent_ratio: ${two_sent_ratio}"
  echo "  - ref_cov: ${ref_cov}"
  echo "  - secondary trace: ${sec_ref_ids_hit}/${sec_ref_ids_total}"
  echo "  - next_research_questions: ${nrq_total}"
  if [[ "${#gate_notes[@]}" -gt 0 ]]; then
    echo ""
    echo "Gates:"
    for note in "${gate_notes[@]}"; do
      echo "  - ${note}"
    done
  fi
fi

awk -v s="$overall" -v m="$MIN_SCORE" -v g="$gate_ok" 'BEGIN{ exit (g==1 && s+0 >= m+0) ? 0 : 1 }'
