#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/test_helpers.sh"

ROOT="$PHOSPHENE_REPO_ROOT"
IDEA_SCRIPT="$ROOT/.codex/skills/phosphene/viridian/ideation/modulator/scripts/create_idea.sh"
VALIDATE_SCRIPT="$ROOT/.github/scripts/validate_idea.sh"
DONE_SCORE_SCRIPT="$ROOT/.github/scripts/ideation-domain-done-score.sh"

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

out="$("$IDEA_SCRIPT" --title "Input Anchoring Idea")"
idea_path="$(printf "%s\n" "$out" | tail -n 1 | sed -E 's/^Created idea: //')"
[[ -f "$idea_path" ]] || phos_fail "idea not created"
cleanup_paths+=("$idea_path")

idea_id="$(grep -E '^ID:[[:space:]]*IDEA-[0-9]{4}[[:space:]]*$' "$idea_path" | head -n 1 | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"
[[ -n "${idea_id:-}" ]] || phos_fail "missing IDEA ID"

issue_number="202"

tmp="$(mktemp)"
awk -v n="$issue_number" '
  BEGIN{ updated=0; }
  /^IssueNumber:/ { print "IssueNumber: " n; updated=1; next }
  { print }
  END{ if (updated==0) exit 1 }
' "$idea_path" > "$tmp"
mv "$tmp" "$idea_path"

div_table="$tmp.div"
cat > "$div_table" <<'EOF'
| CandID | Ring | Axes | OneLiner |
| --- | --- | --- | --- |
| CAND-01 | adjacent | mechanism,channel | Fast-path workflow tweak |
| CAND-02 | adjacent | user,context | Role-specific entry point |
| CAND-03 | adjacent | modality,channel | Lightweight capture loop |
| CAND-04 | orthogonal | business_model,user | Usage-based trigger |
| CAND-05 | orthogonal | mechanism,workflow | Offline-first variant |
| CAND-06 | orthogonal | channel,feedback_loop | Ambient notification model |
| CAND-07 | extrapolatory | constraint,modality | No-input predictive mode |
| CAND-08 | extrapolatory | mechanism,context | Self-healing system |
| CAND-09 | extrapolatory | business_model,constraint | Negative-cost path |
| CAND-10 | adjacent | user,feedback_loop | Micro-reward loop |
| CAND-11 | orthogonal | modality,mechanism | Audio-first loop |
| CAND-12 | extrapolatory | channel,workflow | Cross-surface orchestration |
EOF

stress_table="$tmp.stress"
cat > "$stress_table" <<'EOF'
| CandID | FailureMode | ValueCore | Differentiator |
| --- | --- | --- | --- |
| CAND-01 | Upstream latency kills trust | Fewer steps to first signal | Removes manual handoff |
| CAND-02 | Role mismatch causes churn | Right entry for the moment | Context-aware targeting |
| CAND-03 | Capture fatigue | One-tap logging | Minimal cognitive load |
| CAND-04 | Pricing friction | Pay only for value moments | Aligns cost to spikes |
| CAND-05 | Sync conflicts | Local continuity | Offline reliability |
| CAND-06 | Notification overload | Ambient attention | Passive visibility |
| CAND-07 | Bad predictions | Zero-input guidance | Proactive framing |
| CAND-08 | Drift from reality | Auto-correct loops | System self-repairs |
| CAND-09 | Economics collapse | Negative cost loop | Incentive inversion |
| CAND-10 | Reward spam | Small wins | Consistent momentum |
| CAND-11 | Audio noise | Hands-free access | New modality channel |
| CAND-12 | Orchestration complexity | Unified surface | Cross-surface cohesion |
EOF

tmp2="$(mktemp)"
awk -v div_file="$div_table" -v stress_file="$stress_table" '
  BEGIN{ in_div=0; in_stress=0; }
  $0=="## Divergence enumeration (pure)" { print; print ""; while ((getline line < div_file) > 0) print line; close(div_file); in_div=1; next }
  in_div && $0 ~ /^## / { in_div=0 }
  $0=="## Stress-test enumeration (all candidates)" { print; print ""; while ((getline line < stress_file) > 0) print line; close(stress_file); in_stress=1; next }
  in_stress && $0 ~ /^## / { in_stress=0 }
  in_div || in_stress { next }
  { print }
' "$idea_path" > "$tmp2"
mv "$tmp2" "$idea_path"

spark_dir="$ROOT/phosphene/signals/sparks"
mkdir -p "$spark_dir"
spark_id="$(printf "SPARK-%06d" "$issue_number")"
spark_path="$spark_dir/${spark_id}.md"
cat > "$spark_path" <<EOF
ID: ${spark_id}
IssueNumber: ${issue_number}
WorkID: ${idea_id}
Lane: viridian
UpstreamSignalID:
InputWorkIDs: RA-001
CreatedUTC: 2026-02-01T00:00:00Z

## Issue snapshot

Input anchoring test snapshot.
EOF
cleanup_paths+=("$spark_path")

bash "$VALIDATE_SCRIPT" "$idea_path"
bash "$DONE_SCORE_SCRIPT" --file "$idea_path" --min-score 0 >/dev/null

echo "OK: ideation input anchoring test passed."
