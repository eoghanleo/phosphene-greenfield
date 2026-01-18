#!/usr/bin/env bash
set -euo pipefail

# E2E TEST
# Chains the full <research> script lifecycle and culminates in validation.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/test_helpers.sh"

ROOT="$PHOSPHENE_REPO_ROOT"

fail() { echo "FAIL: $*" >&2; exit 1; }

cleanup_paths=()
cleanup() {
  for p in "${cleanup_paths[@]:-}"; do
    [[ -n "${p:-}" ]] || continue
    [[ -e "$p" ]] || continue
    rm -rf "$p" || true
  done

  # Ensure we don't leave the repo-wide index in a state that references deleted test artifacts.
  phos_id_validate_quiet || true
}
trap cleanup EXIT

echo "--- registry validate (pre) ---"
"$ROOT/phosphene/phosphene-core/bin/phosphene" id validate >/dev/null

echo "--- create RA bundle ---"
bundle_line="$("$ROOT/phosphene/domains/research/scripts/create_research_assessment_bundle.sh" \
  --title "TEST Research Lifecycle Bundle" \
  --owner "lifecycle-test" \
  --priority Medium \
  | grep -E '^Created RA bundle:' | tail -n 1
)"
BUNDLE_DIR="${bundle_line#Created RA bundle: }"
[[ -d "$BUNDLE_DIR" ]] || fail "bundle not created: $BUNDLE_DIR"
cleanup_paths+=("$BUNDLE_DIR")

echo "--- validate bundle (baseline) ---"
"$ROOT/phosphene/domains/research/scripts/validate_research_assessment_bundle.sh" "$BUNDLE_DIR" >/dev/null

echo "--- add reference solution ---"
rs_line="$("$ROOT/phosphene/domains/research/scripts/add_reference_solution.sh" \
  --bundle "$BUNDLE_DIR" \
  --name "Test Reference Solution" \
  --type Market \
  --pointer "https://example.com/refsol" \
  | tail -n 1
)"
RS_ID="${rs_line#Added RefSolID: }"
[[ "$RS_ID" =~ ^RS-[0-9]{4}$ ]] || fail "failed to parse RefSolID: $rs_line"

echo "--- add evidence record ---"
e_line="$("$ROOT/phosphene/domains/research/scripts/add_evidence_record.sh" \
  --bundle "$BUNDLE_DIR" \
  --type "Quote" \
  --pointer "https://example.com/evidence" \
  | tail -n 1
)"
E_ID="${e_line#Added EvidenceID: }"
[[ "$E_ID" =~ ^E-[0-9]{4}$ ]] || fail "failed to parse EvidenceID: $e_line"

echo "--- create pitch ---"
pitch_line="$("$ROOT/phosphene/domains/research/scripts/create_product_pitch.sh" \
  --bundle "$BUNDLE_DIR" \
  --title "TEST Pitch" \
  | tail -n 1
)"
PITCH_FILE="${pitch_line#Created: }"
[[ -f "$PITCH_FILE" ]] || fail "pitch not created: $PITCH_FILE"

echo "--- create candidate persona ---"
cpe_line="$("$ROOT/phosphene/domains/research/scripts/create_candidate_persona.sh" \
  --bundle "$BUNDLE_DIR" \
  --name "TEST Candidate Persona" \
  --segment "SEG-0001" \
  | grep -E '^Created candidate persona:' | tail -n 1
)"
CPE_FILE="${cpe_line#Created candidate persona: }"
[[ -f "$CPE_FILE" ]] || fail "candidate persona not created: $CPE_FILE"

echo "--- validate bundle (after mutations) ---"
"$ROOT/phosphene/domains/research/scripts/validate_research_assessment_bundle.sh" "$BUNDLE_DIR" >/dev/null

echo "--- assemble bundle ---"
asm_line="$("$ROOT/phosphene/domains/research/scripts/assemble_research_assessment_bundle.sh" "$BUNDLE_DIR" | tail -n 1)"
ASM_FILE="${asm_line#Assembled: }"
[[ -f "$ASM_FILE" ]] || fail "assembled file not created: $ASM_FILE"

echo "--- registry validate (post; repo-wide) ---"
"$ROOT/phosphene/phosphene-core/bin/phosphene" id validate >/dev/null

echo "OK: research lifecycle test passed."

