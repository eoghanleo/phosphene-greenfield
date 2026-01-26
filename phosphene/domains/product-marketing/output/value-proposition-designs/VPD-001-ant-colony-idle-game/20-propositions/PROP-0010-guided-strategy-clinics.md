ID: PROP-0010
Title: Guided Strategy Clinics
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001, PER-0002, RA-001, PITCH-0002
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Guided strategy clinics help strategists interpret their colony data and refine tactics. It packages learning into short, focused sessions that make experimentation clearer. The proposition turns complexity into actionable insight.

## Target Persona(s)

```text
[V-SCRIPT]:
add_proposition_target_persona.sh
remove_proposition_target_persona.sh
```

- PER-0002

## Related Segment(s)

```text
[V-SCRIPT]:
add_proposition_related_segment.sh
remove_proposition_related_segment.sh
```

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
| BOOST-0001-PROP-0010 | Clinic summaries highlight which changes improved efficiency. They make optimization visible without spreadsheets. This boosts confidence and mastery. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0003-PER-0002 |
| BOOST-0002-PROP-0010 | Experiment prompts suggest targeted tests to run next. They keep discovery structured and rewarding. This boosts emergent learning. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0002-PER-0002 |
| BOOST-0003-PROP-0010 | Decision review sessions show tradeoffs in plain language. They help strategists understand why an outcome occurred. This boosts strategic clarity. | JTBD-GAIN-0003-PER-0002, JTBD-GAIN-0006-PER-0002 |
| BOOST-0004-PROP-0010 | Clinic milestones unlock new strategy levers after demonstrated mastery. They reward sustained experimentation. This boosts long-term engagement. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0004-PER-0002 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0010 | Clinic guidance reduces the pain of opaque metrics. It shows what changed and why. This relieves guesswork. | JTBD-PAIN-0004-PER-0002, JTBD-PAIN-0005-PER-0002 |
| REL-0002-PROP-0010 | Structured clinics keep the sim from feeling shallow by surfacing real depth. They make system layers explicit. This relieves reskin skepticism. | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0004-PER-0002 |
| REL-0003-PROP-0010 | Decision reviews reduce the sense of waiting without control. They explain what to do next rather than letting idle time drag. This relieves hollow loop frustration. | JTBD-PAIN-0005-PER-0002, JTBD-PAIN-0006-PER-0002 |
| REL-0004-PROP-0010 | Clinic pacing avoids overwhelming players with too much data at once. It breaks insights into manageable steps. This relieves cognitive overload. | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0004-PER-0002 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0010 | feature | Clinic summary panels that highlight the most impactful changes. They keep insights concise and actionable. This supports mastery. |
| CAP-0002-PROP-0010 | function | Experiment prompts that recommend targeted tests based on recent data. They encourage learning without guesswork. This supports discovery. |
| CAP-0003-PROP-0010 | experience | A clinic session flow that packages insights into short, focused reviews. It keeps strategists engaged without long analysis. This supports retention. |
| CAP-0004-PROP-0010 | standard | A clinic cadence standard that schedules insights at predictable intervals. It keeps analysis manageable and consistent. This supports strategic focus. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



