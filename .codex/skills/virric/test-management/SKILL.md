---
name: test-management
description: Produce <test-management> test plans (TP-*) and verification strategies aligned to specs/FRs.
metadata:
  short-description: Test plans
---

## Domain

Primary domain: `<test-management>`

## What you produce

- Test plans: `virric/domains/test-management/docs/test-plans/TP-*.md`

## How to work

- Start from `<product-management>` acceptance criteria and `<feature-management>` FR constraints.
- Use templates under `virric/domains/test-management/templates/`.
- Keep test scope explicit (unit/integration/e2e) and the “definition of done” checkable.

## In-doc script hints (`[V-SCRIPT]`)

Some templates/artifacts include fenced code blocks that begin with `[V-SCRIPT]:`.
Search for `[V-SCRIPT]` when scanning an artifact to discover relevant control scripts for that section.

## Receipts (recommended)

Write a `DONE.json` receipt adjacent to the TP artifact listing:

- inputs (SPEC/FR pointers)
- outputs (TP doc)
- checks run (format/header compliance; any domain validators if/when added)
