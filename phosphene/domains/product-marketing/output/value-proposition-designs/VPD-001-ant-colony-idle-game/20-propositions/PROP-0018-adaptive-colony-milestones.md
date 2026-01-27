ID: PROP-0018
Title: Adaptive colony milestones
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001, PER-0001, PER-0002
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Adaptive colony milestones give relaxed players and strategists a clear, motivating next goal without overwhelming them. The milestones surface quick wins, explain the impact of choices, and keep progress visible even in short sessions. This turns the idle loop into a steady chain of satisfying outcomes.

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
| BOOST-0001-PROP-0018 | Milestone cards compress a whole day of progress into a single, satisfying highlight reel. The player sees one big win and one next step, which makes a five-minute check-in feel complete and keeps the return loop soothing. | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0005-PER-0001 |
| BOOST-0002-PROP-0018 | Adaptive milestones show how a strategic change altered resource curves and colony behavior. That visibility reinforces agency because players can connect a decision to a measurable shift instead of guessing. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0003-PER-0002 |
| BOOST-0003-PROP-0018 | Milestone visuals introduce a charming colony moment tied to each goal, like a new tunnel animation or ant behavior. The thematic payoff keeps relaxed players engaged while reinforcing the sense of a living colony. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0004-PER-0001 |
| BOOST-0004-PROP-0018 | Strategy-focused milestones stack optional challenges that unlock new levers after consistent progress. The sequence keeps experimentation fresh by rewarding curiosity with deeper mechanics. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0002-PER-0002 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0018 | Adaptive milestones surface the next visible goal before progress feels stalled. They keep the loop moving by showing exactly what unlocks after a short effort, so repetition never settles in. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0004-PER-0001 |
| REL-0002-PROP-0018 | Strategy milestones replace idle waiting with a small decision window that adjusts the next objective. The player feels like their choice influences the timer rather than being stuck watching it. | JTBD-PAIN-0005-PER-0002 |
| REL-0003-PROP-0018 | Milestone framing narrows the initial upgrade space to one focused objective at a time. This reduces early overwhelm by making the next step obvious and explaining why it matters. | JTBD-PAIN-0002-PER-0001 |
| REL-0004-PROP-0018 | Each milestone includes a quick metric callout showing the before-and-after change. It counters vague feedback so strategists know if an experiment succeeded. | JTBD-PAIN-0004-PER-0002 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0018 | feature | Adaptive milestone ladder that adjusts the next goal based on session length and recent performance. It keeps targets achievable for short sessions while still offering depth for longer play. |
| CAP-0002-PROP-0018 | function | Milestone metric snapshot widget that shows output changes, resource deltas, and stability shifts. It gives strategists a quick read so experimentation feels measurable. |
| CAP-0003-PROP-0018 | experience | Milestone celebration vignette that spotlights a new tunnel, worker behavior, or colony animation. The moment reinforces progress with a charming visual payoff. |
| CAP-0004-PROP-0018 | standard | Milestone pacing policy that keeps core progression independent of optional spend. It signals that achievements are earned through play rather than gated by purchases. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



- 2026-01-26T13:04:04Z: Use milestone language that feels like a gentle narrative arc rather than a grind checklist. The framing should emphasize discovery and care for the colony so the system feels supportive, not pressuring.
