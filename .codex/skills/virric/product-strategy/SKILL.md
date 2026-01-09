---
name: virric-product-strategy
description: Produce <product-strategy> artifacts (ROADMAP-*) by selecting bets/pitches, constraints, and sequencing from research + marketing inputs.
metadata:
  short-description: Roadmaps + strategic bets
---

## Domain

Primary domain: `<product-strategy>`

## What you produce

- Product roadmaps: `virric/domains/product-strategy/docs/product-roadmaps/ROADMAP-*.md`

## How to work

- Start from `<research>` pitch set + competitive constraints + unknowns.
- Incorporate `<product-marketing>` constraints (ICP, messaging constraints, objections).
- Use templates under `virric/domains/product-strategy/templates/`.
- Keep bets explicit, with assumptions, risks, and “we lose when…” constraints.

## Receipts (recommended)

Write a `DONE.json` receipt adjacent to the ROADMAP artifact listing:

- inputs (pointers to RA coversheet/pitches; persona/proposition docs)
- outputs (ROADMAP doc)
- checks run (format/header compliance; any domain validators if/when added)
