#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../lib/test_helpers.sh"

ROOT="$PHOSPHENE_REPO_ROOT"
PM_SCRIPTS="$ROOT/.codex/skills/phosphene/beryl/product-marketing/modulator/scripts"
RESEARCH_DOCS="$ROOT/phosphene/domains/research/output"

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

assert_not_contains() {
  local file="$1"
  local text="$2"
  if grep -qF -- "$text" "$file"; then
    fail "expected '$text' to be absent in $(basename "$file")"
  fi
}

extract_header_id() {
  local pattern="$1"
  local file="$2"
  grep -E "^ID:[[:space:]]*${pattern}[[:space:]]*$" "$file" \
    | head -n 1 \
    | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//'
}

last_table_id() {
  local pattern="$1"
  local file="$2"
  awk -v r="$pattern" '
    BEGIN { FS="|"; last=""; }
    $0 ~ ("^\\|[[:space:]]*" r "[[:space:]]*\\|") {
      id=$2
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", id)
      if (id != "") last=id
    }
    END { if (last != "") print last }
  ' "$file"
}

create_bundle() {
  local title="${1:-TEST VPD Bundle}"
  local line
  line="$("$PM_SCRIPTS/create_value_proposition_design_bundle.sh" \
    --title "$title" \
    --owner "test" \
    --priority Medium \
    | grep -E '^Created VPD bundle:' \
    | tail -n 1
  )"
  TEST_BUNDLE_DIR="${line#Created VPD bundle: }"
  [[ -d "$TEST_BUNDLE_DIR" ]] || fail "bundle not created: $TEST_BUNDLE_DIR"
  register_cleanup "$TEST_BUNDLE_DIR"

  TEST_VPD_ID="$(basename "$TEST_BUNDLE_DIR" | sed -E 's/^(VPD-[0-9]{3}).*$/\1/')"
  [[ "$TEST_VPD_ID" =~ ^VPD-[0-9]{3}$ ]] || fail "failed to parse VPD ID from $TEST_BUNDLE_DIR"

  PERSONA_DIR="$TEST_BUNDLE_DIR/10-personas"
  PROP_DIR="$TEST_BUNDLE_DIR/20-propositions"
  [[ -d "$PERSONA_DIR" ]] || fail "missing personas dir: $PERSONA_DIR"
  [[ -d "$PROP_DIR" ]] || fail "missing propositions dir: $PROP_DIR"
}

create_persona() {
  local title="${1:-Test Persona}"
  local line
  line="$("$PM_SCRIPTS/create_new_persona.sh" \
    --title "$title" \
    --vpd "$TEST_VPD_ID" \
    --owner "test" \
    --status Draft \
    --dependencies "" \
    --output-dir "$PERSONA_DIR" \
    | tail -n 1
  )"
  TEST_PERSONA_FILE="${line#Created persona: }"
  [[ -f "$TEST_PERSONA_FILE" ]] || fail "persona not created: $TEST_PERSONA_FILE"
  register_cleanup "$TEST_PERSONA_FILE"

  TEST_PERSONA_ID="$(extract_header_id 'PER-[0-9]{4}' "$TEST_PERSONA_FILE")"
  [[ -n "${TEST_PERSONA_ID:-}" ]] || fail "failed to parse persona ID"
}

