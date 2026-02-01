---
name: ideation
description: Produce <ideation> artifacts (IDEA-*) as seed concepts for downstream domains; keep inputs minimal and hypotheses explicit.
metadata:
  short-description: Ideation (IDEA artifacts)
---

## Domain

Primary domain: `<ideation>`

## Status

Active (bus + emit receipts). Ideation is now in development.

## What you produce

- Ideas as repo artifacts:
  - `phosphene/domains/ideation/output/ideas/IDEA-*.md`

## How to work

- Create artifacts directly under `phosphene/domains/ideation/output/ideas/` (templates are intentionally not used).
- Use the SPARK snapshot as the **primary input** (issue text is materialized there by hopper).
- Each ideation run includes a **mandatory sampled axis set** (10 axes) embedded in the issue as:
  - `[PHOSPHENE_IDEATION_AXES] ... [/PHOSPHENE_IDEATION_AXES]`
  - Hopper persists the ordered axis IDs into the SPARK header as `ExplorationAxisIDs: ...`.
- Your core output is a **deterministic Creative exploration matrix** (axes × rings):
  - 3 rings: `adjacent`, `orthogonal`, `extrapolatory`
  - 10 sampled axes (from the issue/SPARK)
  - **30 rows total** (every axis × ring combination)
  - Each row must include:
    - a stress-test trace: `FailureMode`, `ValueCore`, `Differentiator`
    - an **Idea paragraph** (final column) with **≥ 3 sentences**

### Axis interpretation (mandatory)

- Treat the axis as a **context infusion**: an abstract stance/persona that forces trajectories outside the obvious space.
- The Idea paragraph **should not repeat the axis label/poles verbatim** unless it is a perfect fit.
- The goal is divergence with traceability: we want to see how the same SPARK input behaves when “tilted” through different axes and rings.

## In-doc script hints (`[V-SCRIPT]`)

Some templates/artifacts include fenced code blocks that begin with `[V-SCRIPT]:`.
Search for `[V-SCRIPT]` when scanning an artifact to discover relevant control scripts for that section.

## Scripts (entrypoints and purpose)

- `create_idea.sh`: Create a new IDEA artifact (allocates IDEA-####).
- `ideation_matrix_bootstrap.sh`: Rewrite the matrix table for the 10 sampled axes (SPARK-derived).
- `ideation_matrix_set_idea_paragraph.sh`: Set the Idea paragraph cell for a specific (AxisID × Ring) row (CandID computed deterministically).
- `ideation_matrix_set_stress_test.sh`: Set FailureMode/ValueCore/Differentiator for a CandID row.
- `validate_idea.sh`: Validate IDEA headers/sections and ID conventions.
- `ideation_emit_done_receipt.sh`: Emit DONE receipt to the signal bus.
- `ideation-domain-done-score.sh`: Compute a minimal domain done score (programmatic).

## DONE signal

Emit a DONE receipt to the signal bus (append-only JSONL):

```bash
./.codex/skills/phosphene/viridian/ideation/modulator/scripts/ideation_emit_done_receipt.sh --issue-number <N> --work-id <IDEA-####>
```

## Validation (recommended)

- Resolve the IDEA artifact path:
  - `./phosphene/phosphene-core/bin/phosphene id where <IDEA-####>`
- Validate the IDEA artifact:
  - `bash .github/scripts/validate_idea.sh <path>`
- Domain done score:
  - `bash .github/scripts/ideation-domain-done-score.sh --file <path> --min-score <PROMPT:done_score_min>`
