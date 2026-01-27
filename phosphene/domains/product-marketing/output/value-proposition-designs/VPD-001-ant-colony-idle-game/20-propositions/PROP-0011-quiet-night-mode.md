ID: PROP-0011
Title: Quiet Night Mode
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

Quiet night mode creates a softer, low-stimulation loop for relaxed idle gamers. It minimizes interruptions and emphasizes calm progress during late sessions. The proposition reinforces the stress-free promise.

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
| BOOST-0001-PROP-0011 | Dimmed visuals and softer audio cues keep the loop soothing at night. It makes short sessions feel relaxing rather than stimulating. This boosts emotional relief. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0004-PER-0001 |
| BOOST-0002-PROP-0011 | Night-mode summaries condense progress into a calm recap. They keep achievement clear without visual noise. This boosts short-session satisfaction. | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0007-PER-0001 |
| BOOST-0003-PROP-0011 | Gentle reminders respect late schedules and avoid urgency. They help players return when convenient. This boosts relaxed re-entry. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0007-PER-0001 |
| BOOST-0004-PROP-0011 | Low-stimulation rewards emphasize calm progress over flashy popups. It keeps the loop peaceful while still rewarding play. This boosts trust in the experience. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0005-PER-0001 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0011 | Night mode suppresses popups and ad interruptions. It prevents jarring moments during calm play. This relieves noise-related frustration. | JTBD-PAIN-0001-PER-0001, JTBD-PAIN-0006-PER-0001 |
| REL-0002-PROP-0011 | Low-light visuals reduce overwhelm and keep focus on a few actions. They make late sessions feel simple and calm. This relieves mental load. | JTBD-PAIN-0002-PER-0001, JTBD-PAIN-0007-PER-0001 |
| REL-0003-PROP-0011 | Soft pacing avoids the grindy feeling that can set in late. It keeps progress gentle rather than repetitive. This relieves pacing fatigue. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0004-PER-0001 |
| REL-0004-PROP-0011 | Quiet mode reassures players that stepping away won't punish them. It frames progress as gentle and forgiving. This relieves guilt about time away. | JTBD-PAIN-0005-PER-0001, JTBD-PAIN-0006-PER-0001 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0011 | experience | A quiet night mode toggle that softens visuals and audio. It makes late sessions feel soothing. This supports relaxation. |
| CAP-0002-PROP-0011 | feature | A low-stimulation summary card that keeps progress readable without noise. It keeps focus on a few key outcomes. This supports calm play. |
| CAP-0003-PROP-0011 | standard | A no-interruption standard that limits popups during night mode. It protects the stress-free promise. This keeps sessions peaceful. |
| CAP-0004-PROP-0011 | function | A gentle reminder scheduler that only nudges at quiet hours. It respects player rest while supporting re-entry. This maintains a calm cadence. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



