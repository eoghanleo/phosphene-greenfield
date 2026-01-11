ID: PROP-0005
Title: Idle-Strategy Integration
Status: Draft
Updated: 2026-01-11
Dependencies: PER-0002, RA-001, PITCH-0001
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/virric/product-marketing/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Our idle-strategy integration helps simulation enthusiasts feel agency by tying upgrades to colony actions and decisions, reducing passive waiting while preserving long-term progression.

## Target Persona(s)

```text
[V-SCRIPT]:
add_proposition_target_persona.sh
remove_proposition_target_persona.sh
```


- PER-0002

## Related Segment(s)

```text
[V-SCRIPT]:
add_proposition_related_segment.sh
remove_proposition_related_segment.sh
```


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
| BOOST-0001-PROP-0005 | Upgrades earned through colony actions | JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0003-PER-0002 |
| BOOST-0002-PROP-0005 | Choice-driven resource allocation | JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0005-PER-0002 |
| BOOST-0003-PROP-0005 | Progress loop that rewards active decisions | JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0003-PER-0002 |
| BOOST-0004-PROP-0005 | Clear cause-and-effect feedback on colony changes | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0005-PER-0002 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0005 | Eliminates waiting-only progression | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0003-PER-0002 |
| REL-0002-PROP-0005 | Reduces shallow idle feel with strategic gates | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0005-PER-0002 |
| REL-0003-PROP-0005 | Fewer monetization shortcuts that bypass progression | JTBD-PAIN-0002-PER-0002, JTBD-PAIN-0003-PER-0002 |
| REL-0004-PROP-0005 | Structured challenges to keep agency high | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0005-PER-0002 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0005 | function | Action-linked upgrade economy |
| CAP-0002-PROP-0005 | feature | Strategic allocation dashboard for colony resources |
| CAP-0003-PROP-0005 | experience | Active decision checkpoints that punctuate the idle loop |
| CAP-0004-PROP-0005 | standard | No core progress skips via timers |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```

<free-form notes>

