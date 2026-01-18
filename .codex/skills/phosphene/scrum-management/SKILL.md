---
name: scrum-management
description: Produce <scrum-management> issue mirrors and lightweight operational artifacts; keep routing/status portable via labels.
metadata:
  short-description: Operational issues + mirrors
---

## Domain

Primary domain: `<scrum-management>`

## What you produce

- Optional issue mirror docs (scaffold): `phosphene/domains/scrum-management/output/issues/ISSUE-*.md`

## How to work

- Treat Issues (GitHub/Linear) as optional UX; keep the automation contract portable (labels + PR events).
- If mirroring state into repo headers, do so via PR (audit trail).
- Create artifacts directly under `phosphene/domains/scrum-management/output/issues/` (if/when you mirror issues into the repo).

## In-doc script hints (`[V-SCRIPT]`)

Some templates/artifacts include fenced code blocks that begin with `[V-SCRIPT]:`.
Search for `[V-SCRIPT]` when scanning an artifact to discover relevant control scripts for that section.

## Scripts (entrypoints and purpose)

No domain scripts yet:
- Write ISSUE mirror docs directly when/if you mirror operational state into the repo.

## DONE signal (required)

Write a DONE signal named after the ISSUE mirror you produced/updated:
- `phosphene/domains/scrum-management/signals/<ISSUE-###>-DONE.json`

Include (minimum) listing:

- inputs (issue URLs, labels/status)
- outputs (ISSUE mirror doc)
- checks run (format/header compliance)
