ID: PROP-0015
Title: Guided Return Rituals
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001, PER-0001, PER-0003, RA-001, PITCH-0001
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Guided return rituals help casual and in-chat players re-enter the colony after time away. It provides clear recaps and a single next step to reduce friction. The proposition makes returning feel rewarding instead of stressful.

## Target Persona(s)

```text
[V-SCRIPT]:
add_proposition_target_persona.sh
remove_proposition_target_persona.sh
```

- PER-0001

- PER-0003

## Related Segment(s)

```text
[V-SCRIPT]:
add_proposition_related_segment.sh
remove_proposition_related_segment.sh
```

- SEG-0001

- SEG-0003

## Gain Boosters

```text
[V-SCRIPT]:
add_proposition_gain_booster.sh
update_proposition_gain_booster.sh
```

MappedGainIDs is an array encoded as a comma-separated list of JTBD IDs.

| BoosterID | Booster | MappedGainIDs[] |
|---|---|---|
| BOOST-0001-PROP-0015 | Return recaps celebrate what happened while away in a calm tone. They make progress feel earned without pressure. This boosts relaxed re-entry. | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0005-PER-0001 |
| BOOST-0002-PROP-0015 | A single suggested action helps explorers resume without thinking hard. It keeps the chat flow intact. This boosts frictionless access. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0002-PER-0003 |
| BOOST-0003-PROP-0015 | Return rituals include a small reward to mark the comeback. It makes re-entry feel pleasant rather than obligatory. This boosts motivation and trust. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0003-PER-0001 |
| BOOST-0004-PROP-0015 | Short recap stories highlight new colony changes in a shareable way. They make returning feel interesting and social. This boosts novelty and engagement. | JTBD-GAIN-0005-PER-0003, JTBD-GAIN-0006-PER-0003 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0015 | Guided returns prevent guilt about time away by framing progress positively. They reassure players that absence is okay. This relieves pressure. | JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0005-PER-0001 |
| REL-0002-PROP-0015 | A single next step reduces confusion after time away. It keeps re-entry simple and calm. This relieves overwhelm. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0006-PER-0003 |
| REL-0003-PROP-0015 | Recap stories prevent the experience from feeling stale. They surface new changes and keep things fresh. This relieves repetition fatigue. | JTBD-PAIN-0004-PER-0001, JTBD-PAIN-0005-PER-0003 |
| REL-0004-PROP-0015 | Return rituals keep the conversation in chat without forcing a web visit. They maintain immersion for explorers. This relieves context-switching friction. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0006-PER-0003 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0015 | experience | A return ritual flow that presents a recap and one next step. It keeps re-entry calm and focused. This supports relaxed continuity. |
| CAP-0002-PROP-0015 | feature | A recap card that summarizes offline progress in plain language. It keeps the return moment short and friendly. This supports clarity. |
| CAP-0003-PROP-0015 | function | A suggested-action selector that picks the most useful next step. It reduces decision fatigue after time away. This supports smooth re-entry. |
| CAP-0004-PROP-0015 | standard | A re-entry cadence standard that avoids guilt-based reminders. It keeps return messaging gentle and optional. This supports the stress-free promise. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



