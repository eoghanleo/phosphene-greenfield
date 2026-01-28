#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/test_helpers.sh"

ROOT="$PHOSPHENE_REPO_ROOT"
PM_SCRIPTS="$ROOT/.codex/skills/phosphene/cerulean/product-management/modulator/scripts"
PMK_SCRIPTS="$ROOT/.codex/skills/phosphene/beryl/product-marketing/modulator/scripts"

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

register_cleanup() {
  cleanup_paths+=("$1")
}

init_test() {
  cleanup_paths=()
  trap cleanup EXIT
}

assert_contains() {
  local file="$1"
  local text="$2"
  grep -qF -- "$text" "$file" || fail "expected to find '$text' in $(basename "$file")"
}

extract_header_id() {
  local pattern="$1"
  local file="$2"
  grep -E "^ID:[[:space:]]*${pattern}[[:space:]]*$" "$file" \
    | head -n 1 \
    | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//'
}

create_prd_bundle() {
  local title="${1:-TEST PRD Bundle}"
  local explicit_id="${2:-}"
  local deps="${3:-}"
  local line

  args=("$PM_SCRIPTS/create_prd_bundle.sh" --title "$title" --owner "test" --version "v0.1")
  if [[ -n "$explicit_id" ]]; then args+=(--id "$explicit_id"); fi
  if [[ -n "$deps" ]]; then args+=(--dependencies "$deps"); fi

  line="$("${args[@]}" | grep -E '^Created PRD bundle:' | tail -n 1)"

  TEST_BUNDLE_DIR="${line#Created PRD bundle: }"
  [[ -d "$TEST_BUNDLE_DIR" ]] || fail "bundle not created: $TEST_BUNDLE_DIR"
  register_cleanup "$TEST_BUNDLE_DIR"

  TEST_PRD_ID="$(extract_header_id 'PRD-[0-9]{3}' "$TEST_BUNDLE_DIR/00-coversheet.md")"
  [[ "$TEST_PRD_ID" =~ ^PRD-[0-9]{3}$ ]] || fail "failed to parse PRD ID from coversheet"
}

create_vpd_bundle() {
  local title="${1:-TEST VPD Bundle}"
  local line
  line="$("$PMK_SCRIPTS/create_value_proposition_design_bundle.sh" \
    --title "$title" \
    --owner "test" \
    --priority Medium \
    | grep -E '^Created VPD bundle:' \
    | tail -n 1
  )"
  TEST_VPD_DIR="${line#Created VPD bundle: }"
  [[ -d "$TEST_VPD_DIR" ]] || fail "vpd bundle not created: $TEST_VPD_DIR"
  register_cleanup "$TEST_VPD_DIR"

  TEST_VPD_ID="$(basename "$TEST_VPD_DIR" | sed -E 's/^(VPD-[0-9]{3}).*$/\1/')"
  [[ "$TEST_VPD_ID" =~ ^VPD-[0-9]{3}$ ]] || fail "failed to parse VPD ID from $TEST_VPD_DIR"
}

create_persona_in_vpd() {
  local title="${1:-Test Persona}"
  local persona_dir="$TEST_VPD_DIR/10-personas"
  [[ -d "$persona_dir" ]] || fail "missing personas dir: $persona_dir"
  local line
  line="$("$PMK_SCRIPTS/create_new_persona.sh" \
    --title "$title" \
    --vpd "$TEST_VPD_ID" \
    --owner "test" \
    --status Draft \
    --dependencies "" \
    --output-dir "$persona_dir" \
    | tail -n 1
  )"
  TEST_PERSONA_FILE="${line#Created persona: }"
  [[ -f "$TEST_PERSONA_FILE" ]] || fail "persona not created: $TEST_PERSONA_FILE"
  register_cleanup "$TEST_PERSONA_FILE"
  TEST_PERSONA_ID="$(extract_header_id 'PER-[0-9]{4}' "$TEST_PERSONA_FILE")"
  [[ -n "${TEST_PERSONA_ID:-}" ]] || fail "failed to parse persona ID"
}

create_proposition_in_vpd() {
  local title="${1:-Test Proposition}"
  local prop_dir="$TEST_VPD_DIR/20-propositions"
  [[ -d "$prop_dir" ]] || fail "missing propositions dir: $prop_dir"
  local line
  line="$("$PMK_SCRIPTS/create_new_proposition.sh" \
    --title "$title" \
    --vpd "$TEST_VPD_ID" \
    --owner "test" \
    --status Draft \
    --dependencies "" \
    --output-dir "$prop_dir" \
    | tail -n 1
  )"
  TEST_PROP_FILE="${line#Created proposition: }"
  [[ -f "$TEST_PROP_FILE" ]] || fail "proposition not created: $TEST_PROP_FILE"
  register_cleanup "$TEST_PROP_FILE"
  TEST_PROP_ID="$(extract_header_id 'PROP-[0-9]{4}' "$TEST_PROP_FILE")"
  [[ -n "${TEST_PROP_ID:-}" ]] || fail "failed to parse proposition ID"
}

