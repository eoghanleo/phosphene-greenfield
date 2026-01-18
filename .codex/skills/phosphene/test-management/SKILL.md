---
name: test-management
description: Produce <test-management> test plans (TP-*) and verification strategies aligned to specs/FRs.
metadata:
  short-description: Test plans
---

## Domain

Primary domain: `<test-management>`

## What you produce

- Test plans: `phosphene/domains/test-management/docs/test-plans/TP-*.md`

## How to work

- Start from `<product-management>` acceptance criteria and `<feature-management>` FR constraints.
- Create artifacts directly under `phosphene/domains/test-management/docs/test-plans/` (templates are intentionally not used).
- Keep test scope explicit (unit/integration/e2e) and the “definition of done” checkable.

## In-doc script hints (`[V-SCRIPT]`)

Some templates/artifacts include fenced code blocks that begin with `[V-SCRIPT]:`.
Search for `[V-SCRIPT]` when scanning an artifact to discover relevant control scripts for that section.

## Scripts (entrypoints and purpose)

No domain scripts yet:
- Write TP artifacts directly (then write a DONE signal when complete).

## DONE signal (required)

Write a DONE signal named after the TP you produced:
- `phosphene/domains/test-management/signals/<TP-###>-DONE.json`

Include (minimum) listing:

- inputs (SPEC/FR pointers)
- outputs (TP doc)
- checks run (format/header compliance; any domain validators if/when added)
