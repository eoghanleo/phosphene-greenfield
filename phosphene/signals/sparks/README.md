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

