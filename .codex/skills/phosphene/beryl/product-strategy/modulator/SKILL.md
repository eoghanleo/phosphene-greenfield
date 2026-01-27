---
name: product-strategy
description: Produce <product-strategy> artifacts (ROADMAP-*) by selecting bets/pitches, constraints, and sequencing from research + marketing inputs.
metadata:
  short-description: Roadmaps + strategic bets
---

## Domain

Primary domain: `<product-strategy>`

## Status

TODO (not in development). Do not run this domain in live flows.

## What you produce

- Product roadmaps: `phosphene/domains/product-strategy/output/product-roadmaps/ROADMAP-*.md`

## How to work

- Start from `<research>` pitch set + competitive constraints + unknowns.
- Incorporate `<product-marketing>` constraints (ICP, messaging constraints, objections).
- Create artifacts directly under `phosphene/domains/product-strategy/output/product-roadmaps/` (templates are intentionally not used).
- Keep bets explicit, with assumptions, risks, and “we lose when…” constraints.

## In-doc script hints (`[V-SCRIPT]`)

Some templates/artifacts include fenced code blocks that begin with `[V-SCRIPT]:`.
Search for `[V-SCRIPT]` when scanning an artifact to discover relevant control scripts for that section.

## Scripts (entrypoints and purpose)

No domain scripts yet.

## DONE signal

Not active. DONE receipt scripts are not implemented for this domain yet.

Include (minimum) listing:

- inputs (pointers to RA coversheet/pitches; persona/proposition docs)
- outputs (ROADMAP doc)
- checks run (format/header compliance; any domain validators if/when added)
