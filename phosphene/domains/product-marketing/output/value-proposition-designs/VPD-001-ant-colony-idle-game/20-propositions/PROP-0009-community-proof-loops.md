ID: PROP-0009
Title: Community Proof Loops
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

Community proof loops build confidence for casual and strategic players by showing real progress patterns from others. It uses social cues to reduce skepticism and clarify what success looks like. The proposition strengthens trust and motivation.

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
| BOOST-0001-PROP-0009 | Community highlights show quick wins from players with short-session habits. It reassures casual gamers that progress is possible without grinding. This boosts confidence and calm pacing. | JTBD-GAIN-0002-PER-0001, JTBD-GAIN-0003-PER-0001 |
| BOOST-0002-PROP-0009 | Strategy spotlights share optimization tips and outcomes from advanced players. Strategists see that deep play is rewarded. This boosts mastery and discovery. | JTBD-GAIN-0001-PER-0002, JTBD-GAIN-0003-PER-0002 |
| BOOST-0003-PROP-0009 | Social milestones celebrate players who reach key colony phases. Seeing others succeed makes progress feel attainable. This boosts motivation and retention. | JTBD-GAIN-0003-PER-0001, JTBD-GAIN-0003-PER-0002 |
| BOOST-0004-PROP-0009 | Peer feedback loops highlight balanced monetization practices from respected players. It reassures both personas that fairness is possible. This boosts trust in the economy. | JTBD-GAIN-0001-PER-0001, JTBD-GAIN-0005-PER-0002 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0009 | Community proof reduces skepticism about shallow gameplay. Seeing real strategic progress shows depth exists. This relieves doubts about the sim. | JTBD-PAIN-0001-PER-0002, JTBD-PAIN-0003-PER-0001 |
| REL-0002-PROP-0009 | Peer pacing examples show that progress is possible without heavy spending. It reduces fear of pay-to-win pressure. This relieves monetization anxiety. | JTBD-PAIN-0001-PER-0001, JTBD-PAIN-0002-PER-0002 |
| REL-0003-PROP-0009 | Strategy tips from peers reduce the frustration of opaque metrics. They point to what matters without heavy experimentation. This relieves guesswork. | JTBD-PAIN-0004-PER-0002, JTBD-PAIN-0005-PER-0002 |
| REL-0004-PROP-0009 | Community momentum keeps casual players from feeling stalled or alone. Shared milestones show a path forward. This relieves pacing fatigue. | JTBD-PAIN-0003-PER-0001, JTBD-PAIN-0004-PER-0001 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0009 | feature | A community highlight feed that surfaces short-session wins and strategic breakthroughs. It keeps proof visible and fresh. This builds trust. |
| CAP-0002-PROP-0009 | function | A strategy spotlight module that summarizes player tactics and outcomes. It provides quick, credible guidance. This supports optimization. |
| CAP-0003-PROP-0009 | experience | A shared milestone celebration that acknowledges community progress. It keeps motivation high for casual players. This supports retention. |
| CAP-0004-PROP-0009 | standard | A proof-of-progress standard that validates shared milestones and pacing benchmarks. It keeps social signals credible. This supports trust. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



