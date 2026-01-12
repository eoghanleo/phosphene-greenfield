#!/usr/bin/env bash
set -euo pipefail

# ROOT-ONLY TEMP TEST SCRIPT (not part of final build)
# Chains the full <product-marketing> script lifecycle and culminates in strict validation.

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

fail() { echo "FAIL: $*" >&2; exit 1; }

cleanup_files=()
cleanup() {
  for f in "${cleanup_files[@]:-}"; do
    [[ -n "${f:-}" ]] || continue
    [[ -e "$f" ]] || continue
    rm -rf "$f" || true
  done
}
trap cleanup EXIT

PERSONA_DIR="$ROOT/phosphene/domains/product-marketing/docs/personas"
PROP_DIR="$ROOT/phosphene/domains/product-marketing/docs/propositions"
mkdir -p "$PERSONA_DIR" "$PROP_DIR"

echo "--- registry validate (pre) ---"
"$ROOT/phosphene/phosphene-core/bin/phosphene" id validate >/dev/null

echo "--- create persona ---"
per_out_line="$("$ROOT/phosphene/domains/product-marketing/scripts/create_new_persona.sh" \
  --title "TEST Persona Lifecycle" \
  --owner "lifecycle-test" \
  --status Draft \
  --dependencies "" \
  --output-dir "$PERSONA_DIR" \
  | tail -n 1
)"
PER_FILE="${per_out_line#Created persona: }"
[[ -f "$PER_FILE" ]] || fail "persona not created: $PER_FILE"
cleanup_files+=("$PER_FILE")
PER_ID="$(grep -E '^ID:[[:space:]]*PER-[0-9]{4}[[:space:]]*$' "$PER_FILE" | head -n 1 | sed -E 's/^ID:[[:space:]]*//; s/[[:space:]]*$//')"
[[ -n "${PER_ID:-}" ]] || fail "failed to extract PER ID from persona header"

echo "--- persona: update snapshot summary ---"
SUMMARY_FILE="$(mktemp)"
cleanup_files+=("$SUMMARY_FILE")
cat >"$SUMMARY_FILE" <<'EOF'
- Test summary bullet A
- Test summary bullet B
EOF
"$ROOT/phosphene/domains/product-marketing/scripts/update_persona_summary.sh" --persona "$PER_FILE" --summary-file "$SUMMARY_FILE" >/dev/null

echo "--- persona: add JTBD items (JOB/PAIN/GAIN) ---"
"$ROOT/phosphene/domains/product-marketing/scripts/add_persona_jtbd_item.sh" --persona "$PER_FILE" --type JOB --text "Progress without babysitting" --importance 5 >/dev/null
"$ROOT/phosphene/domains/product-marketing/scripts/add_persona_jtbd_item.sh" --persona "$PER_FILE" --type PAIN --text "Upgrades feel opaque and grindy" --importance 4 >/dev/null
"$ROOT/phosphene/domains/product-marketing/scripts/add_persona_jtbd_item.sh" --persona "$PER_FILE" --type GAIN --text "Clear next best action" --importance 4 >/dev/null

JOB_ID="$(grep -oE 'JTBD-JOB-[0-9]{4}-PER-[0-9]{4}' "$PER_FILE" | head -n 1 || true)"
PAIN_ID="$(grep -oE 'JTBD-PAIN-[0-9]{4}-PER-[0-9]{4}' "$PER_FILE" | head -n 1 || true)"
GAIN_ID="$(grep -oE 'JTBD-GAIN-[0-9]{4}-PER-[0-9]{4}' "$PER_FILE" | head -n 1 || true)"
[[ -n "$JOB_ID" && -n "$PAIN_ID" && -n "$GAIN_ID" ]] || fail "failed to extract JTBD IDs from persona"

echo "--- persona: update one JTBD item ---"
"$ROOT/phosphene/domains/product-marketing/scripts/update_persona_jtbd_item.sh" --persona "$PER_FILE" --jtbd-id "$GAIN_ID" --text "Obvious ‘why’ behind recommendations" --importance 5 >/dev/null

echo "--- persona: add evidence + links + notes ---"
"$ROOT/phosphene/domains/product-marketing/scripts/add_persona_evidence_link.sh" --persona "$PER_FILE" --id "E-0001" >/dev/null
"$ROOT/phosphene/domains/product-marketing/scripts/add_persona_evidence_link.sh" --persona "$PER_FILE" --id "CPE-0001" >/dev/null
"$ROOT/phosphene/domains/product-marketing/scripts/add_persona_evidence_link.sh" --persona "$PER_FILE" --id "RA-001" >/dev/null
"$ROOT/phosphene/domains/product-marketing/scripts/add_persona_related_link.sh" --persona "$PER_FILE" --link "phosphene/domains/research/docs/research-assessments/RA-001-ant-colony-idle-game/40-hypotheses.md" >/dev/null
"$ROOT/phosphene/domains/product-marketing/scripts/add_persona_note.sh" --persona "$PER_FILE" --note "This is a lifecycle test note." >/dev/null

