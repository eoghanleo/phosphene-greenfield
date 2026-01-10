---
name: scrum-management
description: Produce <scrum-management> issue mirrors and lightweight operational artifacts; keep routing/status portable via labels.
metadata:
  short-description: Operational issues + mirrors
---

## Domain

Primary domain: `<scrum-management>`

## What you produce

- Optional issue mirror docs (scaffold): `virric/domains/scrum-management/docs/issues/ISSUE-*.md`

## How to work

- Treat Issues (GitHub/Linear) as optional UX; keep the automation contract portable (labels + PR events).
- If mirroring state into repo headers, do so via PR (audit trail).
- Use templates under `virric/domains/scrum-management/templates/`.

## In-doc script hints (`[V-SCRIPT]`)

Some templates/artifacts include fenced code blocks that begin with `[V-SCRIPT]:`.
Search for `[V-SCRIPT]` when scanning an artifact to discover relevant control scripts for that section.

## Receipts (recommended)

Write a `DONE.json` receipt adjacent to the ISSUE mirror artifact listing:

- inputs (issue URLs, labels/status)
- outputs (ISSUE mirror doc)
- checks run (format/header compliance)