run_test() {
  local name="${1:-}"
  [[ -n "$name" ]] || fail "missing test name"

  init_test

  case "$name" in
    create_prd_bundle_auto_id)
      create_prd_bundle "TEST PRD Auto"
      [[ -f "$TEST_BUNDLE_DIR/00-coversheet.md" ]] || fail "missing coversheet"
      [[ -f "$TEST_BUNDLE_DIR/10-executive-summary.md" ]] || fail "missing executive summary"
      [[ -d "$TEST_BUNDLE_DIR/60-requirements" ]] || fail "missing requirements dir"
      assert_contains "$TEST_BUNDLE_DIR/00-coversheet.md" "ID: $TEST_PRD_ID"
      ;;
    create_prd_bundle_explicit_id)
      create_prd_bundle "TEST PRD Explicit" "PRD-010"
      [[ "$TEST_PRD_ID" == "PRD-010" ]] || fail "explicit ID not used"
      ;;
    assemble_prd_bundle)
      create_prd_bundle "TEST PRD Assemble"
      "$PM_SCRIPTS/assemble_prd_bundle.sh" "$TEST_BUNDLE_DIR" >/dev/null
      [[ -f "$TEST_BUNDLE_DIR/${TEST_PRD_ID}.md" ]] || fail "assembled file not created"
      assert_contains "$TEST_BUNDLE_DIR/${TEST_PRD_ID}.md" "AUTO-ASSEMBLED FILE"
      assert_contains "$TEST_BUNDLE_DIR/${TEST_PRD_ID}.md" "## Coversheet"
      ;;
    validate_prd_bundle_structure)
      create_prd_bundle "TEST PRD Validate"
      bash "$ROOT/.github/scripts/validate_prd_bundle.sh" --strict "$TEST_BUNDLE_DIR" >/dev/null
      ;;
    validate_prd_bundle_strict_fails_on_unresolved_id)
      create_prd_bundle "TEST PRD Validate Strict"
      printf "\n- RA-999\n" >> "$TEST_BUNDLE_DIR/10-executive-summary.md"
      if bash "$ROOT/.github/scripts/validate_prd_bundle.sh" --strict "$TEST_BUNDLE_DIR" >/dev/null 2>&1; then
        fail "expected strict validation to fail with unresolved ID"
      fi
      ;;
    id_registry_where_prd)
      create_prd_bundle "TEST PRD Registry"
      "$ROOT/phosphene/phosphene-core/bin/id_registry.sh" build >/dev/null
      result="$("$ROOT/phosphene/phosphene-core/bin/id_registry.sh" where "$TEST_PRD_ID")"
      [[ -n "${result:-}" ]] || fail "ID not found in registry"
      type="$(printf "%s\n" "$result" | head -n 1 | awk -F'\t' '{print $1}')"
      [[ "${type:-}" == "prd" ]] || fail "expected type 'prd' in registry output (got: ${type:-})"
      ;;
    id_registry_next_prd)
      "$ROOT/phosphene/phosphene-core/bin/id_registry.sh" build >/dev/null
      next_id="$("$ROOT/phosphene/phosphene-core/bin/id_registry.sh" next --type prd)"
      [[ "$next_id" =~ ^PRD-[0-9]{3}$ ]] || fail "invalid next ID format"
      ;;
    product_management_done_score_with_vpd_input)
      create_vpd_bundle "TEST VPD For PRD Done Score"
      create_persona_in_vpd "TEST Persona"
      create_proposition_in_vpd "TEST Proposition"
      create_prd_bundle "TEST PRD Done Score" "" "$TEST_VPD_ID"

      out="$(bash "$ROOT/.github/scripts/product-management-domain-done-score.sh" "$TEST_BUNDLE_DIR" --min-score 0)"
      echo "$out" | grep -qF "Inputs (product-marketing):" || fail "expected done-score to print Inputs section"
      echo "$out" | grep -qE "VPD\\(s\\):.*${TEST_VPD_ID}" || fail "expected done-score to list VPD ID"
      echo "$out" | grep -qE "personas:[[:space:]]*[1-9][0-9]*, propositions:[[:space:]]*[1-9][0-9]*" || fail "expected non-zero input personas/props"
      ;;
    product_management_done_score_deterministic)
      create_vpd_bundle "TEST VPD For PRD Done Score"
      create_persona_in_vpd "TEST Persona"
      create_proposition_in_vpd "TEST Proposition"
      create_prd_bundle "TEST PRD Done Score" "" "$TEST_VPD_ID"

      out1="$(env LC_ALL=C LANG=C TZ=UTC bash "$ROOT/.github/scripts/product-management-domain-done-score.sh" "$TEST_BUNDLE_DIR" --min-score 0)" \
        || fail "done-score run 1 failed"
      out2="$(env LC_ALL=C LANG=C TZ=UTC bash "$ROOT/.github/scripts/product-management-domain-done-score.sh" "$TEST_BUNDLE_DIR" --min-score 0)" \
        || fail "done-score run 2 failed"
      printf "%s\n" "$out1" | grep -qE 'Overall: [0-9]+[.][0-9]{2}' \
        || fail "expected overall score formatted to 2 decimals"
      [[ "$out1" == "$out2" ]] || fail "done-score output not deterministic across runs"
      ;;
    *)
      fail "unknown test name: $name"
      ;;
  esac

  echo "OK: product-management test passed (${name})."
}

