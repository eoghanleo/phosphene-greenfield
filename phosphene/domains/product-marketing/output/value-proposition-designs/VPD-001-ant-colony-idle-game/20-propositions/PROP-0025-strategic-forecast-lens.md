ID: PROP-0025
Title: Strategic Forecast Lens
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001, PER-0001, PER-0002, PER-0003, RA-001, PITCH-0002
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Strategic Forecast Lens gives players clear forward-looking views of colony trajectory, turning idle time into informed choices. It blends predictive metrics with short explanations so strategists and casuals know what to do next and in-chat users can ask why. This keeps progress feeling intentional rather than guesswork.

## Target Persona(s)

```text
[V-SCRIPT]:
add_proposition_target_persona.sh
remove_proposition_target_persona.sh
```

- PER-0002

- PER-0001

- PER-0003

## Related Segment(s)

```text
[V-SCRIPT]:
add_proposition_related_segment.sh
remove_proposition_related_segment.sh
```

- SEG-0002

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
| BOOST-0001-PROP-0025 | A forecast timeline shows the next two milestones and how long they are likely to take. Players can plan a short session with confidence instead of guessing. The visibility makes progress feel intentional. | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0003-PER-0002 |
| BOOST-0002-PROP-0025 | What-if sliders let strategists preview the impact of changing one variable before committing. The previews reveal tradeoffs clearly and encourage experimentation. It boosts the feeling of agency and system mastery. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0002-PER-0002 |
| BOOST-0003-PROP-0025 | AI explanations annotate each forecast with a short why and a suggested next action. The guidance keeps advanced data readable without hiding details. It helps both strategists and in-chat players feel supported. | JTBD-GAIN-0002-PER-0003, JTBD-GAIN-0003-PER-0002 |
| BOOST-0004-PROP-0025 | Quick next-step suggestions translate the forecast into a single, clear action. Casual players can act fast without digging into details. This keeps short sessions productive and satisfying. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0003-PER-0001 |
| BOOST-0005-PROP-0025 | Performance confidence indicators show whether the forecast is stable or noisy. Strategists can judge when to trust the numbers. It reinforces the sense of a premium, reliable sim. | JTBD-GAIN-0003-PER-0002, JTBD-GAIN-0004-PER-0002 |
| BOOST-0006-PROP-0025 | Return forecasts summarize what the colony will likely achieve while the player is away. The summary keeps time away feeling rewarded and predictable. It reinforces continuity and reduces surprise losses. | JTBD-GAIN-0003-PER-0003, JTBD-GAIN-0005-PER-0001 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0025 | Forecast views replace hidden metrics with clear expectations about what will happen next. Players no longer feel like progress is mysterious or opaque. This eases frustration when they are unsure if a change helped. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0004-PER-0002 |
| REL-0002-PROP-0025 | What-if previews show that deeper strategy exists beneath the idle surface. Players can see that their choices change outcomes rather than just speeding timers. This relieves the sense that the sim is shallow or stalled. | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0003-PER-0001 |
| REL-0003-PROP-0025 | AI annotations connect forecasts to concrete colony signals instead of vague hype. Players can trace why a prediction exists, which keeps the assistant from feeling gimmicky. This reduces skepticism about in-chat guidance. | JTBD-PAIN-0002-PER-0003, JTBD-PAIN-0004-PER-0002 |
| REL-0004-PROP-0025 | Decision prompts replace long idle waits with quick tactical choices. Players feel they are steering the colony instead of watching timers. This lowers frustration with passive progression. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0005-PER-0002 |
| REL-0005-PROP-0025 | A single recommended next step reduces cognitive overload for casual players. They can act without studying a complex system. This eases the early overwhelm that drives drop-off. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0004-PER-0002 |
| REL-0006-PROP-0025 | Return summaries highlight what was forecasted and what actually happened. Players can trust that progress persisted while they were away. This reduces anxiety about lost state or surprise setbacks. | JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0005-PER-0001 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0025 | function | A forecast dashboard that projects key resource curves and milestone timing. The dashboard keeps the view concise so it does not feel like a spreadsheet. It gives players a forward-looking plan without heavy analysis. |
| CAP-0002-PROP-0025 | feature | A what-if simulator that lets players preview the effect of changing one lever before applying it. The simulator shows tradeoffs in plain language alongside metrics. It encourages experimentation without commitment. |
| CAP-0003-PROP-0025 | experience | An AI annotation layer that explains why each forecast looks the way it does. Players can ask for a short explanation or a deeper breakdown. It makes advanced data feel approachable. |
| CAP-0004-PROP-0025 | function | A decision prompt queue that surfaces one actionable recommendation at a time. The queue keeps the interface calm while still guiding progress. It reduces analysis paralysis for casual players. |
| CAP-0005-PROP-0025 | standard | A confidence rating standard that labels forecasts as stable, volatile, or uncertain. The label prevents overreliance on noisy projections. It builds trust in the system’s honesty. |
| CAP-0006-PROP-0025 | feature | A return forecast recap that compares predicted progress to actual results. The recap shows whether strategy is working and why. It reinforces continuity and learning across sessions. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



- 2026-01-26T23:07:31Z: Forecast language should stress probabilistic signals rather than guarantees; use ranges, confidence bands, and scenario lenses. This keeps the strategy voice credible and avoids overpromising.