create_proposition() {
  local title="${1:-Test Proposition}"
  local line
  line="$("$PM_SCRIPTS/create_new_proposition.sh" \
    --title "$title" \
    --vpd "$TEST_VPD_ID" \
    --owner "test" \
    --status Draft \
    --dependencies "" \
    --output-dir "$PROP_DIR" \
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
    id_registry)
      "$PM_SCRIPTS/id_registry.sh" validate >/dev/null
      ;;
    create_value_proposition_design_bundle)
      create_bundle "TEST VPD Bundle"
      [[ -f "$TEST_BUNDLE_DIR/00-coversheet.md" ]] || fail "missing coversheet in bundle"
      [[ -d "$TEST_BUNDLE_DIR/10-personas" ]] || fail "missing personas folder in bundle"
      [[ -d "$TEST_BUNDLE_DIR/20-propositions" ]] || fail "missing propositions folder in bundle"
      ;;
    create_new_persona)
      create_bundle "TEST VPD Bundle"
      create_persona "Test Persona Create"
      assert_contains "$TEST_PERSONA_FILE" "ID: $TEST_PERSONA_ID"
      if ! grep -qE "^Dependencies:.*${TEST_VPD_ID}" "$TEST_PERSONA_FILE"; then
        fail "Dependencies missing VPD ID in $(basename "$TEST_PERSONA_FILE")"
      fi
      ;;
    create_new_proposition)
      create_bundle "TEST VPD Bundle"
      create_proposition "Test Proposition Create"
      assert_contains "$TEST_PROP_FILE" "ID: $TEST_PROP_ID"
      if ! grep -qE "^Dependencies:.*${TEST_VPD_ID}" "$TEST_PROP_FILE"; then
        fail "Dependencies missing VPD ID in $(basename "$TEST_PROP_FILE")"
      fi
      ;;
    validate_persona)
      create_bundle "TEST VPD Bundle"
      create_persona "Validate Persona"
      "$PM_SCRIPTS/validate_persona.sh" --strict "$TEST_PERSONA_FILE" >/dev/null
      ;;
    validate_proposition)
      create_bundle "TEST VPD Bundle"
      create_proposition "Validate Proposition"
      "$PM_SCRIPTS/validate_proposition.sh" --strict "$TEST_PROP_FILE" >/dev/null
      ;;
    update_persona_summary)
      create_bundle "TEST VPD Bundle"
      create_persona "Update Persona Summary"
      summary_file="$(mktemp)"
      register_cleanup "$summary_file"
      cat >"$summary_file" <<'EOF'
