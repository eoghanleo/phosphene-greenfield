---
name: product-strategy
description: Produce <product-strategy> artifacts (ROADMAP-*) by selecting bets/pitches, constraints, and sequencing from research + marketing inputs.
metadata:
  short-description: Roadmaps + strategic bets
---

## Domain

Primary domain: `<product-strategy>`

## What you produce

- Product roadmaps: `phosphene/domains/product-strategy/docs/product-roadmaps/ROADMAP-*.md`

## How to work

- Start from `<research>` pitch set + competitive constraints + unknowns.
- Incorporate `<product-marketing>` constraints (ICP, messaging constraints, objections).
- Use templates under `phosphene/domains/product-strategy/templates/`.
- Keep bets explicit, with assumptions, risks, and “we lose when…” constraints.

## In-doc script hints (`[V-SCRIPT]`)

Some templates/artifacts include fenced code blocks that begin with `[V-SCRIPT]:`.
Search for `[V-SCRIPT]` when scanning an artifact to discover relevant control scripts for that section.

## Scripts (entrypoints and purpose)

No domain scripts yet (templates-first):
- Use `phosphene/domains/product-strategy/templates/product-roadmap.md` and write ROADMAP artifacts directly (then write a DONE signal when complete).

## DONE signal (required)

Write a DONE signal named after the ROADMAP you produced:
- `phosphene/domains/product-strategy/signals/<ROADMAP-###>-DONE.json`

Include (minimum) listing:

- inputs (pointers to RA coversheet/pitches; persona/proposition docs)
- outputs (ROADMAP doc)
- checks run (format/header compliance; any domain validators if/when added)
