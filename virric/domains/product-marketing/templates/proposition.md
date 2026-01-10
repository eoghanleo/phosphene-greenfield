ID: PROP-0001
Title: <proposition name>
Status: Draft
Updated: YYYY-MM-DD
Dependencies: 
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/virric/product-marketing/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Our <capabilities> help <personas> who want to <jobs> by reducing <pains> and boosting <gains>. We achieve this by <relievers> and delivering <boosters>.

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
| BOOST-0001-PROP-0001 | <booster> | JTBD-GAIN-0001-PER-0001 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0001 | <reliever> | JTBD-PAIN-0001-PER-0001 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0001 | feature | <capability> |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```

<free-form notes>

