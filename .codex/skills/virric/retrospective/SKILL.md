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

## In-doc script hints (`[V-SCRIPT]`)

Some templates/artifacts include fenced code blocks that begin with `[V-SCRIPT]:`.
Search for `[V-SCRIPT]` when scanning an artifact to discover relevant control scripts for that section.

## Scripts (entrypoints and purpose)

No domain scripts yet (templates-first):
- Use `virric/domains/retrospective/templates/postmortem.md` and `virric/domains/retrospective/templates/playbook.md`.

## Receipts (recommended)

Write a **single domain receipt** at `virric/domains/retrospective/DONE.json` (domain root; not in subfolders) listing:

- inputs (PRs/issues/notes)
- outputs (PM/PB docs)
- checks run (format/header compliance)
