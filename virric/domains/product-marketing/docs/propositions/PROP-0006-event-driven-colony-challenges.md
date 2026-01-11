ID: PROP-0006
Title: Event-Driven Colony Challenges
Status: Draft
Updated: 2026-01-11
Dependencies: PER-0001, PER-0002, RA-001, PITCH-0001
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/virric/product-marketing/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Our event-driven colony challenges help casual and strategy players who want fresh goals without grinding by reducing repetition and idle-only waiting while boosting meaningful decisions and delightful progress spikes. We achieve this by injecting short challenge events, optional difficulty choices, and visible reward bursts.

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
| BOOST-0001-PROP-0006 | Short challenge events that spike progress. | JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0004-PER-0001 |
| BOOST-0002-PROP-0006 | Optional difficulty choices for mastery. | JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0005-PER-0002 |
| BOOST-0003-PROP-0006 | Reward bursts that feel cozy and satisfying. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0003-PER-0001 |
| BOOST-0004-PROP-0006 | Varied goal rotations that keep sessions fresh. | JTBD-GAIN-0004-PER-0001, JTBD-GAIN-0005-PER-0001 |
| BOOST-0005-PROP-0006 | Seasonal community challenges that add variety. | JTBD-GAIN-0004-PER-0001, JTBD-GAIN-0005-PER-0002 |
| BOOST-0006-PROP-0006 | Skill-based challenge tiers for mastery. | JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0004-PER-0001, JTBD-GAIN-0005-PER-0002 |
| BOOST-0007-PROP-0006 | Surprise event rewards that feel special. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0004-PER-0002 |
| BOOST-0008-PROP-0006 | Event recap dashboards with clear wins. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0004-PER-0001, JTBD-GAIN-0005-PER-0002 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0006 | Break up repetition with dynamic events. | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0004-PER-0001 |
| REL-0002-PROP-0006 | Inject agency so waiting never dominates. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0003-PER-0002 |
| REL-0003-PROP-0006 | Optional difficulty to avoid overwhelm and hidden systems. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0005-PER-0002 |
| REL-0004-PROP-0006 | Pacing spikes that prevent slow mid-game stalls. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0004-PER-0002 |
| REL-0005-PROP-0006 | Opt-out controls to avoid forced challenge overwhelm. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0003-PER-0002 |
| REL-0006-PROP-0006 | Adaptive difficulty to prevent overwhelm. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0003-PER-0002, JTBD-PAIN-0005-PER-0002 |
| REL-0007-PROP-0006 | Cooldowns to avoid grindy repetition. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0003-PER-0002, JTBD-PAIN-0004-PER-0001 |
| REL-0008-PROP-0006 | Event pacing guardrails to prevent stalls. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0003-PER-0002, JTBD-PAIN-0004-PER-0001, JTBD-PAIN-0005-PER-0002 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0006 | function | Dynamic event scheduling system |
| CAP-0002-PROP-0006 | feature | Challenge reward ladders |
| CAP-0003-PROP-0006 | feature | Optional difficulty toggles |
| CAP-0004-PROP-0006 | experience | Time-boxed challenge moments |
| CAP-0005-PROP-0006 | feature | Seasonal event calendar |
| CAP-0006-PROP-0006 | function | Adaptive difficulty system |
| CAP-0007-PROP-0006 | feature | Event cooldown settings |
| CAP-0008-PROP-0006 | feature | Event recap dashboard |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```

- Packaging: keep challenge events opt-in to avoid frustrating casuals.
- Risk: rewards must not crowd out the core idle loop.
- Edge: time-boxed events need clear timezone handling to avoid confusion.

