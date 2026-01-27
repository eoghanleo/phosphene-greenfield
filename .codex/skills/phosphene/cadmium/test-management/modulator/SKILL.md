---
name: test-management
description: Produce <test-management> test plans (TP-*) and verification strategies aligned to specs/FRs.
metadata:
  short-description: Test plans
---

## Domain

Primary domain: `<test-management>`

## Status

TODO (not in development). Do not run this domain in live flows.

## What you produce

- Test plans: `phosphene/domains/test-management/output/test-plans/TP-*.md`

## How to work

- Start from `<product-management>` acceptance criteria and `<feature-management>` FR constraints.
- Create artifacts directly under `phosphene/domains/test-management/output/test-plans/` (templates are intentionally not used).
- Keep test scope explicit (unit/integration/e2e) and the “definition of done” checkable.

## In-doc script hints (`[V-SCRIPT]`)

Some templates/artifacts include fenced code blocks that begin with `[V-SCRIPT]:`.
Search for `[V-SCRIPT]` when scanning an artifact to discover relevant control scripts for that section.

## Scripts (entrypoints and purpose)

No domain scripts yet.

## DONE signal

Not active. DONE receipt scripts are not implemented for this domain yet.

Include (minimum) listing:

- inputs (SPEC/FR pointers)
- outputs (TP doc)
- checks run (format/header compliance; any domain validators if/when added)
