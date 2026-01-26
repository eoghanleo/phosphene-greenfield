ID: PROP-0005
Title: Trustworthy Upgrade Tiers
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

Trustworthy upgrade tiers give casual and in-chat players clear, optional ways to support the game. They emphasize transparency, low-friction billing, and fair pacing. The proposition reduces purchase anxiety while preserving a relaxed loop.

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
| BOOST-0001-PROP-0005 | Tier cards spell out exactly what each upgrade provides and how long it lasts. Players can decide without guessing. This boosts trust and calm spending. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0004-PER-0003 |
| BOOST-0002-PROP-0005 | Low-tier support options keep spending approachable for cautious players. They reinforce that upgrades are optional, not required. This boosts fairness and confidence. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0003-PER-0003 |
| BOOST-0003-PROP-0005 | Upgrade tiers align with short-session goals like faster summaries or cosmetic flair. They enhance convenience without bypassing play. This boosts relaxed engagement. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0003-PER-0001 |
| BOOST-0004-PROP-0005 | In-chat upgrade confirmation reassures players that their purchase is persistent. It builds confidence to support the experience. This boosts trust and continuity. | JTBD-GAIN-0003-PER-0003, JTBD-GAIN-0004-PER-0003 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0005 | Clear tier descriptions remove uncertainty about what you are buying. Players can see the value before committing. This relieves purchase hesitation. | JTBD-PAIN-0001-PER-0001, JTBD-PAIN-0004-PER-0003 |
| REL-0002-PROP-0005 | Optional tiers avoid pressuring casual players to spend. The loop remains satisfying without upgrades. This relieves coercion anxiety. | JTBD-PAIN-0001-PER-0001, JTBD-PAIN-0005-PER-0001 |
| REL-0003-PROP-0005 | In-chat billing clarity reduces fear of hidden steps or surprises. Players know what happens after payment. This relieves uncertainty about upgrades. | JTBD-PAIN-0003-PER-0003, JTBD-PAIN-0004-PER-0003 |
| REL-0004-PROP-0005 | Tier caps prevent over-monetization that could disrupt the calm loop. They keep upgrades limited and fair. This relieves anxiety about runaway spending. | JTBD-PAIN-0004-PER-0003, JTBD-PAIN-0006-PER-0001 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0005 | feature | Tier cards that explain cost, duration, and impact in plain language. They keep choices transparent and calm. This supports trust. |
| CAP-0002-PROP-0005 | function | A tiered checkout flow that stays within chat and returns players to the game instantly. It minimizes friction and keeps context. This supports in-chat spending. |
| CAP-0003-PROP-0005 | standard | A fairness cap that limits how many upgrades can stack at once. It preserves the stress-free loop for casual players. This keeps monetization balanced. |
| CAP-0004-PROP-0005 | experience | A calm purchase confirmation that emphasizes optionality and persistence. It reassures players without pressure. This supports relaxed spending. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



