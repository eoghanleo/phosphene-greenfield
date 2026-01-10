---
name: product-management
description: Produce <product-management> artifacts (SPEC-*) that translate strategy into requirements, acceptance criteria, and validation plans.
metadata:
  short-description: Product specs (requirements)
---

## Domain

Primary domain: `<product-management>`

## What you produce

- Product specs: `virric/domains/product-management/docs/product-specs/SPEC-*.md`

## How to work

- Start from `<product-strategy>` bet selection and constraints.
- Pull in `<product-marketing>` persona/proposition constraints and `<research>` unknowns.
- Use templates under `virric/domains/product-management/templates/`.
- Keep acceptance criteria and validation experiments explicit.

## In-doc script hints (`[V-SCRIPT]`)

Some templates/artifacts include fenced code blocks that begin with `[V-SCRIPT]:`.
Search for `[V-SCRIPT]` when scanning an artifact to discover relevant control scripts for that section.

## Scripts (entrypoints and purpose)

No domain scripts yet (templates-first):
- Use `virric/domains/product-management/templates/product-spec.md` and write SPEC artifacts directly (then add a `DONE.json` receipt if desired).

## Receipts (recommended)

Write a `DONE.json` receipt adjacent to the SPEC artifact listing:

- inputs (ROADMAP + persona/proposition + RA pointers)
- outputs (SPEC doc)
- checks run (format/header compliance; any domain validators if/when added)
