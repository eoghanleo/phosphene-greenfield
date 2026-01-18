---
name: retrospective
description: Produce <retrospective> artifacts (postmortems, playbooks) capturing lessons, root causes, and guardrails for future work.
metadata:
  short-description: Postmortems + playbooks
---

## Domain

Primary domain: `<retrospective>`

## What you produce

- Postmortems: `phosphene/domains/retrospective/docs/postmortems/PM-*.md`
- Playbooks: `phosphene/domains/retrospective/docs/playbooks/PB-*.md`

## How to work

- Start from merged PRs, incident reports, and outcomes.
- Create artifacts directly under:
  - `phosphene/domains/retrospective/docs/postmortems/`
  - `phosphene/domains/retrospective/docs/playbooks/`
- Keep learnings actionable: what changed, what to keep, what to automate/validate next time.

## In-doc script hints (`[V-SCRIPT]`)

Some templates/artifacts include fenced code blocks that begin with `[V-SCRIPT]:`.
Search for `[V-SCRIPT]` when scanning an artifact to discover relevant control scripts for that section.

## Scripts (entrypoints and purpose)

No domain scripts yet:
- Write PM/PB artifacts directly (then write a DONE signal when complete).

## DONE signal (required)

Write a DONE signal named after the retrospective artifact you produced:
- `phosphene/domains/retrospective/signals/<PM-###>-DONE.json` or `phosphene/domains/retrospective/signals/<PB-###>-DONE.json`

Include (minimum) listing:

- inputs (PRs/issues/notes)
- outputs (PM/PB docs)
- checks run (format/header compliance)
