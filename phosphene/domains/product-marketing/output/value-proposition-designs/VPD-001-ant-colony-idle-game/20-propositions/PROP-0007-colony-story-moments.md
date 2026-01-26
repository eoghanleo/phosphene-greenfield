ID: PROP-0007
Title: Colony Story Moments
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

Colony story moments turn progress into shareable micro-narratives for casual and in-chat players. It delivers quick, charming beats that make the colony feel alive. The proposition keeps novelty high without long sessions.

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
| BOOST-0001-PROP-0007 | Short narrative beats highlight quirky ant events after each check-in. They make progress feel charming and memorable. This boosts visual delight and novelty. | JTBD-GAIN-0004-PER-0001, JTBD-GAIN-0005-PER-0003 |
| BOOST-0002-PROP-0007 | Story cards include a one-line summary that can be dropped into chat. They make sharing effortless and fun. This boosts social engagement. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0006-PER-0003 |
| BOOST-0003-PROP-0007 | Milestone stories celebrate progress without adding complexity. They give casual players a sense of achievement quickly. This boosts calm satisfaction. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0003-PER-0001 |
| BOOST-0004-PROP-0007 | Story moments tie back to colony visuals so progress looks tangible. They reinforce the sense that the colony is alive. This boosts emotional connection and retention. | JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0004-PER-0001 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0007 | Narrative beats keep the loop from feeling repetitive. They inject variety without extra effort. This relieves boredom for casuals and explorers. | JTBD-PAIN-0004-PER-0001, JTBD-PAIN-0005-PER-0003 |
| REL-0002-PROP-0007 | Story prompts reduce the need to leave chat to share progress. They keep the experience conversational. This relieves context-switching friction. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0006-PER-0003 |
| REL-0003-PROP-0007 | Milestone stories explain why upgrades matter, reducing decision anxiety. They give meaning without heavy tutorials. This relieves confusion for casual players. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0007-PER-0001 |
| REL-0004-PROP-0007 | Story recaps soften the guilt of time away by showing progress while offline. They keep re-entry friendly and calm. This relieves pressure from absence. | JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0005-PER-0001 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0007 | feature | Story cards that summarize a colony moment in one line. They make sharing quick and easy. This supports social play. |
| CAP-0002-PROP-0007 | experience | A narrative recap at the end of each short session. It turns progress into a tiny story beat. This keeps the loop delightful. |
| CAP-0003-PROP-0007 | function | A milestone narrator that links upgrades to small story events. It clarifies why a change matters without heavy tutorials. This supports gentle guidance. |
| CAP-0004-PROP-0007 | feature | Visual story highlights that tie narrative beats to colony changes. They keep the theme charming and alive. This supports visual delight. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



