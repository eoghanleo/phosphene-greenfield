ID: PROP-0017
Title: In-chat discovery pulses
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001, PER-0003, PER-0001
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

In-chat discovery pulses keep the colony lively for explorers and relaxed idle gamers without pulling them out of conversation. Timed micro-moments deliver a quick surprise, a small payoff, and a clear reason to return. The pulses make novelty feel effortless and social.

## Target Persona(s)

```text
[V-SCRIPT]:
add_proposition_target_persona.sh
remove_proposition_target_persona.sh
```

- PER-0003

- PER-0001

## Related Segment(s)

```text
[V-SCRIPT]:
add_proposition_related_segment.sh
remove_proposition_related_segment.sh
```

- SEG-0003

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
| BOOST-0001-PROP-0017 | Pulse drops deliver quick novelty moments inside chat without breaking the conversation. Each pulse feels like a small surprise worth sharing, which keeps curiosity high. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0005-PER-0003 |
| BOOST-0002-PROP-0017 | Short delight bursts keep sessions soothing while still delivering a tangible sense of progress. The player gets a quick win and a calming payoff in under a minute. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0003-PER-0001 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0017 | Chat-native pulse cards prevent context switching by keeping the experience inside the conversation. The player no longer abandons the thread just to see something new. | JTBD-PAIN-0001-PER-0003 |
| REL-0002-PROP-0017 | Rotating micro-discoveries break the sense that every check-in is the same. They give players a fresh hook so novelty does not fade after the first week. | JTBD-PAIN-0004-PER-0001, JTBD-PAIN-0005-PER-0003 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0017 | feature | Discovery pulse deck that drops a new ant fact, animation, or mini-challenge on a timed cadence. Each pulse is small enough for chat but still tied to colony progress. |
| CAP-0002-PROP-0017 | experience | Share-ready recap prompt that formats the pulse as a short chat message with a visual hook. It makes it easy to comment or react without leaving the thread. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



- 2026-01-26T13:00:29Z: Keep the pulse cadence flexible so the player can opt into fewer or more moments. The sense of control should prevent the experience from feeling spammy.
