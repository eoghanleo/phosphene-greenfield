ID: PROP-0008
Title: AI Tutor & Conversational Control
Status: Draft
Updated: 2026-01-11
Dependencies: PER-0003, RA-001, PITCH-0002
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/virric/product-marketing/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Our AI tutor proposition helps ChatGPT power-users learn and steer the simulation by delivering real-time explanations and conversational controls that make the AI layer genuinely useful.

## Target Persona(s)

```text
[V-SCRIPT]:
add_proposition_target_persona.sh
remove_proposition_target_persona.sh
```


- PER-0003

## Related Segment(s)

```text
[V-SCRIPT]:
add_proposition_related_segment.sh
remove_proposition_related_segment.sh
```


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
| BOOST-0001-PROP-0008 | Real-time explanations of colony behavior | JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0003-PER-0003 |
| BOOST-0002-PROP-0008 | Conversational control commands that steer the sim | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0002-PER-0003 |
| BOOST-0003-PROP-0008 | Learning nuggets and insights tied to play | JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0004-PER-0003 |
| BOOST-0004-PROP-0008 | Adaptive guidance based on how you play | JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0003-PER-0003 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0008 | AI utility that prevents gimmick feel | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0004-PER-0003 |
| REL-0002-PROP-0008 | Clarity on system behavior to reduce frustration | JTBD-PAIN-0004-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0003-PROP-0008 | Guided prompts that reduce setup friction | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0002-PER-0003 |
| REL-0004-PROP-0008 | Trust signals and transparency about AI limits | JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0004-PER-0003 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0008 | function | Explain-why chat responses for colony behavior |
| CAP-0002-PROP-0008 | feature | Natural language command set for sim control |
| CAP-0003-PROP-0008 | experience | Tutor mode that guides learning goals |
| CAP-0004-PROP-0008 | standard | Transparency about AI limitations and uncertainty |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```

<free-form notes>

