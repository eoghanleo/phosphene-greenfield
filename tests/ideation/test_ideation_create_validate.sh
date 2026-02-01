#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/test_helpers.sh"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/done_receipt_helpers.sh"

ROOT="$PHOSPHENE_REPO_ROOT"
IDEA_SCRIPT="$ROOT/.codex/skills/phosphene/viridian/ideation/modulator/scripts/create_idea.sh"
BOOTSTRAP_SCRIPT="$ROOT/.codex/skills/phosphene/viridian/ideation/modulator/scripts/ideation_storm_table_bootstrap.sh"
SET_DESC_SCRIPT="$ROOT/.codex/skills/phosphene/viridian/ideation/modulator/scripts/ideation_storm_set_description.sh"
VALIDATE_SCRIPT="$ROOT/.github/scripts/validate_idea.sh"
DONE_SCORE_SCRIPT="$ROOT/.github/scripts/ideation-domain-done-score.sh"
EMIT_SCRIPT="$ROOT/.codex/skills/phosphene/viridian/ideation/modulator/scripts/ideation_emit_done_receipt.sh"

cleanup_paths=()
cleanup() {
  for p in "${cleanup_paths[@]:-}"; do
    [[ -n "${p:-}" ]] || continue
    [[ -e "$p" ]] || continue
    rm -rf "$p" || true
  done
  phos_id_validate_quiet || true
}
trap cleanup EXIT

out="$("$IDEA_SCRIPT" --title "Test Idea")"
idea_path="$(printf "%s\n" "$out" | tail -n 1 | sed -E 's/^Created idea: //')"
[[ -f "$idea_path" ]] || phos_fail "idea not created"
cleanup_paths+=("$idea_path")

idea_id="$(grep -E '^ID:[[:space:]]*IDEA-[0-9]{4}[[:space:]]*$' "$idea_path" | head -n 1 | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"
[[ -n "${idea_id:-}" ]] || phos_fail "missing IDEA ID"

issue_number="101"

tmp="$(mktemp)"
awk -v n="$issue_number" '
  BEGIN{ updated=0; }
  /^IssueNumber:/ { print "IssueNumber: " n; updated=1; next }
  { print }
  END{ if (updated==0) exit 1 }
' "$idea_path" > "$tmp"
mv "$tmp" "$idea_path"

spark_dir="$ROOT/phosphene/signals/sparks"
mkdir -p "$spark_dir"
spark_id="$(printf "SPARK-%06d" "$issue_number")"
spark_path="$spark_dir/${spark_id}.md"
probe_count="4"

sha256_hex() {
  if command -v sha256sum >/dev/null 2>&1; then
    printf "%s" "$1" | sha256sum | awk '{print $1}'
  elif command -v shasum >/dev/null 2>&1; then
    printf "%s" "$1" | shasum -a 256 | awk '{print $1}'
  else
    printf "%s" "$1" | openssl dgst -sha256 | awk '{print $2}'
  fi
}

seed_input="$(printf "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s" \
  "viridian" "ideation" "$idea_id" "Test Idea" "" "" "" "$probe_count")"
seed_sha256="$(sha256_hex "$seed_input")"

cat > "$spark_path" <<EOF
ID: ${spark_id}
IssueNumber: ${issue_number}
WorkID: ${idea_id}
Lane: viridian
UpstreamSignalID:
InputWorkIDs:
ManifoldProbeCount: ${probe_count}
SeedSHA256: ${seed_sha256}
CreatedUTC: 2026-02-01T00:00:00Z

## Issue snapshot

Test ideation input snapshot.
EOF
cleanup_paths+=("$spark_path")

bash "$BOOTSTRAP_SCRIPT" --file "$idea_path" >/dev/null

while IFS=$'\t' read -r storm_id probe_one probe_two ring; do
  [[ -n "${storm_id:-}" ]] || continue
  desc="First sentence: explore ${ring} dynamics between ${probe_one} and ${probe_two}. Second sentence: anchor to the SPARK prompt and constraints with a concrete scenario. Third sentence: state a clear outcome and why the probe pairing matters."
  bash "$SET_DESC_SCRIPT" --file "$idea_path" --storm-id "$storm_id" --description "$desc" >/dev/null
done < <(awk -F'|' -v start="## Storm table" '
  function trim(s){ gsub(/^[[:space:]]+|[[:space:]]+$/, "", s); return s; }
  BEGIN{ inside=0; }
  $0==start { inside=1; next }
  inside && $0 ~ /^## / { exit }
  inside && $0 ~ /^\|/ {
    n=split($0, a, /\|/);
    if (n < 7) next;
    id=trim(a[2]); p1=trim(a[3]); p2=trim(a[4]); ring=trim(a[5]);
    if (id=="" || id=="STORM-ID" || id ~ /^-+$/) next;
    print id "\t" p1 "\t" p2 "\t" ring;
  }
' "$idea_path")

bash "$VALIDATE_SCRIPT" "$idea_path"
done_out=""
if ! done_out="$(bash "$DONE_SCORE_SCRIPT" --file "$idea_path" --min-score 0 2>&1)"; then
  echo "$done_out"
  exit 1
fi

where_line="$("$ROOT/phosphene/phosphene-core/bin/phosphene" id where "$idea_id" | head -n 1)"
[[ -n "${where_line:-}" ]] || phos_fail "id where failed for $idea_id"

bus="$(phos_temp_bus)"
cleanup_paths+=("$bus")
phos_append_prism_branch_invoked "ideation" "viridian" "$idea_id" "101" "$bus"
bash "$EMIT_SCRIPT" --issue-number 101 --work-id "$idea_id" --bus "$bus"
phos_validate_bus "$bus"

echo "OK: ideation create/validate/done receipt test passed."
