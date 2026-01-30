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
- Keep the artifact short: problem/opportunity framing, target user hypotheses, and what to research next.
- Avoid over-committing to product definitions; treat as hypotheses for `<research>`.
- Manual edits are allowed for these single-file artifacts; keep headings stable.

## In-doc script hints (`[V-SCRIPT]`)

Some templates/artifacts include fenced code blocks that begin with `[V-SCRIPT]:`.
Search for `[V-SCRIPT]` when scanning an artifact to discover relevant control scripts for that section.

## Scripts (entrypoints and purpose)

- `create_idea.sh`: Create a new IDEA artifact (allocates IDEA-####).
- `validate_idea.sh`: Validate IDEA headers/sections and ID conventions.
- `ideation_emit_done_receipt.sh`: Emit DONE receipt to the signal bus.
- `ideation-domain-done-score.sh`: Compute a minimal domain done score (programmatic).

## DONE signal

Emit a DONE receipt to the signal bus (append-only JSONL):

```bash
./.codex/skills/phosphene/viridian/ideation/modulator/scripts/ideation_emit_done_receipt.sh --issue-number <N> --work-id <IDEA-####>
```

## Validation (recommended)

- Validate all ideation artifacts:
  - `./.github/scripts/validate_idea.sh --all`
- Domain done score:
  - `./.github/scripts/ideation-domain-done-score.sh --min-score <PROMPT:done_score_min>`
