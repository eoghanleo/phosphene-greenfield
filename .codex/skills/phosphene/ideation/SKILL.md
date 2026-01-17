---
name: ideation
description: Produce <ideation> artifacts (IDEA-*) as seed concepts for downstream domains; keep inputs minimal and hypotheses explicit.
metadata:
  short-description: Ideation (IDEA artifacts)
---

## Domain

Primary domain: `<ideation>`

## What you produce

- Ideas as repo artifacts:
  - `phosphene/domains/ideation/docs/ideas/IDEA-*.md`

## How to work

- Use templates under `phosphene/domains/ideation/templates/`.
- Keep the artifact short: problem/opportunity framing, target user hypotheses, and what to research next.
- Avoid over-committing to product definitions; treat as hypotheses for `<research>`.

## In-doc script hints (`[V-SCRIPT]`)

Some templates/artifacts include fenced code blocks that begin with `[V-SCRIPT]:`.
Search for `[V-SCRIPT]` when scanning an artifact to discover relevant control scripts for that section.

## Scripts (entrypoints and purpose)

No domain scripts yet (templates-first):
- Use `phosphene/domains/ideation/templates/idea.md` and write IDEA artifacts directly (then write a DONE signal when complete).

## DONE signal (required)

Write a DONE signal named after the IDEA you produced:
- `phosphene/domains/ideation/signals/<IDEA-###>-DONE.json`

Include (minimum) listing:

- inputs (prompt/context)
- outputs (the IDEA file)
- checks run (format/header compliance)