- Summary line A
- Summary line B
EOF
      "$PM_SCRIPTS/update_persona_summary.sh" --persona "$TEST_PERSONA_FILE" --summary-file "$summary_file" >/dev/null
      assert_contains "$TEST_PERSONA_FILE" "Summary line A"
      ;;
    add_persona_jtbd_item)
      create_bundle "TEST VPD Bundle"
      create_persona "Add JTBD Persona"
      "$PM_SCRIPTS/add_persona_jtbd_item.sh" \
        --persona "$TEST_PERSONA_FILE" \
        --type JOB \
        --text "Ship work faster" \
        --importance 3 >/dev/null
      jtbd_id="$(last_table_id 'JTBD-JOB-[0-9]{4}-PER-[0-9]{4}' "$TEST_PERSONA_FILE")"
      [[ -n "$jtbd_id" ]] || fail "missing JTBD ID after add"
      assert_contains "$TEST_PERSONA_FILE" "$jtbd_id"
      assert_contains "$TEST_PERSONA_FILE" "Ship work faster"
      ;;
    update_persona_jtbd_item)
      create_bundle "TEST VPD Bundle"
      create_persona "Update JTBD Persona"
      "$PM_SCRIPTS/add_persona_jtbd_item.sh" \
        --persona "$TEST_PERSONA_FILE" \
        --type GAIN \
        --text "Initial gain" \
        --importance 2 >/dev/null
      jtbd_id="$(last_table_id 'JTBD-GAIN-[0-9]{4}-PER-[0-9]{4}' "$TEST_PERSONA_FILE")"
      [[ -n "$jtbd_id" ]] || fail "missing JTBD ID for update"
      "$PM_SCRIPTS/update_persona_jtbd_item.sh" \
        --persona "$TEST_PERSONA_FILE" \
        --jtbd-id "$jtbd_id" \
        --text "Updated gain" \
        --importance 5 >/dev/null
      assert_contains "$TEST_PERSONA_FILE" "| $jtbd_id | Updated gain | 5 |"
      ;;
    add_persona_evidence_link)
      create_bundle "TEST VPD Bundle"
      create_persona "Evidence Persona"
      "$PM_SCRIPTS/add_persona_evidence_link.sh" --persona "$TEST_PERSONA_FILE" --id "E-0001" >/dev/null
      assert_contains "$TEST_PERSONA_FILE" "- E-0001"
      ;;
    remove_persona_evidence_link)
      create_bundle "TEST VPD Bundle"
      create_persona "Evidence Remove Persona"
      "$PM_SCRIPTS/add_persona_evidence_link.sh" --persona "$TEST_PERSONA_FILE" --id "E-0001" >/dev/null
      "$PM_SCRIPTS/remove_persona_evidence_link.sh" --persona "$TEST_PERSONA_FILE" --id "E-0001" >/dev/null
      assert_not_contains "$TEST_PERSONA_FILE" "- E-0001"
      ;;
    add_persona_related_link)
      create_bundle "TEST VPD Bundle"
      create_persona "Related Link Persona"
      link="https://example.com/related"
      "$PM_SCRIPTS/add_persona_related_link.sh" --persona "$TEST_PERSONA_FILE" --link "$link" >/dev/null
      assert_contains "$TEST_PERSONA_FILE" "- $link"
      ;;
    remove_persona_related_link)
      create_bundle "TEST VPD Bundle"
      create_persona "Remove Link Persona"
      link="https://example.com/related"
      "$PM_SCRIPTS/add_persona_related_link.sh" --persona "$TEST_PERSONA_FILE" --link "$link" >/dev/null
      "$PM_SCRIPTS/remove_persona_related_link.sh" --persona "$TEST_PERSONA_FILE" --link "$link" >/dev/null
      assert_not_contains "$TEST_PERSONA_FILE" "- $link"
      ;;
    add_persona_note)
      create_bundle "TEST VPD Bundle"
      create_persona "Persona Notes"
      note="Persona note entry"
      "$PM_SCRIPTS/add_persona_note.sh" --persona "$TEST_PERSONA_FILE" --note "$note" >/dev/null
      assert_contains "$TEST_PERSONA_FILE" "$note"
      ;;
    overwrite_persona_notes)
      create_bundle "TEST VPD Bundle"
      create_persona "Persona Notes Overwrite"
      notes_file="$(mktemp)"
      register_cleanup "$notes_file"
      cat >"$notes_file" <<'EOF'
