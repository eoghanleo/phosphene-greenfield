ID: PROP-0001
Title: Fair Progress Economy
Status: Draft
Updated: 2026-01-11
Dependencies: PER-0001, PER-0002, RA-001, PITCH-0001, PITCH-0003
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/virric/product-marketing/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Our fairness-first economy and transparency standards help casual idle and strategy-focused players who want satisfying progress without coercion by reducing paywall pressure and pacing stalls while boosting trust, clarity, and meaningful offline gains. We achieve this by making earn rates and tradeoffs visible, protecting core progression from pay-to-win tuning, and reinforcing progress with honest feedback loops.

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
| BOOST-0001-PROP-0001 | Transparent earn rates with offline summaries. | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0004-PER-0001, JTBD-GAIN-0004-PER-0002 |
| BOOST-0002-PROP-0001 | Fair optional spend framing that never blocks core progress. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0003-PER-0002 |
| BOOST-0003-PROP-0001 | Milestone mastery rewards for smart strategy. | JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0003-PER-0001 |
| BOOST-0004-PROP-0001 | Cozy progress feedback that feels rewarding. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0005-PER-0001 |
| BOOST-0005-PROP-0001 | Visible milestone roadmap that reinforces progress. | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0004-PER-0002 |
| BOOST-0006-PROP-0001 | Balanced upgrade tradeoffs that feel fair. | JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0004-PER-0002 |
| BOOST-0007-PROP-0001 | Economy trust signals that reward consistency. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0003-PER-0002 |
| BOOST-0008-PROP-0001 | Fairness callouts in milestone summaries. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0003-PER-0002, JTBD-GAIN-0004-PER-0002 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0001 | Remove coercive paywalls and limit aggressive monetization. | JTBD-PAIN-0001-PER-0001, JTBD-PAIN-0002-PER-0002 |
| REL-0002-PROP-0001 | Smooth early pacing and clarify next steps. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0005-PER-0002 |
| REL-0003-PROP-0001 | Prevent late-game stalls with tuned progression ramps. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0003-PER-0002 |
| REL-0004-PROP-0001 | Rotate lightweight goals to avoid repetitive loops. | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0004-PER-0001 |
| REL-0005-PROP-0001 | Pricing transparency to reduce distrust. | JTBD-PAIN-0001-PER-0001, JTBD-PAIN-0002-PER-0002 |
| REL-0006-PROP-0001 | Cap spend pressure to avoid coercion. | JTBD-PAIN-0001-PER-0001, JTBD-PAIN-0002-PER-0002, JTBD-PAIN-0003-PER-0001 |
| REL-0007-PROP-0001 | Transparent upgrade impacts to avoid confusion. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0004-PER-0001, JTBD-PAIN-0005-PER-0002 |
| REL-0008-PROP-0001 | Expose monetization odds and upgrade impacts. | JTBD-PAIN-0001-PER-0001, JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0002-PER-0002, JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0005-PER-0002 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0001 | function | Progression transparency dashboard |
| CAP-0002-PROP-0001 | standard | Fairness guardrails for monetization tuning |
| CAP-0003-PROP-0001 | experience | Offline progress recap and goal nudges |
| CAP-0004-PROP-0001 | function | Progression tuning knobs for pacing balance |
| CAP-0005-PROP-0001 | feature | Pricing disclosure panel |
| CAP-0006-PROP-0001 | feature | Economy audit log |
| CAP-0007-PROP-0001 | function | Fairness preset profiles |
| CAP-0008-PROP-0001 | feature | Economy transparency glossary |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```

- Packaging: offer transparent economy settings upfront and repeat during upgrades.
- Risk: fairness promises must be backed by pacing telemetry to avoid distrust.
- Edge: competitive events can reintroduce pay-to-win perceptions if rewards are unbalanced.

