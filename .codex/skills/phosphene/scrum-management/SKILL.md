---
name: scrum-management
description: Produce <scrum-management> issue mirrors and lightweight operational artifacts; keep routing/status portable via labels.
metadata:
  short-description: Operational issues + mirrors
---

## Domain

Primary domain: `<scrum-management>`

## What you produce

- Optional issue mirror docs (scaffold): `phosphene/domains/scrum-management/docs/issues/ISSUE-*.md`

## How to work

- Treat Issues (GitHub/Linear) as optional UX; keep the automation contract portable (labels + PR events).
- If mirroring state into repo headers, do so via PR (audit trail).
- Use templates under `phosphene/domains/scrum-management/templates/`.

## In-doc script hints (`[V-SCRIPT]`)

Some templates/artifacts include fenced code blocks that begin with `[V-SCRIPT]:`.
Search for `[V-SCRIPT]` when scanning an artifact to discover relevant control scripts for that section.

## Scripts (entrypoints and purpose)

No domain scripts yet (templates-first):
- Use `phosphene/domains/scrum-management/templates/issue.md` for ISSUE mirror docs when/if you mirror operational state into the repo.

## DONE signal (required)

Write a DONE signal named after the ISSUE mirror you produced/updated:
- `phosphene/domains/scrum-management/signals/<ISSUE-###>-DONE.json`

Include (minimum) listing:

- inputs (issue URLs, labels/status)
- outputs (ISSUE mirror doc)
- checks run (format/header compliance)