- Note A
- Note B
EOF
      "$PM_SCRIPTS/overwrite_persona_notes.sh" --persona "$TEST_PERSONA_FILE" --notes-file "$notes_file" >/dev/null
      assert_contains "$TEST_PERSONA_FILE" "Note A"
      ;;
    add_proposition_target_persona)
      create_bundle "TEST VPD Bundle"
      create_persona "Target Persona"
      create_proposition "Target Proposition"
      "$PM_SCRIPTS/add_proposition_target_persona.sh" \
        --proposition "$TEST_PROP_FILE" \
        --persona "$TEST_PERSONA_ID" >/dev/null
      assert_contains "$TEST_PROP_FILE" "- $TEST_PERSONA_ID"
      if ! grep -qE "^Dependencies:.*${TEST_PERSONA_ID}" "$TEST_PROP_FILE"; then
        fail "Dependencies missing persona ID in $(basename "$TEST_PROP_FILE")"
      fi
      ;;
    remove_proposition_target_persona)
      create_bundle "TEST VPD Bundle"
      create_persona "Target Persona Remove"
      create_proposition "Target Proposition Remove"
      "$PM_SCRIPTS/add_proposition_target_persona.sh" \
        --proposition "$TEST_PROP_FILE" \
        --persona "$TEST_PERSONA_ID" >/dev/null
      "$PM_SCRIPTS/remove_proposition_target_persona.sh" \
        --proposition "$TEST_PROP_FILE" \
        --persona "$TEST_PERSONA_ID" >/dev/null
      assert_not_contains "$TEST_PROP_FILE" "- $TEST_PERSONA_ID"
      if grep -qE "^Dependencies:.*${TEST_PERSONA_ID}" "$TEST_PROP_FILE"; then
        fail "Dependencies still contain persona ID in $(basename "$TEST_PROP_FILE")"
      fi
      ;;
    add_proposition_related_segment)
      create_bundle "TEST VPD Bundle"
      create_proposition "Segment Proposition"
      "$PM_SCRIPTS/add_proposition_related_segment.sh" --proposition "$TEST_PROP_FILE" --segment "SEG-0001" >/dev/null
      assert_contains "$TEST_PROP_FILE" "- SEG-0001"
      ;;
    remove_proposition_related_segment)
      create_bundle "TEST VPD Bundle"
      create_proposition "Segment Proposition Remove"
      "$PM_SCRIPTS/add_proposition_related_segment.sh" --proposition "$TEST_PROP_FILE" --segment "SEG-0001" >/dev/null
      "$PM_SCRIPTS/remove_proposition_related_segment.sh" --proposition "$TEST_PROP_FILE" --segment "SEG-0001" >/dev/null
      assert_not_contains "$TEST_PROP_FILE" "- SEG-0001"
      ;;
    add_proposition_gain_booster)
      create_bundle "TEST VPD Bundle"
      create_persona "Gain Persona"
      "$PM_SCRIPTS/add_persona_jtbd_item.sh" \
        --persona "$TEST_PERSONA_FILE" \
        --type GAIN \
        --text "Gain clarity" \
        --importance 4 >/dev/null
      gain_id="$(last_table_id 'JTBD-GAIN-[0-9]{4}-PER-[0-9]{4}' "$TEST_PERSONA_FILE")"
      [[ -n "$gain_id" ]] || fail "missing gain ID"
      create_proposition "Gain Proposition"
      "$PM_SCRIPTS/add_proposition_gain_booster.sh" \
        --proposition "$TEST_PROP_FILE" \
        --booster "Boost progress" \
        --mapped-gains "$gain_id" >/dev/null
      boost_id="$(last_table_id 'BOOST-[0-9]{4}-PROP-[0-9]{4}' "$TEST_PROP_FILE")"
      [[ -n "$boost_id" ]] || fail "missing booster ID"
      assert_contains "$TEST_PROP_FILE" "$boost_id"
      assert_contains "$TEST_PROP_FILE" "Boost progress"
      assert_contains "$TEST_PROP_FILE" "$gain_id"
      ;;
    update_proposition_gain_booster)
      create_bundle "TEST VPD Bundle"
      create_persona "Gain Persona Update"
      "$PM_SCRIPTS/add_persona_jtbd_item.sh" \
        --persona "$TEST_PERSONA_FILE" \
        --type GAIN \
        --text "Gain one" \
        --importance 3 >/dev/null
      gain_id_one="$(last_table_id 'JTBD-GAIN-[0-9]{4}-PER-[0-9]{4}' "$TEST_PERSONA_FILE")"
      "$PM_SCRIPTS/add_persona_jtbd_item.sh" \
        --persona "$TEST_PERSONA_FILE" \
        --type GAIN \
        --text "Gain two" \
        --importance 4 >/dev/null
      gain_id_two="$(last_table_id 'JTBD-GAIN-[0-9]{4}-PER-[0-9]{4}' "$TEST_PERSONA_FILE")"
      create_proposition "Gain Proposition Update"
      "$PM_SCRIPTS/add_proposition_gain_booster.sh" \
        --proposition "$TEST_PROP_FILE" \
        --booster "Initial booster" \
        --mapped-gains "$gain_id_one" >/dev/null
      boost_id="$(last_table_id 'BOOST-[0-9]{4}-PROP-[0-9]{4}' "$TEST_PROP_FILE")"
      "$PM_SCRIPTS/update_proposition_gain_booster.sh" \
        --proposition "$TEST_PROP_FILE" \
        --booster-id "$boost_id" \
        --booster "Updated booster" \
        --mapped-gains "$gain_id_two" >/dev/null
      assert_contains "$TEST_PROP_FILE" "Updated booster"
      assert_contains "$TEST_PROP_FILE" "$gain_id_two"
      ;;
    add_proposition_pain_reliever)
      create_bundle "TEST VPD Bundle"
      create_persona "Pain Persona"
      "$PM_SCRIPTS/add_persona_jtbd_item.sh" \
        --persona "$TEST_PERSONA_FILE" \
        --type PAIN \
        --text "Reduce friction" \
        --importance 4 >/dev/null
      pain_id="$(last_table_id 'JTBD-PAIN-[0-9]{4}-PER-[0-9]{4}' "$TEST_PERSONA_FILE")"
      [[ -n "$pain_id" ]] || fail "missing pain ID"
      create_proposition "Pain Proposition"
      "$PM_SCRIPTS/add_proposition_pain_reliever.sh" \
        --proposition "$TEST_PROP_FILE" \
        --reliever "Relieve friction" \
        --mapped-pains "$pain_id" >/dev/null
      rel_id="$(last_table_id 'REL-[0-9]{4}-PROP-[0-9]{4}' "$TEST_PROP_FILE")"
      [[ -n "$rel_id" ]] || fail "missing reliever ID"
      assert_contains "$TEST_PROP_FILE" "$rel_id"
      assert_contains "$TEST_PROP_FILE" "Relieve friction"
      assert_contains "$TEST_PROP_FILE" "$pain_id"
      ;;
    update_proposition_pain_reliever)
      create_bundle "TEST VPD Bundle"
      create_persona "Pain Persona Update"
      "$PM_SCRIPTS/add_persona_jtbd_item.sh" \
        --persona "$TEST_PERSONA_FILE" \
        --type PAIN \
        --text "Pain one" \
        --importance 3 >/dev/null
      pain_id_one="$(last_table_id 'JTBD-PAIN-[0-9]{4}-PER-[0-9]{4}' "$TEST_PERSONA_FILE")"
      "$PM_SCRIPTS/add_persona_jtbd_item.sh" \
        --persona "$TEST_PERSONA_FILE" \
        --type PAIN \
        --text "Pain two" \
        --importance 4 >/dev/null
      pain_id_two="$(last_table_id 'JTBD-PAIN-[0-9]{4}-PER-[0-9]{4}' "$TEST_PERSONA_FILE")"
      create_proposition "Pain Proposition Update"
      "$PM_SCRIPTS/add_proposition_pain_reliever.sh" \
        --proposition "$TEST_PROP_FILE" \
        --reliever "Initial reliever" \
        --mapped-pains "$pain_id_one" >/dev/null
      rel_id="$(last_table_id 'REL-[0-9]{4}-PROP-[0-9]{4}' "$TEST_PROP_FILE")"
      "$PM_SCRIPTS/update_proposition_pain_reliever.sh" \
        --proposition "$TEST_PROP_FILE" \
        --reliever-id "$rel_id" \
        --reliever "Updated reliever" \
        --mapped-pains "$pain_id_two" >/dev/null
      assert_contains "$TEST_PROP_FILE" "Updated reliever"
      assert_contains "$TEST_PROP_FILE" "$pain_id_two"
      ;;
    add_proposition_capability)
      create_bundle "TEST VPD Bundle"
      create_proposition "Capability Proposition"
      "$PM_SCRIPTS/add_proposition_capability.sh" \
        --proposition "$TEST_PROP_FILE" \
        --type feature \
        --capability "Capability A" >/dev/null
      cap_id="$(last_table_id 'CAP-[0-9]{4}-PROP-[0-9]{4}' "$TEST_PROP_FILE")"
      [[ -n "$cap_id" ]] || fail "missing capability ID"
      assert_contains "$TEST_PROP_FILE" "$cap_id"
      assert_contains "$TEST_PROP_FILE" "Capability A"
      ;;
    update_proposition_capability)
      create_bundle "TEST VPD Bundle"
      create_proposition "Capability Proposition Update"
      "$PM_SCRIPTS/add_proposition_capability.sh" \
        --proposition "$TEST_PROP_FILE" \
        --type feature \
        --capability "Capability base" >/dev/null
      cap_id="$(last_table_id 'CAP-[0-9]{4}-PROP-[0-9]{4}' "$TEST_PROP_FILE")"
      "$PM_SCRIPTS/update_proposition_capability.sh" \
        --proposition "$TEST_PROP_FILE" \
        --capability-id "$cap_id" \
        --type experience \
        --capability "Updated capability" >/dev/null
      assert_contains "$TEST_PROP_FILE" "| $cap_id | experience | Updated capability |"
      ;;
    update_proposition_formal_pitch)
      create_bundle "TEST VPD Bundle"
      create_proposition "Formal Pitch Proposition"
      pitch="Updated formal pitch for testing."
      "$PM_SCRIPTS/update_proposition_formal_pitch.sh" --proposition "$TEST_PROP_FILE" --pitch "$pitch" >/dev/null
      assert_contains "$TEST_PROP_FILE" "$pitch"
      ;;
    add_proposition_note)
      create_bundle "TEST VPD Bundle"
      create_proposition "Note Proposition"
      note="Proposition note entry"
      "$PM_SCRIPTS/add_proposition_note.sh" --proposition "$TEST_PROP_FILE" --note "$note" >/dev/null
      assert_contains "$TEST_PROP_FILE" "$note"
      ;;
    overwrite_proposition_notes)
      create_bundle "TEST VPD Bundle"
      create_proposition "Note Proposition Overwrite"
      notes_file="$(mktemp)"
      register_cleanup "$notes_file"
      cat >"$notes_file" <<'EOF'
