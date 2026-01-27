ID: PROP-0016
Title: Colony experiment notebook
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001, PER-0002, PER-0001
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Colony experiment notebook helps system-driven strategists and relaxed idle gamers connect changes to outcomes. It summarizes before-and-after metrics and highlights the most meaningful shifts so players feel mastery or quick progress. The notebook turns experimentation into a visible learning loop.

## Target Persona(s)

```text
[V-SCRIPT]:
add_proposition_target_persona.sh
remove_proposition_target_persona.sh
```

- PER-0002

- PER-0001

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
| BOOST-0001-PROP-0016 | Experiment summaries translate strategy changes into clear wins. After each tweak, the notebook highlights which output streams improved and why, giving the strategist confidence to keep iterating. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0003-PER-0002 |
| BOOST-0002-PROP-0016 | Quick-session insight cards help casual players see progress trends without extra study. The card explains what changed since last visit and celebrates the most meaningful improvement. | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0005-PER-0001 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0016 | Experiment logs remove guesswork by showing a simple before-and-after snapshot for each change. Strategists no longer feel stuck wondering if a choice mattered. | JTBD-PAIN-0004-PER-0002 |
| REL-0002-PROP-0016 | Return briefings flag the one or two levers worth touching instead of dumping every system at once. This reduces overwhelm for relaxed players who are re-entering after a break. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0005-PER-0001 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0016 | function | Experiment notebook timeline with labeled snapshots and outcomes. It lets players tag a change and see metrics and colony visuals linked to that change. |
| CAP-0002-PROP-0016 | experience | One-tap return briefing that highlights the top two insights since the last session. It keeps the player focused and offers a clear next action. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



- 2026-01-26T12:59:37Z: Position this as a lightweight lab journal rather than a heavy analytics dashboard. The tone should feel encouraging and playful so casual players still try the insights.
