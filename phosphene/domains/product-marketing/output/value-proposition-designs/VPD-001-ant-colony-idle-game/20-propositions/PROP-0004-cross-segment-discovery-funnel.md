ID: PROP-0004
Title: Cross-Segment Discovery Funnel
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001, PER-0001, PER-0002, RA-001, PITCH-0001
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Cross-segment discovery funnel brings casual and strategic players into the same colony journey with tailored entry points. It connects lightweight onboarding to deeper systems without losing either audience. The proposition widens reach while preserving depth.

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
| BOOST-0001-PROP-0004 | A casual entry track delivers fast wins and calm pacing for short sessions. It helps relaxed players feel progress without complexity. This boosts quick achievement and emotional ease. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0003-PER-0001 |
| BOOST-0002-PROP-0004 | A depth ramp reveals new mechanics once players show curiosity. Strategists see meaningful levers without overwhelming casuals. This boosts agency and discovery. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0002-PER-0002 |
| BOOST-0003-PROP-0004 | Segment-aware messaging highlights either relaxation or experimentation depending on the player. It makes each group feel seen without splitting the product. This boosts trust and engagement across segments. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0003-PER-0002 |
| BOOST-0004-PROP-0004 | A shared progression spine keeps both personas on a common path with optional branches. It encourages migration from casual to strategic play without forcing it. This boosts long-term retention and flexibility. | JTBD-GAIN-0004-PER-0002, JTBD-GAIN-0005-PER-0001 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0004 | Progressive disclosure prevents early overwhelm for casual players. It introduces complexity only when needed. This relieves mental load and confusion. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0007-PER-0001 |
| REL-0002-PROP-0004 | Depth markers prove the game has real strategic layers. They reduce skepticism about a shallow idle reskin. This relieves strategic mistrust. | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0005-PER-0002 |
| REL-0003-PROP-0004 | Segment-aware pacing avoids the stall that frustrates casuals and the waiting that frustrates strategists. It keeps the loop balanced for both. This relieves boredom and hollow idle cycles. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0005-PER-0002 |
| REL-0004-PROP-0004 | Shared onboarding messaging avoids conflicting expectations between segments. It clarifies that both relaxation and strategy are supported. This relieves confusion and mismatch. | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0007-PER-0001 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0004 | experience | A dual-path onboarding that starts simple but signals deeper layers. It keeps casuals comfortable while inviting strategists to explore. This supports broad entry. |
| CAP-0002-PROP-0004 | feature | A depth ramp map that unlocks strategy modules over time. It lets players opt in without forcing complexity. This supports gradual mastery. |
| CAP-0003-PROP-0004 | function | Segment-aware tips that adjust messaging based on play style. They reinforce either relaxation or experimentation in the moment. This keeps guidance relevant. |
| CAP-0004-PROP-0004 | standard | A shared progression spine that keeps both personas aligned on core milestones. Optional branches preserve choice without fragmenting the experience. This supports cross-segment continuity. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



