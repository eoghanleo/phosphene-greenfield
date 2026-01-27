ID: PROP-0006
Title: Lite vs Deep Play Stack
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001, PER-0001, PER-0002, RA-001, PITCH-0002
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Lite vs deep play stack lets casual and strategic personas choose their level of engagement without switching games. It balances quick idle check-ins with richer systems for longer sessions. The proposition keeps the experience flexible and inclusive.

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
| BOOST-0001-PROP-0006 | Lite mode delivers a complete reward loop in minutes, perfect for downtime. It keeps progress visible without demanding attention. This boosts quick achievement and calm pacing. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0003-PER-0001 |
| BOOST-0002-PROP-0006 | Deep mode unlocks strategic levers like resource routing and role specialization. It rewards longer sessions with meaningful choices. This boosts agency and mastery. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0003-PER-0002 |
| BOOST-0003-PROP-0006 | Players can shift between modes without losing progress, so play adapts to time availability. The flexibility keeps both personas engaged. This boosts continuity and flexibility. | JTBD-GAIN-0004-PER-0002, JTBD-GAIN-0005-PER-0001 |
| BOOST-0004-PROP-0006 | Mode-specific rewards highlight either relaxation or optimization. It makes each session feel intentional and satisfying. This boosts emotional relief and strategic confidence. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0003-PER-0002 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0006 | Lite mode reduces early overwhelm by limiting choices. It keeps the session calm and simple. This relieves mental load for casual players. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0007-PER-0001 |
| REL-0002-PROP-0006 | Deep mode ensures strategists are not stuck with shallow loops. It reveals depth when they want it. This relieves fear of a reskin experience. | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0004-PER-0002 |
| REL-0003-PROP-0006 | Mode switching prevents the loop from feeling repetitive by changing the pace. It introduces variety without forcing extra time. This relieves boredom and pacing stalls. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0004-PER-0001 |
| REL-0004-PROP-0006 | Shared progression keeps players from feeling like they must choose one persona path forever. It avoids the pain of starting over or losing progress. This relieves re-entry anxiety. | JTBD-PAIN-0003-PER-0002, JTBD-PAIN-0005-PER-0001 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0006 | experience | Lite and deep session modes that can be toggled at any time. They adapt to available time without losing progress. This keeps play flexible. |
| CAP-0002-PROP-0006 | feature | A mode selector that explains what each play style includes. It keeps choices simple and optional. This reduces confusion. |
| CAP-0003-PROP-0006 | function | Mode-specific reward summaries that keep feedback concise or detailed. They help players stay oriented in either mode. This supports clarity. |
| CAP-0004-PROP-0006 | standard | A shared progression spine that keeps both modes aligned on key milestones. It prevents fragmentation across play styles. This supports continuity. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



