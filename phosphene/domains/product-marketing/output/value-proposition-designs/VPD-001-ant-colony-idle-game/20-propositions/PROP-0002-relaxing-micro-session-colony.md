ID: PROP-0002
Title: Relaxing Micro-Session Colony
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001, PER-0001, RA-001, PITCH-0001
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Our relaxing micro-session colony helps casual idle gamers feel a complete, soothing play loop in under five minutes. It emphasizes clear next steps, calming feedback, and a gentle return cadence so players never feel rushed. The proposition turns downtime into a consistent, stress-free ritual.

## Target Persona(s)

```text
[V-SCRIPT]:
add_proposition_target_persona.sh
remove_proposition_target_persona.sh
```

- PER-0001

## Related Segment(s)

```text
[V-SCRIPT]:
add_proposition_related_segment.sh
remove_proposition_related_segment.sh
```

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
| BOOST-0001-PROP-0002 | A five-minute loop ends with a concise recap of what the colony achieved while away. The recap makes every check-in feel like a tidy accomplishment rather than an open-ended grind. This reinforces quick achievement and offline progress. | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0005-PER-0001 |
| BOOST-0002-PROP-0002 | Calm audio-visual cues highlight progress without demanding attention. Gentle animations and soft sounds make the colony feel alive in a soothing way. This boosts relaxation and visual delight. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0004-PER-0001 |
| BOOST-0003-PROP-0002 | Daily micro-goal cards frame a small objective that is achievable in a short session. The cards provide a clear next step and a quick win. This amplifies short-session accomplishment and keeps the loop calm. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0003-PER-0001 |
| BOOST-0004-PROP-0002 | Soft streak rewards celebrate consistent but flexible check-ins, without punishing missed days. The rewards are cosmetic or convenience-based so the economy stays fair. This supports offline progress while reinforcing trust. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0005-PER-0001 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0002 | Progressive disclosure introduces one system at a time with short, optional tips. This keeps early sessions light and prevents analysis paralysis. The player understands the loop without feeling overwhelmed. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0003-PER-0001 |
| REL-0002-PROP-0002 | A session wrap-up screen suggests a natural stopping point and summarizes gains. This keeps sessions from stretching into grind and makes pauses feel intentional. It reduces pressure to stay logged in. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0005-PER-0001 |
| REL-0003-PROP-0002 | Rotating micro-events add small twists like weather shifts or ant behavior changes. These keep the loop feeling fresh without adding complexity. The variety counters repetition and pacing fatigue. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0004-PER-0001 |
| REL-0004-PROP-0002 | Gentle, opt-in reminders let players return when they want, not because they must. The tone emphasizes relaxation instead of urgency. This prevents guilt-based retention and reduces monetization pressure. | JTBD-PAIN-0001-PER-0001, JTBD-PAIN-0005-PER-0001 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0002 | experience | A micro-session mode that frames play in short, satisfying loops with a visible start and finish. It encourages quick check-ins without dangling open tasks. The experience makes downtime feel complete rather than endless. |
| CAP-0002-PROP-0002 | feature | Daily micro-goal cards present one clear action with a small reward. Players can complete them quickly or ignore them without penalty. The cards simplify decision-making and reduce early overwhelm. |
| CAP-0003-PROP-0002 | feature | Ambient customization options let players tune the visual and audio mood. Calmer settings reinforce the low-stress tone of the experience. This capability enhances relaxation without adding complexity. |
| CAP-0004-PROP-0002 | function | A session wrap-up screen summarizes earned resources, progress, and the next suggested upgrade. It signals a natural stopping point and encourages leaving the app without anxiety. This keeps short sessions neat and satisfying. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



