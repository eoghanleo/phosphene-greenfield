ID: PROP-0008
Title: Charming Colony Aesthetic
Status: Draft
Updated: 2026-01-11
Dependencies: PER-0001, RA-001, PITCH-0001, PER-0002
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/virric/product-marketing/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Our charming colony aesthetic helps casual idle players who want relaxing, delightful sessions by reducing boredom and overwhelm while boosting cozy satisfaction and visual delight. We achieve this with stylized art, gentle animations, and light customization that makes progress feel personal.

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
| BOOST-0001-PROP-0008 | Charming, cozy visuals that make progress feel delightful. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0005-PER-0001 |
| BOOST-0002-PROP-0008 | Personalized colony decor that feels rewarding. | JTBD-GAIN-0004-PER-0001, JTBD-GAIN-0005-PER-0001 |
| BOOST-0003-PROP-0008 | Smooth animations that make growth feel real. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0003-PER-0001 |
| BOOST-0004-PROP-0008 | Theme variety that keeps goals fresh. | JTBD-GAIN-0004-PER-0001, JTBD-GAIN-0005-PER-0001 |
| BOOST-0005-PROP-0008 | Celebration moments that feel cozy and rewarding. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0003-PER-0001 |
| BOOST-0006-PROP-0008 | Visual clarity that supports system understanding. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0004-PER-0002, JTBD-GAIN-0005-PER-0001 |
| BOOST-0007-PROP-0008 | Species variations that hint behavior differences. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0005-PER-0001 |
| BOOST-0008-PROP-0008 | Scientific labeling of species behaviors. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0004-PER-0002, JTBD-GAIN-0005-PER-0001 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0008 | Clear visual hierarchy to avoid overwhelm. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0005-PER-0001 |
| REL-0002-PROP-0008 | Scene variety to prevent repetition fatigue. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0004-PER-0001 |
| REL-0003-PROP-0008 | Gentle visual pacing to keep progress from stalling. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0004-PER-0001 |
| REL-0004-PROP-0008 | Optional cosmetics so monetization never feels coercive. | JTBD-PAIN-0001-PER-0001, JTBD-PAIN-0004-PER-0001 |
| REL-0005-PROP-0008 | Visualized offline receipts to reinforce progress. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0005-PER-0001 |
| REL-0006-PROP-0008 | Clarity reduces hidden mechanics confusion. | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0005-PER-0002 |
| REL-0007-PROP-0008 | Visual density settings to avoid overload. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0004-PER-0002, JTBD-PAIN-0005-PER-0001 |
| REL-0008-PROP-0008 | Toggleable info density to reduce overload. | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0004-PER-0001, JTBD-PAIN-0004-PER-0002, JTBD-PAIN-0005-PER-0002 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0008 | experience | Stylized art direction |
| CAP-0002-PROP-0008 | feature | Theme skins and palettes |
| CAP-0003-PROP-0008 | feature | Colony decor customization |
| CAP-0004-PROP-0008 | experience | Ambient audio and calming soundscape |
| CAP-0005-PROP-0008 | feature | Celebration animation set |
| CAP-0006-PROP-0008 | feature | Visual clarity settings |
| CAP-0007-PROP-0008 | feature | Species variation art kit |
| CAP-0008-PROP-0008 | feature | Behavior labeling system |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```

- Packaging: cosmetics should be optional and tied to milestones, not purchases alone.
- Risk: overly cute visuals can alienate strategy-leaning players.
- Edge: accessibility (color contrast, motion) needs attention for cozy visuals.

