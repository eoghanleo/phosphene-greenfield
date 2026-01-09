---
name: retrospective
description: Produce <retrospective> artifacts (postmortems, playbooks) capturing lessons, root causes, and guardrails for future work.
metadata:
  short-description: Postmortems + playbooks
---

## Domain

Primary domain: `<retrospective>`

## What you produce

- Postmortems: `virric/domains/retrospective/docs/postmortems/PM-*.md`
- Playbooks: `virric/domains/retrospective/docs/playbooks/PB-*.md`

## How to work

- Start from merged PRs, incident reports, and outcomes.
- Use templates under `virric/domains/retrospective/templates/`.
- Keep learnings actionable: what changed, what to keep, what to automate/validate next time.

## Receipts (recommended)

Write a `DONE.json` receipt adjacent to each produced artifact listing:

- inputs (PRs/issues/notes)
- outputs (PM/PB docs)
- checks run (format/header compliance)
