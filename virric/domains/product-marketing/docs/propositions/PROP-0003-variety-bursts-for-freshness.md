ID: PROP-0003
Title: Variety Bursts for Freshness
Status: Draft
Updated: 2026-01-11
Dependencies: PER-0001, RA-001, PITCH-0001
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/virric/product-marketing/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Our variety-burst proposition helps casual idle gamers avoid repetition and late-game stalls by injecting short, optional novelty moments that keep progress feeling fresh without raising complexity.

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
| BOOST-0001-PROP-0003 | Rotating micro-events that add novelty | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0005-PER-0001 |
| BOOST-0002-PROP-0003 | Surprise discoveries in colony evolution | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0004-PER-0001 |
| BOOST-0003-PROP-0003 | Short-term themed goals that refresh motivation | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0005-PER-0001 |
| BOOST-0004-PROP-0003 | Visual variety packs that keep the colony charming | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0004-PER-0001 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0003 | Variety bursts that break repetitive routines | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0004-PER-0001 |
| REL-0002-PROP-0003 | Optional quick challenges instead of forced grind | JTBD-PAIN-0004-PER-0001, JTBD-PAIN-0005-PER-0001 |
| REL-0003-PROP-0003 | Lightweight event guidance to prevent overwhelm | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0004-PER-0001 |
| REL-0004-PROP-0003 | Pacing resets when progress stalls | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0003-PER-0001 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0003 | feature | Rotating micro-events with optional rewards |
| CAP-0002-PROP-0003 | function | Theme-based goal tracker for short challenges |
| CAP-0003-PROP-0003 | experience | Surprise discovery moments tied to colony evolution |
| CAP-0004-PROP-0003 | standard | Opt-in participation with no penalty for skipping |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```

<free-form notes>