NOTES_FILE="$(mktemp)"
cleanup_files+=("$NOTES_FILE")
cat >"$NOTES_FILE" <<'EOF'
- Free-form note A
- Free-form note B
EOF
"$ROOT/phosphene/domains/product-marketing/scripts/overwrite_persona_notes.sh" --persona "$PER_FILE" --notes-file "$NOTES_FILE" >/dev/null

echo "--- persona: strict validate ---"
"$ROOT/phosphene/domains/product-marketing/scripts/validate_persona.sh" --strict "$PER_FILE" >/dev/null

echo "--- create proposition ---"
prop_out_line="$("$ROOT/phosphene/domains/product-marketing/scripts/create_new_proposition.sh" \
  --title "TEST Proposition Lifecycle" \
  --owner "lifecycle-test" \
  --status Draft \
  --dependencies "" \
  --output-dir "$PROP_DIR" \
  | tail -n 1
)"
PROP_FILE="${prop_out_line#Created proposition: }"
[[ -f "$PROP_FILE" ]] || fail "proposition not created: $PROP_FILE"
cleanup_files+=("$PROP_FILE")

echo "--- proposition: target persona + segments ---"
"$ROOT/phosphene/domains/product-marketing/scripts/add_proposition_target_persona.sh" --proposition "$PROP_FILE" --persona "$PER_ID" >/dev/null
"$ROOT/phosphene/domains/product-marketing/scripts/add_proposition_related_segment.sh" --proposition "$PROP_FILE" --segment "SEG-0001" >/dev/null

echo "--- proposition: add mapped boosters/relievers/capabilities ---"
"$ROOT/phosphene/domains/product-marketing/scripts/add_proposition_gain_booster.sh" --proposition "$PROP_FILE" --booster "Faster meaningful progress" --mapped-gains "$GAIN_ID" >/dev/null
"$ROOT/phosphene/domains/product-marketing/scripts/add_proposition_pain_reliever.sh" --proposition "$PROP_FILE" --reliever "Transparent upgrade rationale" --mapped-pains "$PAIN_ID" >/dev/null
"$ROOT/phosphene/domains/product-marketing/scripts/add_proposition_capability.sh" --proposition "$PROP_FILE" --type feature --capability "Recommend next best upgrade" >/dev/null

BOOST_ID="$(grep -oE 'BOOST-[0-9]{4}-PROP-[0-9]{4}' "$PROP_FILE" | head -n 1 || true)"
REL_ID="$(grep -oE 'REL-[0-9]{4}-PROP-[0-9]{4}' "$PROP_FILE" | head -n 1 || true)"
CAP_ID="$(grep -oE 'CAP-[0-9]{4}-PROP-[0-9]{4}' "$PROP_FILE" | head -n 1 || true)"
[[ -n "$BOOST_ID" && -n "$REL_ID" && -n "$CAP_ID" ]] || fail "failed to extract proposition row IDs"

echo "--- proposition: update rows + formal pitch + notes ---"
"$ROOT/phosphene/domains/product-marketing/scripts/update_proposition_gain_booster.sh" --proposition "$PROP_FILE" --booster-id "$BOOST_ID" --booster "Even faster progress" --mapped-gains "$GAIN_ID" >/dev/null
"$ROOT/phosphene/domains/product-marketing/scripts/update_proposition_pain_reliever.sh" --proposition "$PROP_FILE" --reliever-id "$REL_ID" --reliever "Explain why each upgrade matters" --mapped-pains "$PAIN_ID" >/dev/null
"$ROOT/phosphene/domains/product-marketing/scripts/update_proposition_capability.sh" --proposition "$PROP_FILE" --capability-id "$CAP_ID" --type feature --capability "Explain upgrade impacts" >/dev/null

"$ROOT/phosphene/domains/product-marketing/scripts/update_proposition_formal_pitch.sh" --proposition "$PROP_FILE" --pitch "Our capabilities help $PER_ID who want to $JOB_ID by reducing $PAIN_ID and boosting $GAIN_ID. We achieve this by $REL_ID and delivering $BOOST_ID." >/dev/null

"$ROOT/phosphene/domains/product-marketing/scripts/add_proposition_note.sh" --proposition "$PROP_FILE" --note "Lifecycle test note." >/dev/null

PROP_NOTES_FILE="$(mktemp)"
cleanup_files+=("$PROP_NOTES_FILE")
cat >"$PROP_NOTES_FILE" <<'EOF'
- Prop notes A
- Prop notes B
EOF
"$ROOT/phosphene/domains/product-marketing/scripts/overwrite_proposition_notes.sh" --proposition "$PROP_FILE" --notes-file "$PROP_NOTES_FILE" >/dev/null

echo "--- proposition: strict validate ---"
"$ROOT/phosphene/domains/product-marketing/scripts/validate_proposition.sh" --strict "$PROP_FILE" >/dev/null

echo "OK: product-marketing lifecycle test passed (strict)."

