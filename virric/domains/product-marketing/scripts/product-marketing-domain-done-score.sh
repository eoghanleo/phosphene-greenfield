#!/usr/bin/env bash
set -euo pipefail

# product-marketing-domain-done-score.sh
# Programmatic scoring (no generation) for <product-marketing> value-space mining richness.
#
# Goals:
# - Force recursive exploration by making "minimum-fill" patterns score poorly.
# - Reward breadth + depth + interconnection (overlap) across personas <-> propositions.
# - Stay bash-native (bash + awk + sed/grep/wc + gzip if available).
#
# Usage:
#   ./virric/domains/product-marketing/scripts/product-marketing-domain-done-score.sh
#   ./virric/domains/product-marketing/scripts/product-marketing-domain-done-score.sh --min-score 80
#   ./virric/domains/product-marketing/scripts/product-marketing-domain-done-score.sh --docs-root virric/domains/product-marketing/docs
#
# Exit codes:
#   0 = score >= min-score
#   1 = score < min-score
#   2 = usage / configuration error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../../virric-core/lib" && pwd)"
# shellcheck source=/dev/null
source "$LIB_DIR/virric_env.sh"

usage() {
  cat <<'EOF'
Usage:
  ./virric/domains/product-marketing/scripts/product-marketing-domain-done-score.sh [--docs-root <dir>] [--min-score <0..100>] [--quiet]

Notes:
  - This script is programmatic only (it does not generate content).
  - It scores breadth + depth + interconnection across PER/PROP artifacts.
EOF
}

fail() { echo "FAIL: $*" >&2; exit 2; }

ROOT="$(virric_find_project_root)"
DOCS_ROOT="$ROOT/virric/domains/product-marketing/docs"
MIN_SCORE="80"
QUIET=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --docs-root) DOCS_ROOT="${2:-}"; shift 2 ;;
    --min-score) MIN_SCORE="${2:-}"; shift 2 ;;
    --quiet) QUIET=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