- Prop note A
- Prop note B
EOF
      "$PM_SCRIPTS/overwrite_proposition_notes.sh" --proposition "$TEST_PROP_FILE" --notes-file "$notes_file" >/dev/null
      assert_contains "$TEST_PROP_FILE" "Prop note A"
      ;;
    product-marketing-domain-done-score)
      create_bundle "TEST VPD Bundle"
      create_persona "Done Score Persona"
      "$PM_SCRIPTS/product-marketing-domain-done-score.sh" \
        --docs-root "$TEST_BUNDLE_DIR" \
        --input-research-root "$RESEARCH_DOCS" \
        --min-score 0 \
        --quiet
      ;;
    product-marketing-domain-done-score-deterministic)
      create_bundle "TEST VPD Bundle"
      create_persona "Done Score Persona"
      create_proposition "Done Score Proposition"
      out1="$(env LC_ALL=C LANG=C TZ=UTC "$PM_SCRIPTS/product-marketing-domain-done-score.sh" \
        --docs-root "$TEST_BUNDLE_DIR" \
        --input-research-root "$RESEARCH_DOCS" \
        --min-score 0)" || fail "done-score run 1 failed"
      out2="$(env LC_ALL=C LANG=C TZ=UTC "$PM_SCRIPTS/product-marketing-domain-done-score.sh" \
        --docs-root "$TEST_BUNDLE_DIR" \
        --input-research-root "$RESEARCH_DOCS" \
        --min-score 0)" || fail "done-score run 2 failed"
      printf "%s\n" "$out1" | grep -qE 'Overall: [0-9]+[.][0-9]{2}' \
        || fail "expected overall score formatted to 2 decimals"
      [[ "$out1" == "$out2" ]] || fail "done-score output not deterministic across runs"
      ;;
    *)
      fail "unknown test name: $name"
      ;;
  esac

  echo "OK: product-marketing test passed (${name})."
}
