ID: PROP-0013
Title: Creator Spotlight Channels
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

Creator spotlight channels bring short-form discovery and shareable highlights to casual and in-chat players. It frames the game through quick, inspiring moments from others. The proposition improves acquisition and social momentum.

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
| BOOST-0001-PROP-0013 | Creator clips show quick idle wins and charming colony visuals. They make the game feel approachable and fun. This boosts casual curiosity and delight. | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0004-PER-0001 |
| BOOST-0002-PROP-0013 | In-chat spotlights provide a one-line story to share instantly. They keep the conversation lively and easy to spread. This boosts social engagement. | JTBD-GAIN-0001-PER-0003, JTBD-GAIN-0006-PER-0003 |
| BOOST-0003-PROP-0013 | Spotlight challenges encourage quick check-ins with easy rewards. They make the loop feel playful without heavy commitment. This boosts relaxed engagement. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0003-PER-0001 |
| BOOST-0004-PROP-0013 | Discovery trails in spotlight content point to simple next steps. They help new players act without confusion. This boosts frictionless entry. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0001-PER-0003 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0013 | Spotlights reduce the fear of a confusing first session by showing what to do. They lower onboarding anxiety. This relieves overwhelm. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0002-PER-0001 |
| REL-0002-PROP-0013 | Short creator clips fight repetition by introducing fresh moments. They keep the loop lively without extra play. This relieves boredom and churn. | JTBD-PAIN-0004-PER-0001, JTBD-PAIN-0005-PER-0003 |
| REL-0003-PROP-0013 | Spotlight call-to-actions provide a gentle next step, reducing decision anxiety. They keep choices light and optional. This relieves upgrade confusion. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0007-PER-0001 |
| REL-0004-PROP-0013 | In-chat share prompts avoid context switching for explorers. They let players stay in the conversation while engaging with content. This relieves immersion breaks. | JTBD-PAIN-0001-PER-0003, JTBD-PAIN-0006-PER-0003 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0013 | feature | A spotlight feed that surfaces short creator clips and quick wins. It keeps discovery lightweight and engaging. This supports acquisition. |
| CAP-0002-PROP-0013 | experience | A shareable highlight card that appears in chat after a spotlight moment. It keeps the conversation social and quick. This supports engagement. |
| CAP-0003-PROP-0013 | function | A spotlight CTA that suggests a single low-effort action. It keeps onboarding gentle and clear. This supports first-session success. |
| CAP-0004-PROP-0013 | standard | A creator highlight cadence that refreshes content daily. It keeps discovery varied without overwhelming players. This supports sustained interest. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



