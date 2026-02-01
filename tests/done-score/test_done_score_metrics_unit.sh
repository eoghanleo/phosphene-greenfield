#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/test_helpers.sh"

LIB_DIR="$PHOSPHENE_REPO_ROOT/phosphene/phosphene-core/lib"
# shellcheck source=/dev/null
source "$LIB_DIR/phosphene_env.sh"
# shellcheck source=/dev/null
source "$LIB_DIR/phosphene_done_score_metrics.sh"

fail() { echo "FAIL: $*" >&2; exit 1; }

assert_eq() {
  local expected="$1"
  local actual="$2"
  local label="$3"
  if [[ "$expected" != "$actual" ]]; then
    fail "$label expected '$expected' got '$actual'"
  fi
}

assert_num_close() {
  local expected="$1"
  local actual="$2"
  local tol="$3"
  local label="$4"
  awk -v e="$expected" -v a="$actual" -v t="$tol" -v l="$label" 'BEGIN{
    diff = e - a;
    if (diff < 0) diff = -diff;
    if (diff > t) { printf "FAIL: %s expected %.4f got %.4f (tol=%.4f)\n", l, e, a, t; exit 1 }
  }'
}

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

# score_linear + clamp
score_mid="$(phos_ds_score_linear 5 0 10)"
score_low="$(phos_ds_score_linear -5 0 10)"
score_high="$(phos_ds_score_linear 15 0 10)"
assert_eq "50.0000" "$score_mid" "score_linear mid"
assert_eq "0.0000" "$score_low" "score_linear low"
assert_eq "100.0000" "$score_high" "score_linear high"

# entropy stats
entropy_file="$tmp/entropy.txt"
cat >"$entropy_file" <<'TXT'
alpha beta beta gamma gamma gamma
TXT
entropy_stats="$(phos_ds_entropy_stats "$entropy_file")"
ent_total="$(echo "$entropy_stats" | awk -F'\t' '{print $1}')"
ent_unique="$(echo "$entropy_stats" | awk -F'\t' '{print $2}')"
ent_H="$(echo "$entropy_stats" | awk -F'\t' '{print $3}')"
ent_norm="$(echo "$entropy_stats" | awk -F'\t' '{print $4}')"
ent_uniq_ratio="$(echo "$entropy_stats" | awk -F'\t' '{print $5}')"
assert_eq "6" "$ent_total" "entropy total"
assert_eq "3" "$ent_unique" "entropy unique"
# Expected H for counts (1,2,3) total 6 = 1.4591
assert_num_close 1.4591 "$ent_H" 0.0006 "entropy H"
assert_num_close 0.9206 "$ent_norm" 0.0010 "entropy norm"
assert_num_close 0.5000 "$ent_uniq_ratio" 0.0001 "entropy uniq_ratio"

# fragment stats
fragment_file="$tmp/frag.txt"
cat >"$fragment_file" <<'TXT'
One sentence.
Two sentences. Second.
TXT
frag_stats="$(phos_ds_fragment_stats "$fragment_file")"
frag_count="$(echo "$frag_stats" | awk -F'\t' '{print $1}')"
frag_avg="$(echo "$frag_stats" | awk -F'\t' '{print $2}')"
frag_two_sent="$(echo "$frag_stats" | awk -F'\t' '{print $3}')"
assert_eq "2" "$frag_count" "fragment count"
assert_num_close 2.5000 "$frag_avg" 0.0001 "fragment avg"
assert_num_close 0.5000 "$frag_two_sent" 0.0001 "fragment two_sent"

# cleaning
clean_file="$tmp/clean.txt"
cat >"$clean_file" <<'TXT'
PER-0001 hello https://example.com `code` file.sh
TXT
cleaned_words="$(phos_ds_clean_text_common 's/PER-[0-9]{4}/ /g' < "$clean_file" | wc -w | awk '{print $1}')"
assert_eq "1" "$cleaned_words" "cleaned word count"

# graph stats
edges_file="$tmp/edges.tsv"
cat >"$edges_file" <<'TXT'
A	X
A	Y
B	Y
TXT
graph_stats="$(phos_ds_graph_stats_bipartite "$edges_file" 2 3 1 2)"
edges="$(echo "$graph_stats" | awk -F'\t' '{print $1}')"
dens="$(echo "$graph_stats" | awk -F'\t' '{print $2}')"
avg_left="$(echo "$graph_stats" | awk -F'\t' '{print $3}')"
min_left="$(echo "$graph_stats" | awk -F'\t' '{print $4}')"
avg_right="$(echo "$graph_stats" | awk -F'\t' '{print $5}')"
min_right="$(echo "$graph_stats" | awk -F'\t' '{print $6}')"
multi_ratio="$(echo "$graph_stats" | awk -F'\t' '{print $7}')"
assert_eq "3" "$edges" "graph edges"
assert_num_close 0.5000 "$dens" 0.0001 "graph dens"
assert_num_close 1.5000 "$avg_left" 0.0001 "graph avg_left"
assert_eq "1" "$min_left" "graph min_left"
assert_num_close 1.0000 "$avg_right" 0.0001 "graph avg_right"
assert_eq "0" "$min_right" "graph min_right"
assert_num_close 0.5000 "$multi_ratio" 0.0001 "graph multi_ratio"

echo "OK: done-score metrics unit tests passed."
