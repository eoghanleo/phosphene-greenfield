ID: PROP-0003
Title: Strategic Depth Layers
Status: Draft
Updated: 2026-01-11
Dependencies: PER-0002, RA-001, PITCH-0001, PITCH-0003
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/virric/product-marketing/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Our strategic depth layers help simulation enthusiasts who want authentic colony mastery by reducing shallow reskin fears and idle-only waiting while boosting emergent behavior, meaningful decisions, and experimentation clarity. We achieve this by surfacing system levers, providing data-rich controls, and rewarding long-term strategy.

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
| BOOST-0001-PROP-0003 | Emergent behavior highlights that show the system working. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0002-PER-0002 |
| BOOST-0002-PROP-0003 | Strategic levers that visibly change outcomes. | JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0004-PER-0002 |
| BOOST-0003-PROP-0003 | Transparent stats and logs for experimentation. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0004-PER-0002 |
| BOOST-0004-PROP-0003 | Optional depth modules for long-term mastery. | JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0005-PER-0002 |
| BOOST-0005-PROP-0003 | Scenario experiments that validate strategies. | JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0004-PER-0002 |
| BOOST-0006-PROP-0003 | Mastery badges that signal progress. | JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0004-PER-0002, JTBD-GAIN-0005-PER-0002 |
| BOOST-0007-PROP-0003 | Comparative strategy benchmarks for optimization. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0004-PER-0002 |
| BOOST-0008-PROP-0003 | Strategy journal with cause-effect notes. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0002-PER-0002, JTBD-GAIN-0003-PER-0002, JTBD-GAIN-0004-PER-0002, JTBD-GAIN-0005-PER-0002 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0003 | Layer depth so the sim never feels like a shallow reskin. | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0003-PER-0002 |
| REL-0002-PROP-0003 | Monetization rules that preserve sim integrity. | JTBD-PAIN-0002-PER-0002, JTBD-PAIN-0004-PER-0002 |
| REL-0003-PROP-0003 | Reduce idle-only waiting by adding interactive decision points. | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0003-PER-0002 |
| REL-0004-PROP-0003 | Expose system details to remove hidden mechanics. | JTBD-PAIN-0004-PER-0002, JTBD-PAIN-0005-PER-0002 |
| REL-0005-PROP-0003 | Advanced tutorials to surface hidden mechanics. | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0005-PER-0002 |
| REL-0006-PROP-0003 | Guardrails that keep decisions impactful, not idle-only. | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0003-PER-0002, JTBD-PAIN-0004-PER-0002 |
| REL-0007-PROP-0003 | Guided setup for advanced controls. | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0004-PER-0002, JTBD-PAIN-0005-PER-0002 |
| REL-0008-PROP-0003 | Explainable systems to reduce reskin fear. | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0002-PER-0002, JTBD-PAIN-0003-PER-0002, JTBD-PAIN-0004-PER-0002, JTBD-PAIN-0005-PER-0002 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0003 | feature | Advanced colony controls panel |
| CAP-0002-PROP-0003 | feature | System stats and behavior logs |
| CAP-0003-PROP-0003 | function | Parameter sandbox for strategy experiments |
| CAP-0004-PROP-0003 | experience | Strategic challenge scenarios |
| CAP-0005-PROP-0003 | feature | Scenario experiment builder |
| CAP-0006-PROP-0003 | feature | Benchmark leaderboard |
| CAP-0007-PROP-0003 | experience | Advanced control walkthroughs |
| CAP-0008-PROP-0003 | feature | Strategy journal log |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```

- Packaging: depth layers should be optional and unlock with mastery milestones.
- Risk: too many controls can overwhelm without progressive disclosure.
- Edge: web performance may limit complex simulations on lower-end devices.