if [[ "$DOCS_ROOT" != /* ]]; then DOCS_ROOT="$ROOT/$DOCS_ROOT"; fi
[[ -d "$DOCS_ROOT" ]] || fail "Missing docs root dir: $DOCS_ROOT"

if ! [[ "$MIN_SCORE" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
  fail "--min-score must be numeric (0..100)"
fi

PERSONAS_DIR="$DOCS_ROOT/personas"
PROPS_DIR="$DOCS_ROOT/propositions"
[[ -d "$PERSONAS_DIR" ]] || fail "Missing personas dir: $PERSONAS_DIR"
[[ -d "$PROPS_DIR" ]] || fail "Missing propositions dir: $PROPS_DIR"

# Collect files (stable ordering, bash 3.2 friendly)
shopt -s nullglob
PERSONA_FILES=( "$PERSONAS_DIR"/PER-*.md )
PROP_FILES=( "$PROPS_DIR"/PROP-*.md )
shopt -u nullglob

N_PER="${#PERSONA_FILES[@]}"
N_PROP="${#PROP_FILES[@]}"

if [[ "$N_PER" -eq 0 && "$N_PROP" -eq 0 ]]; then
  fail "No PER/PROP artifacts found under: $DOCS_ROOT"
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
PERSONAS_TSV="$tmp/personas.tsv"
PROPS_TSV="$tmp/props.tsv"
EDGES_TSV="$tmp/edges.tsv"   # prop_id<TAB>per_id

: > "$PERSONAS_TSV"
: > "$PROPS_TSV"
: > "$EDGES_TSV"

sum_words=0
sum_chars=0
placeholder_notes=0
placeholder_any=0

sum_boosters=0
sum_relievers=0
sum_caps=0
sum_mapped_gains_items=0
sum_mapped_gains_rows=0
sum_mapped_pains_items=0
sum_mapped_pains_rows=0

props_multi_target=0

# PERSONAS: counts + traceability density
for f in "${PERSONA_FILES[@]:-}"; do
  per_id="$(awk -F': ' '/^ID: PER-[0-9]{4}$/{print $2; exit}' "$f")"
  [[ -n "${per_id:-}" ]] || continue

  words="$(wc -w < "$f" | awk '{print $1}')"
  chars="$(wc -c < "$f" | awk '{print $1}')"
  sum_words=$((sum_words + words))
  sum_chars=$((sum_chars + chars))

  if grep -qF '<free-form notes>' "$f"; then placeholder_notes=$((placeholder_notes + 1)); fi
  if grep -qF '<...>' "$f" || grep -qF '<free-form notes>' "$f"; then placeholder_any=$((placeholder_any + 1)); fi

  jobs="$(grep -cE "^[|][[:space:]]*JTBD-JOB-[0-9]{4}-${per_id}[[:space:]]*[|]" "$f" || true)"
  pains="$(grep -cE "^[|][[:space:]]*JTBD-PAIN-[0-9]{4}-${per_id}[[:space:]]*[|]" "$f" || true)"
  gains="$(grep -cE "^[|][[:space:]]*JTBD-GAIN-[0-9]{4}-${per_id}[[:space:]]*[|]" "$f" || true)"

  evidence_ids="$(awk '
    $0=="### EvidenceIDs" {inside=1; next}
    inside && $0 ~ /^### / {exit}
    inside && $0 ~ /^## / {exit}
    inside && $0 ~ /^-[[:space:]]+E-[0-9]{4}[[:space:]]*$/ {c++}
    END{print c+0}
  ' "$f")"
  cpe_ids="$(awk '
    $0=="### CandidatePersonaIDs" {inside=1; next}
    inside && $0 ~ /^### / {exit}
    inside && $0 ~ /^## / {exit}
    inside && $0 ~ /^-[[:space:]]+CPE-[0-9]{4}[[:space:]]*$/ {c++}
    END{print c+0}
  ' "$f")"
  doc_ids="$(awk '
    $0=="### DocumentIDs" {inside=1; next}
    inside && $0 ~ /^### / {exit}
    inside && $0 ~ /^## / {exit}
    inside && $0 ~ /^-[[:space:]]+[^[:space:]].*$/ {c++}
    END{print c+0}
  ' "$f")"

  printf "%s\t%d\t%d\t%d\t%d\t%d\t%d\t%s\n" "$per_id" "$jobs" "$pains" "$gains" "$evidence_ids" "$cpe_ids" "$doc_ids" "$(basename "$f")" >> "$PERSONAS_TSV"
done

# PROPS: counts + mapping density + target graph
for f in "${PROP_FILES[@]:-}"; do
  prop_id="$(awk -F': ' '/^ID: PROP-[0-9]{4}$/{print $2; exit}' "$f")"
  [[ -n "${prop_id:-}" ]] || continue

  words="$(wc -w < "$f" | awk '{print $1}')"
  chars="$(wc -c < "$f" | awk '{print $1}')"
  sum_words=$((sum_words + words))
  sum_chars=$((sum_chars + chars))

  if grep -qF '<free-form notes>' "$f"; then placeholder_notes=$((placeholder_notes + 1)); fi
  if grep -qF '<...>' "$f" || grep -qF '<free-form notes>' "$f"; then placeholder_any=$((placeholder_any + 1)); fi

  boosters="$(grep -cE "^[|][[:space:]]*BOOST-[0-9]{4}-${prop_id}[[:space:]]*[|]" "$f" || true)"
  relievers="$(grep -cE "^[|][[:space:]]*REL-[0-9]{4}-${prop_id}[[:space:]]*[|]" "$f" || true)"
  caps="$(grep -cE "^[|][[:space:]]*CAP-[0-9]{4}-${prop_id}[[:space:]]*[|]" "$f" || true)"
  sum_boosters=$((sum_boosters + boosters))
  sum_relievers=$((sum_relievers + relievers))
  sum_caps=$((sum_caps + caps))

  targets="$(awk '
    BEGIN {inside=0;}
    $0=="## Target Persona(s)" {inside=1; next}
    inside && $0 ~ /^## / {exit}
    inside && $0 ~ /^-[[:space:]]+PER-[0-9]{4}[[:space:]]*$/ {
      sub(/^-+[[:space:]]+/, "", $0);
      gsub(/[[:space:]]+$/, "", $0);
      print $0;
    }
  ' "$f" | sort -u)"
  tcount="$(printf "%s\n" "$targets" | grep -cE '^PER-[0-9]{4}$' || true)"
  if [[ "$tcount" -ge 2 ]]; then props_multi_target=$((props_multi_target + 1)); fi

  if [[ -n "${targets:-}" ]]; then
    while IFS= read -r per; do
      [[ -n "$per" ]] || continue
      printf "%s\t%s\n" "$prop_id" "$per" >> "$EDGES_TSV"
    done <<< "$targets"
  fi

  while IFS= read -r n; do
    sum_mapped_gains_items=$((sum_mapped_gains_items + n))
    sum_mapped_gains_rows=$((sum_mapped_gains_rows + 1))
  done < <(awk -F'|' -v pid="$prop_id" '
    $0 ~ /^[|][[:space:]]*BOOST-[0-9]{4}-/ && $0 ~ ("-" pid "[[:space:]]*[|]") {
      col=$4; gsub(/^[[:space:]]+|[[:space:]]+$/, "", col);
      if (col=="" || col=="<...>") { print 0; next }
      n=split(col, a, /,/);
      c=0;
      for (i=1;i<=n;i++){ x=a[i]; gsub(/^[[:space:]]+|[[:space:]]+$/, "", x); if (x!="") c++; }
      print c;
    }
  ' "$f")

  while IFS= read -r n; do
    sum_mapped_pains_items=$((sum_mapped_pains_items + n))
    sum_mapped_pains_rows=$((sum_mapped_pains_rows + 1))
  done < <(awk -F'|' -v pid="$prop_id" '
    $0 ~ /^[|][[:space:]]*REL-[0-9]{4}-/ && $0 ~ ("-" pid "[[:space:]]*[|]") {
      col=$4; gsub(/^[[:space:]]+|[[:space:]]+$/, "", col);
      if (col=="" || col=="<...>") { print 0; next }
      n=split(col, a, /,/);
      c=0;
      for (i=1;i<=n;i++){ x=a[i]; gsub(/^[[:space:]]+|[[:space:]]+$/, "", x); if (x!="") c++; }
      print c;
    }
  ' "$f")

  printf "%s\t%d\t%d\t%d\t%d\t%s\n" "$prop_id" "$boosters" "$relievers" "$caps" "$tcount" "$(basename "$f")" >> "$PROPS_TSV"
done

EDGES="$(wc -l < "$EDGES_TSV" | awk '{print $1}')"

entropy_bits="$(cat "${PERSONA_FILES[@]}" "${PROP_FILES[@]}" 2>/dev/null | awk '
  BEGIN { n=0; }
  {
    line=$0 "\n";
    for (i=1;i<=length(line);i++) { c=substr(line,i,1); cnt[c]++; n++; }
  }
  END {
    if (n==0) { print 0; exit }
    H=0;
    for (c in cnt) {
      p = cnt[c]/n;
      H += (-p * (log(p)/log(2)));
    }
    printf "%.4f\n", H;
  }
')"

if command -v gzip >/dev/null 2>&1; then
  gz_bytes="$(cat "${PERSONA_FILES[@]}" "${PROP_FILES[@]}" 2>/dev/null | gzip -c | wc -c | awk '{print $1}')"
  gzip_ratio="$(awk -v gz="$gz_bytes" -v raw="$sum_chars" 'BEGIN{ if (raw<=0) print 1.0; else printf "%.4f\n", (gz/raw) }')"
else
  gzip_ratio="1.0000"
fi

lex_stats="$(cat "${PERSONA_FILES[@]}" "${PROP_FILES[@]}" 2>/dev/null \
  | tr '[:upper:]' '[:lower:]' \
  | tr -cs '[:alnum:]' '\n' \
  | awk '
      NF{
        w=$0;
        total++;
        if (!seen[w]++){ uniq++; }
      }
      END{ printf "%d\t%d\n", total+0, uniq+0 }
    ')"
lex_total="$(echo "$lex_stats" | awk -F'\t' '{print $1}')"
lex_uniq="$(echo "$lex_stats" | awk -F'\t' '{print $2}')"
lex_ratio="$(awk -v u="$lex_uniq" -v t="$lex_total" 'BEGIN{ if (t<=0) print 0; else printf "%.4f\n", (u/t) }')"

connect_metrics="$(awk -F'\t' -v nper="$N_PER" -v nprop="$N_PROP" '
  BEGIN{ edges=0; }
  { edges++; per_deg[$2]++; prop_deg[$1]++; }
  END{
    if (nper<=0 || nprop<=0) { printf "0\t0\t0\t0\t0\t0\n"; exit; }
    sum_per=0; count_per=0; min_per=1e9;
    for (p in per_deg) { d=per_deg[p]; sum_per+=d; count_per++; if (d<min_per) min_per=d; }
    if (count_per < nper) min_per=0;
    avg_per=(nper>0)?(sum_per/nper):0;
    sum_prop=0; count_prop=0; min_prop=1e9;
    for (r in prop_deg) { d=prop_deg[r]; sum_prop+=d; count_prop++; if (d<min_prop) min_prop=d; }
    if (count_prop < nprop) min_prop=0;
    avg_prop=(nprop>0)?(sum_prop/nprop):0;
    density = edges/(nper*nprop);
    printf "%d\t%.4f\t%.4f\t%d\t%.4f\t%d\n", edges, density, avg_per, min_per, avg_prop, min_prop;
  }
' "$EDGES_TSV")"

conn_density="$(echo "$connect_metrics" | awk -F'\t' '{print $2}')"
min_props_per_persona="$(echo "$connect_metrics" | awk -F'\t' '{print $4}')"
multi_ratio="$(awk -v m="$props_multi_target" -v n="$N_PROP" 'BEGIN{ if (n<=0) print 0; else printf "%.4f\n", (m/n) }')"

# Saturation: per persona, pains+gains referenced by propositions that target the persona.
sat_sum=0
sat_count=0
sat_min=1.0
sat_missing=""
for per in $(awk -F'\t' '{print $1}' "$PERSONAS_TSV"); do
  per_file="$(awk -F'\t' -v p="$per" '$1==p{print $8; exit}' "$PERSONAS_TSV")"
  per_path="$PERSONAS_DIR/$per_file"
  per_pains="$(grep -oE "JTBD-PAIN-[0-9]{4}-${per}" "$per_path" | sort -u || true)"
  per_gains="$(grep -oE "JTBD-GAIN-[0-9]{4}-${per}" "$per_path" | sort -u || true)"
  total_pg="$(printf "%s\n%s\n" "$per_pains" "$per_gains" | grep -cE '^JTBD-(PAIN|GAIN)-' || true)"
  if [[ "$total_pg" -eq 0 ]]; then
    sat=0
  else
    mapped="$(
      awk -F'\t' -v p="$per" '$2==p{print $1}' "$EDGES_TSV" \
        | while IFS= read -r pid; do
            [[ -n "$pid" ]] || continue
            shopt -s nullglob
            for pf in "$PROPS_DIR/${pid}-"*.md; do
              grep -hoE "JTBD-(GAIN|PAIN)-[0-9]{4}-${per}" "$pf" 2>/dev/null || true
            done
            shopt -u nullglob
          done \
        | sort -u
    )"
    covered=0
    missing_list=""
    while IFS= read -r id; do
      [[ -n "$id" ]] || continue
      if printf "%s\n" "$mapped" | grep -qF "$id"; then
        covered=$((covered + 1))
      else
        missing_list="${missing_list}${id} "
      fi
    done < <(printf "%s\n%s\n" "$per_pains" "$per_gains" | grep -E '^JTBD-(PAIN|GAIN)-' || true)
    sat="$(awk -v c="$covered" -v t="$total_pg" 'BEGIN{ if (t<=0) print 0; else printf "%.4f\n", (c/t) }')"
    if [[ -n "${missing_list// }" ]]; then
      sat_missing="${sat_missing}${per}: missing ${missing_list}"$'\n'
    fi
  fi
  sat_sum="$(awk -v s="$sat_sum" -v x="$sat" 'BEGIN{ printf "%.4f\n", (s+x) }')"
  sat_count=$((sat_count + 1))
  sat_min="$(awk -v m="$sat_min" -v x="$sat" 'BEGIN{ if (x<m) print x; else print m }')"
done
sat_avg="$(awk -v s="$sat_sum" -v n="$sat_count" 'BEGIN{ if (n<=0) print 0; else printf "%.4f\n", (s/n) }')"

avg_boosters="$(awk -v s="$sum_boosters" -v n="$N_PROP" 'BEGIN{ if (n<=0) print 0; else printf "%.4f\n", (s/n) }')"
avg_relievers="$(awk -v s="$sum_relievers" -v n="$N_PROP" 'BEGIN{ if (n<=0) print 0; else printf "%.4f\n", (s/n) }')"
avg_caps="$(awk -v s="$sum_caps" -v n="$N_PROP" 'BEGIN{ if (n<=0) print 0; else printf "%.4f\n", (s/n) }')"
avg_mapped_gains="$(awk -v s="$sum_mapped_gains_items" -v n="$sum_mapped_gains_rows" 'BEGIN{ if (n<=0) print 0; else printf "%.4f\n", (s/n) }')"
avg_mapped_pains="$(awk -v s="$sum_mapped_pains_items" -v n="$sum_mapped_pains_rows" 'BEGIN{ if (n<=0) print 0; else printf "%.4f\n", (s/n) }')"

floor_fill_props="$(awk -F'\t' '$2==4 && $3==4 && $4==4 { ok++ } END{ print ok+0 }' "$PROPS_TSV")"

scores="$(awk -v words="$sum_words" \
  -v ent="$entropy_bits" -v gz="$gzip_ratio" -v lex="$lex_ratio" \
  -v nper="$N_PER" -v nprop="$N_PROP" -v dens="$conn_density" -v minpp="$min_props_per_persona" \
  -v mult="$multi_ratio" \
  -v ab="$avg_boosters" -v ar="$avg_relievers" -v ac="$avg_caps" \
  -v amg="$avg_mapped_gains" -v amp="$avg_mapped_pains" \
  -v sat="$sat_avg" -v satmin="$sat_min" \
  -v phn="$placeholder_notes" -v pha="$placeholder_any" \
  -v floorfill="$floor_fill_props" -v nprop2="$N_PROP" '

function clamp(x, lo, hi){ return (x<lo)?lo:((x>hi)?hi:x); }
function score_linear(x, x0, x1){ return clamp((x - x0) / (x1 - x0), 0, 1) * 100; }

BEGIN {
  vol = clamp((log(words+1)/log(10)) * 25, 0, 100);

  ent_s = score_linear(ent, 3.2, 5.0);
  gz_s  = score_linear(gz, 0.18, 0.45);
  lex_s = score_linear(lex, 0.10, 0.28);
  div = (ent_s*0.4 + gz_s*0.3 + lex_s*0.3);

  cap_base = clamp((ac/4.0) * 25, 0, 50);
  cap_bonus = score_linear(ac, 4, 10) * 0.50;
  cap_s = clamp(cap_base + cap_bonus, 0, 100);

  boo_base = clamp((ab/4.0) * 20, 0, 40);
  boo_bonus = score_linear(ab, 4, 8) * 0.60;
  boo_s = clamp(boo_base + boo_bonus, 0, 100);

  rel_base = clamp((ar/4.0) * 20, 0, 40);
  rel_bonus = score_linear(ar, 4, 8) * 0.60;
  rel_s = clamp(rel_base + rel_bonus, 0, 100);

  map_s = score_linear((amg+amp)/2.0, 1.6, 3.0);

  ph_pen = clamp(phn * 1, 0, 20);
  depth = clamp((cap_s*0.45 + boo_s*0.2 + rel_s*0.2 + map_s*0.15) - ph_pen, 0, 100);

  base = (nper>0)?(1.0/nper):0;
  dens_ratio = (base>0)?(dens/base):0;
  dens_s = clamp(dens_ratio, 0, 2) * 50;
  multi_s = score_linear(mult, 0.10, 0.40);
  minpp_s = clamp(minpp/3.0, 0, 2) * 50;
  conn = clamp(multi_s*0.55 + dens_s*0.25 + minpp_s*0.20, 0, 100);

  sat_s = clamp(sat * 100, 0, 100);
  sat_min_s = clamp(satmin * 100, 0, 100);
  sat_final = (sat_s*0.7 + sat_min_s*0.3);

  overall = vol*0.12 + div*0.13 + depth*0.30 + conn*0.30 + sat_final*0.15;

  if (nprop2>0 && floorfill==nprop2) overall -= 12;
  overall -= clamp(pha * 1.0, 0, 15);

  overall = clamp(overall, 0, 100);
  printf "%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\n", overall, vol, div, depth, conn, sat_final;
}
')"

overall="$(echo "$scores" | awk -F'\t' '{print $1}')"
score_vol="$(echo "$scores" | awk -F'\t' '{print $2}')"
score_div="$(echo "$scores" | awk -F'\t' '{print $3}')"
score_depth="$(echo "$scores" | awk -F'\t' '{print $4}')"
score_conn="$(echo "$scores" | awk -F'\t' '{print $5}')"
score_sat="$(echo "$scores" | awk -F'\t' '{print $6}')"

result="$(awk -v s="$overall" -v m="$MIN_SCORE" 'BEGIN{ if (s+0 >= m+0) print "PASS"; else print "FAIL" }')"

if [[ "$QUIET" -ne 1 ]]; then
  echo "VIRRIC domain done score -- <product-marketing>"
  echo "Script: product-marketing-domain-done-score.sh"
  echo "DocsRoot: $DOCS_ROOT"
  echo "Overall: ${overall}/100  (threshold: ${MIN_SCORE})  RESULT: ${result}"
  echo ""
  echo "Subscores:"
  echo "  - volume:        ${score_vol}"
  echo "  - diversity:     ${score_div}   (entropy=${entropy_bits} bits/char, gzip_ratio=${gzip_ratio}, lex_ratio=${lex_ratio})"
  echo "  - depth:         ${score_depth} (avg boosters=${avg_boosters}, relievers=${avg_relievers}, capabilities=${avg_caps}; avgMapped gains=${avg_mapped_gains}, pains=${avg_mapped_pains})"
  echo "  - connectivity:  ${score_conn}  (props=${N_PROP}, personas=${N_PER}, edges=${EDGES}, density=${conn_density}, multi_target_ratio=${multi_ratio}, min_props_per_persona=${min_props_per_persona})"
  echo "  - saturation:    ${score_sat}   (avg pains+gains coverage=${sat_avg}, min=${sat_min})"
  echo ""
  echo "Thinness signals:"
  echo "  - placeholder_notes: ${placeholder_notes}"
  echo "  - placeholder_any:   ${placeholder_any}"
  echo "  - floor_fill_props:  ${floor_fill_props}/${N_PROP} (props with exactly 4 boosters / 4 relievers / 4 capabilities)"
  echo ""
  if [[ -n "${sat_missing:-}" ]]; then
    echo "Saturation gaps (pains+gains not mapped by any targeting proposition):"
    echo "$sat_missing" | sed '/^[[:space:]]*$/d; s/^/  - /'
    echo ""
  fi

  echo "What to do next to increase score (programmatic guidance):"
  awk -v mult="$multi_ratio" -v minpp="$min_props_per_persona" '
    BEGIN{
      if (mult+0 < 0.20) print "  - Increase overlap: create multi-persona propositions (aim >= 20% of props target 2+ personas).";
      if (minpp+0 < 4) print "  - Increase per-persona breadth: ensure each persona is targeted by >3 propositions (aim >= 4).";
    }
  '
  awk -v ac="$avg_caps" -v ab="$avg_boosters" -v ar="$avg_relievers" -v phn="$placeholder_notes" '
    BEGIN{
      if (ac+0 <= 4.01) print "  - Mine capabilities beyond the minimum: add more than 4 capability rows per proposition; do not stop at one-per-type.";
      if (ab+0 <= 4.01 || ar+0 <= 4.01) print "  - Deepen boosters/relievers: add additional rows (beyond 4) to explore alternate mechanisms and benefit stacks.";
      if (phn+0 > 0) print "  - Replace placeholder notes (<free-form notes>) with concrete bullets about risks/objections, packaging, and edge cases.";
    }
  '
  awk -v satmin="$sat_min" '
    BEGIN{
      if (satmin+0 < 1.0) print "  - Fix saturation gaps: ensure every persona pain+gain is referenced by at least one proposition mapping (or explicitly justify).";
    }
  '
fi

awk -v s="$overall" -v m="$MIN_SCORE" 'BEGIN{ exit (s+0 >= m+0) ? 0 : 1 }'

