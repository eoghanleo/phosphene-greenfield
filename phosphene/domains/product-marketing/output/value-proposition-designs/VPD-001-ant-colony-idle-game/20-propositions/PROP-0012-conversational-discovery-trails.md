ID: PROP-0012
Title: Conversational Discovery Trails
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001, PER-0003, RA-001, PITCH-0003
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Conversational discovery trails guide in-chat explorers through small, shareable discoveries using AI prompts. It turns questions into playful progress without leaving the thread. The proposition keeps novelty and guidance tightly linked.

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
| BOOST-0001-PROP-0012 | AI prompts reveal a new ant behavior after each question. It keeps curiosity high without long sessions. This boosts novelty and engagement. | JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0005-PER-0003 |
| BOOST-0002-PROP-0012 | Trail summaries show what was learned in chat in a single line. They make progress easy to share and remember. This boosts conversational continuity. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0006-PER-0003 |
| BOOST-0003-PROP-0012 | Questions guide players toward quick wins that show immediate progress. It keeps the loop satisfying without extra complexity. This boosts short-session achievement. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0003-PER-0003 |
| BOOST-0004-PROP-0012 | Trail checkpoints reinforce that the colony state is saved after each discovery. It reassures players that progress persists. This boosts trust and continuity. | JTBD-GAIN-0003-PER-0003, JTBD-GAIN-0004-PER-0003 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0012 | Conversational prompts reduce the feeling that AI is a gimmick by making it useful. They show tangible effects on the colony. This relieves skepticism. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0002-PER-0003 |
| REL-0002-PROP-0012 | Trail checkpoints show that state is saved after each interaction. They reduce fear of progress loss. This relieves persistence anxiety. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0003-PER-0003 |
| REL-0003-PROP-0012 | Trail prompts keep novelty from fading by surfacing new topics to explore. They prevent the experience from feeling static. This relieves boredom and churn. | JTBD-PAIN-0004-PER-0003, JTBD-PAIN-0005-PER-0003 |
| REL-0004-PROP-0012 | Chat-native discovery avoids the need to leave the thread to learn more. It keeps the flow intact. This relieves context-switching friction. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0006-PER-0003 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0012 | feature | A discovery prompt stream that surfaces questions and prompts in chat. It keeps exploration guided and light. This supports curiosity. |
| CAP-0002-PROP-0012 | function | A trail summary that condenses discoveries into a single shareable line. It keeps the conversation cohesive. This supports sharing. |
| CAP-0003-PROP-0012 | experience | A conversational trail experience that links questions to immediate colony changes. It makes AI guidance tangible. This supports trust in the assistant. |
| CAP-0004-PROP-0012 | standard | A trail checkpoint standard that confirms persistence after each discovery. It keeps trust signals visible. This supports continuity. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



