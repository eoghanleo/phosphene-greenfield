ID: PROP-0002
Title: Cozy Offline Check-In Loop
Status: Draft
Updated: 2026-01-11
Dependencies: PER-0001, RA-001, PITCH-0001, PER-0002
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/virric/product-marketing/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Our cozy offline check-in experience helps casual idle players who want stress-free progress in minutes by reducing overwhelm, repetition, and uncertainty while boosting relaxing, meaningful progress. We achieve this by summarizing offline gains, surfacing short goals, and celebrating small wins with gentle, charming feedback.

## Target Persona(s)

```text
[V-SCRIPT]:
add_proposition_target_persona.sh
remove_proposition_target_persona.sh
```



- PER-0001
- PER-0002

## Related Segment(s)

```text
[V-SCRIPT]:
add_proposition_related_segment.sh
remove_proposition_related_segment.sh
```



- SEG-0001
- SEG-0002

## Gain Boosters

```text
[V-SCRIPT]:
add_proposition_gain_booster.sh
update_proposition_gain_booster.sh
```

MappedGainIDs is an array encoded as a comma-separated list of JTBD IDs.

| BoosterID | Booster | MappedGainIDs[] |
|---|---|---|
| BOOST-0001-PROP-0002 | Meaningful offline summaries that show real growth. | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0004-PER-0001 |
| BOOST-0002-PROP-0002 | Cozy, low-pressure tone and visuals. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0005-PER-0001 |
| BOOST-0003-PROP-0002 | Clear next-step guidance that keeps sessions short. | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0004-PER-0001 |
| BOOST-0004-PROP-0002 | Quick check-ins that still feel rewarding. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0003-PER-0001 |
| BOOST-0005-PROP-0002 | Gentle streak rewards that reinforce habits. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0003-PER-0001 |
| BOOST-0006-PROP-0002 | Quick strategy recap for returning players. | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0004-PER-0002, JTBD-GAIN-0005-PER-0002 |
| BOOST-0007-PROP-0002 | Check-in decision recommendations for deeper play. | JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0004-PER-0001, JTBD-GAIN-0005-PER-0002 |
| BOOST-0008-PROP-0002 | Two-mode check-in (quick vs deep). | JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0004-PER-0001, JTBD-GAIN-0004-PER-0002, JTBD-GAIN-0005-PER-0002 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0002 | Gentle onboarding that avoids early overwhelm. | JTBD-PAIN-0001-PER-0001, JTBD-PAIN-0002-PER-0001 |
| REL-0002-PROP-0002 | Pacing tune-ups that prevent progress stalls. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0005-PER-0001 |
| REL-0003-PROP-0002 | Rotating surprises to fight repetition. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0004-PER-0001 |
| REL-0004-PROP-0002 | Clear offline gain receipts so progress feels real. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0005-PER-0001 |
| REL-0005-PROP-0002 | Skip-and-queue controls to reduce repetition. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0004-PER-0001 |
| REL-0006-PROP-0002 | Explain hidden mechanics in the check-in summary. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0005-PER-0001, JTBD-PAIN-0005-PER-0002 |
| REL-0007-PROP-0002 | Optional deep-dive toggle to avoid overwhelm. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0003-PER-0002, JTBD-PAIN-0004-PER-0001 |
| REL-0008-PROP-0002 | Selectable complexity reduces overwhelm. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0003-PER-0002, JTBD-PAIN-0004-PER-0001, JTBD-PAIN-0005-PER-0001, JTBD-PAIN-0005-PER-0002 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0002 | feature | Offline progress summary cards |
| CAP-0002-PROP-0002 | function | Quick upgrade recommendations |
| CAP-0003-PROP-0002 | experience | Cozy visual/audio feedback loops |
| CAP-0004-PROP-0002 | feature | Short-session goal cards |
| CAP-0005-PROP-0002 | feature | Daily check-in streak tracker |
| CAP-0006-PROP-0002 | feature | Strategy recap digest |
| CAP-0007-PROP-0002 | feature | Deep-dive toggle controls |
| CAP-0008-PROP-0002 | feature | Quick/deep toggle preset |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```

- Packaging: keep check-in loop under 5 minutes; surface exit cues.
- Risk: streak mechanics can feel pressuring if rewards are too strong.
- Edge: offline progress requires clear caps to avoid balance exploits.

