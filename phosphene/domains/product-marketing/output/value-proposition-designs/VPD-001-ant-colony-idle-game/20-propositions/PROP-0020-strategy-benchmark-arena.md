ID: PROP-0020
Title: Strategy benchmark arena
Status: Draft
Updated: 2026-01-26
Dependencies: VPD-001, PER-0002
Owner: 
EditPolicy: DO_NOT_EDIT_DIRECTLY (use scripts; see .codex/skills/phosphene/beryl/product-marketing/modulator/SKILL.md)

## Formal Pitch

```text
[V-SCRIPT]:
update_proposition_formal_pitch.sh
```

Strategy benchmark arena gives systems-driven strategists a structured way to test ideas and compare outcomes. It turns experimentation into a visible scorecard so decisions feel meaningful instead of guesswork. The arena reinforces the game’s depth and credibility.

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
| BOOST-0001-PROP-0020 | Benchmark arenas let strategists run two colony builds against the same scenario and see a clean scorecard. The side-by-side view makes optimization tangible and shows which levers actually improved output. | JTBD-GAIN-0003-PER-0002 |
| BOOST-0002-PROP-0020 | Scenario challenges introduce quirky constraints that reveal unexpected outcomes. Players discover emergent behaviors that reward curiosity without breaking the idle rhythm. | JTBD-GAIN-0002-PER-0002 |
| BOOST-0003-PROP-0020 | Smooth performance during benchmark runs signals that the web sim can handle depth. Fast feedback builds trust that serious optimization is worth the effort. | JTBD-GAIN-0004-PER-0002 |
| BOOST-0004-PROP-0020 | Benchmark results highlight the specific decision that drove the biggest lift, reinforcing agency. Strategists feel like their choices reshape the system rather than just speed it up. | JTBD-GAIN-0001-PER-0002 |

## Pain Relievers

```text
[V-SCRIPT]:
add_proposition_pain_reliever.sh
update_proposition_pain_reliever.sh
```

MappedPainIDs is an array encoded as a comma-separated list of JTBD IDs.

| RelieverID | Reliever | MappedPainIDs[] |
|---|---|---|
| REL-0001-PROP-0020 | Benchmark arenas surface layered systems and show how different strategies play out over time. This counters the fear that the game is shallow by proving there are real levers to pull. | JTBD-PAIN-0001-PER-0002 |
| REL-0002-PROP-0020 | Benchmarks are standardized so paid boosts cannot alter the scoring baseline. Strategists avoid the feeling that spending invalidates the experiment. | JTBD-PAIN-0002-PER-0002 |
| REL-0003-PROP-0020 | A fast simulation preview runs before a benchmark to confirm performance and stability. It reassures players that the web client can handle deeper play. | JTBD-PAIN-0003-PER-0002 |
| REL-0004-PROP-0020 | Scorecards show explicit efficiency deltas instead of vague feedback. This removes guesswork and keeps experimentation grounded. | JTBD-PAIN-0004-PER-0002 |

## Capabilities

```text
[V-SCRIPT]:
add_proposition_capability.sh
update_proposition_capability.sh
```

CapabilityType must be one of: `feature|function|standard|experience`.

| CapabilityID | CapabilityType | Capability |
|---|---|---|
| CAP-0001-PROP-0020 | function | Benchmark scenario runner with standardized inputs and clear timing windows. It ensures every strategy is tested under comparable conditions. |
| CAP-0002-PROP-0020 | feature | Side-by-side comparison dashboard that highlights efficiency, stability, and growth differences. It makes competitive analysis feel accessible rather than tedious. |
| CAP-0003-PROP-0020 | experience | Strategy debrief highlight that calls out the single biggest lever behind a score change. It reinforces learning without requiring deep data interpretation. |
| CAP-0004-PROP-0020 | standard | Benchmark fairness rule that disallows paid boosts or temporary advantages during scoring. It protects the integrity of strategic comparisons. |

## Notes

```text
[V-SCRIPT]:
add_proposition_note.sh
overwrite_proposition_notes.sh
```



- 2026-01-26T13:06:44Z: Use a friendly, low-pressure tone so benchmarks feel like playful challenges rather than hardcore esports ladders. The experience should invite experimentation without intimidating casual strategists.
