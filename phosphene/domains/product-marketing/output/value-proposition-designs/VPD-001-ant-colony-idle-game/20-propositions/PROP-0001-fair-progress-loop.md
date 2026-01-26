ID: PROP-0001
Title: Fair Progress Loop
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001, PER-0001, RA-001, PITCH-0001
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Our fair progress loop helps relaxed idle gamers trust the economy while still feeling meaningful progress in short sessions. It emphasizes transparent, optional monetization and steady pacing so players feel in control of their time and budget. The result is a calm idle experience that rewards check-ins without pressure.

## Target Persona(s)

```text
[V-SCRIPT]:
add_proposition_target_persona.sh
remove_proposition_target_persona.sh
```

- PER-0001

## Related Segment(s)

```text
[V-SCRIPT]:
add_proposition_related_segment.sh
remove_proposition_related_segment.sh
```

- SEG-0001

## Gain Boosters

```text
[V-SCRIPT]:
add_proposition_gain_booster.sh
update_proposition_gain_booster.sh
```

MappedGainIDs is an array encoded as a comma-separated list of JTBD IDs.

| BoosterID | Booster | MappedGainIDs[] |
|---|---|---|
| BOOST-0001-PROP-0001 | A transparent value ladder shows exactly what each optional boost does and how long it lasts. Players can see the incremental impact before they buy, which turns spending into a deliberate choice rather than a gamble. This keeps progress satisfying while reinforcing trust. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0003-PER-0001 |
| BOOST-0002-PROP-0001 | A rich offline summary bundles resources earned and highlights one or two recommended upgrades. The recap creates a mini-reward moment that makes each short session feel complete. It boosts the sense of progress while celebrating time away. | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0005-PER-0001 |
| BOOST-0003-PROP-0001 | Fairness signals call out what is strictly optional and what is core progression. Seeing these guardrails lowers anxiety and lets players relax into the loop. The reassurance makes the experience feel more honest and soothing. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0002-PER-0001 |
| BOOST-0004-PROP-0001 | Cosmetic reward tracks let players earn playful ant skins and colony decorations through normal play. Optional spend simply accelerates access instead of unlocking exclusives, keeping the theme delightful without pressure. This adds charm while maintaining a fair economy. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0004-PER-0001 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0001 | Offers are labeled as optional and bundled into a single, unobtrusive surface. This prevents constant popups and keeps the main loop uninterrupted. The player feels in control instead of coerced. | JTBD-PAIN-0001-PER-0001, JTBD-PAIN-0005-PER-0001 |
| REL-0002-PROP-0001 | Early sessions limit the number of currencies and focus on one upgrade path at a time. A gentle nudge explains why the next upgrade matters so players don’t feel lost. This reduces overwhelm and helps pacing feel steady. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0003-PER-0001 |
| REL-0003-PROP-0001 | Adaptive pacing keeps core progression smooth even if the player doesn’t spend. It adds small goal shifts and bonus events before grind sets in. This prevents the loop from feeling repetitive or stalled. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0004-PER-0001 |
| REL-0004-PROP-0001 | A no-guilt catch-up mode grants a bonus for time away and summarizes what you missed. It reframes absence as progress rather than loss. This removes anxiety about falling behind and keeps the game feeling relaxed. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0005-PER-0001 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0001 | feature | A value ladder panel that explains each optional purchase in plain language with expected impact and duration. The panel is accessible from the main hub so players can review choices without interruption. This makes monetization transparent and easier to trust. |
| CAP-0002-PROP-0001 | function | An offline progress summary that surfaces key gains, resource totals, and a recommended next upgrade. It compresses the return moment into a quick decision. This keeps short sessions feeling productive. |
| CAP-0003-PROP-0001 | function | A pacing guardrail system that injects mini-goals and bonus events before progress stalls. It adapts the cadence based on session length and return frequency. This keeps the loop smooth for non-spenders. |
| CAP-0004-PROP-0001 | standard | A fairness pledge that commits to no paywalls and keeps optional spend clearly separated from core progression. The pledge is reinforced in onboarding and store UI cues. This establishes the expectation of a relaxed, trustworthy economy. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



