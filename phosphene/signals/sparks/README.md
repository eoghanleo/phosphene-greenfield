# SPARK snapshots (ideation inputs)

SPARK files are **signal-local input snapshots** created by the ideation hopper.
They preserve the exact issue prompt that triggered `<ideation>` work and provide a
deterministic input corpus for done-score anchoring.

## Location

- `phosphene/signals/sparks/SPARK-000123.md`

## Header schema (v1)

The header is a simple key:value block; the first blank line ends the header.

- `ID: SPARK-000123`
- `IssueNumber: 123`
- `WorkID: IDEA-0001`
- `Lane: viridian`
- `UpstreamSignalID: sha256:...` (if available)
- `InputWorkIDs: RA-001,VPD-002` (optional; may be empty)
- `ExplorationAxisIDs: AX-001,AX-014,...` (ideation v2; ordered, 10 items)
- `CreatedUTC: 2026-02-01T00:00:00Z`

## Body schema (v1)

- `## Issue snapshot`
- literal issue body copied verbatim

## Input overrides in issues (v1)

Issues may specify additional repo inputs (work IDs) in a separate block
outside the strict `[PHOSPHENE]` block:

```text
[PHOSPHENE_INPUTS]
- RA-001
- VPD-002
[/PHOSPHENE_INPUTS]
```

The hopper parses this list and stores it as `InputWorkIDs:` in the SPARK header.

## Creative exploration axes in issues (v1)

For ideation v2, autoscribe selects **10 non-repeating axes** from the canonical registry:
- `phosphene/domains/ideation/reference/creative_exploration_axes.tsv`

Autoscribe embeds the selected axes into the issue body as:

```text
[PHOSPHENE_IDEATION_AXES]
AX-001 | Ontology and metaphysics | Ontic scale | microscopic → cosmic | Shift scale to reveal different agents, constraints, and payoffs.
AX-014 | Emotion and motivation | Safety | cozy → perilous | Build coziness or real peril to transform decision-making.
...
[/PHOSPHENE_IDEATION_AXES]
```

The ideation hopper extracts the ordered axis IDs from this block and stores them in the SPARK header as:
- `ExplorationAxisIDs: AX-001,AX-014,...`

This ordering is canonical and is used by:
- ideation matrix scripts (CandID mapping)
- `validate_idea.sh` and `ideation-domain-done-score.sh` (axes×rings completeness gates)

