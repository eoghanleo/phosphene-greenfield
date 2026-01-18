---
name: product-management
description: Produce <product-management> artifacts (SPEC-*) that translate strategy into requirements, acceptance criteria, and validation plans.
metadata:
  short-description: Product specs (requirements)
---

## Domain

Primary domain: `<product-management>`

## What you produce

- Product specs: `phosphene/domains/product-management/output/product-specs/SPEC-*.md`

## How to work

- Treat upstream artifacts as **constraints**, not suggestions:
  - `<product-strategy>` defines the bet + sequencing constraints.
  - `<product-marketing>` defines persona + proposition constraints (what must be true for the pitch to land).
  - `<research>` defines evidence + unknowns (what is known vs hypothesized).
- Create artifacts directly under `phosphene/domains/product-management/output/product-specs/` (templates are intentionally not used).
- Keep acceptance criteria and validation experiments explicit.
- Keep the output **bash-parseable and reviewable** (stable header block; consistent IDs).

## In-doc script hints (`[V-SCRIPT]`)

Some templates/artifacts include fenced code blocks that begin with `[V-SCRIPT]:`.
Search for `[V-SCRIPT]` when scanning an artifact to discover relevant control scripts for that section.

## Scripts (entrypoints and purpose)

No domain scripts yet:
- Write SPEC artifacts directly.
- Do **not** hand-edit upstream script-managed artifacts (PER/PROP/RA bundles); treat them as inputs.

## Tightening moves (from observed agent output failures)

These are the “rails” that prevent the kinds of drift we saw in `<product-marketing>` (bad traceability, header/body mismatch, and manual-edit breakage):

- **Traceability is mandatory**:
  - Every referenced upstream ID in the SPEC must resolve via the global registry (`where`).
  - If you cite EvidenceIDs, they must exist in the RA evidence bank.
- **Header/body consistency**:
  - `Dependencies:` must include every top-level artifact you materially relied on (at minimum: `RA-*` plus any `PER-*`/`PROP-*`/`ROADMAP-*` you reference).
- **No new claims without support**:
  - If a requirement is justified by user need, link it to a `PER-*` JTBD ID and/or `EvidenceID` (or explicitly mark as hypothesis + confidence).

## ID hygiene (required)

Before finalizing a SPEC, run:

```bash
./phosphene/domains/research/scripts/research_id_registry.sh validate
./phosphene/domains/research/scripts/research_id_registry.sh where RA-001
./phosphene/domains/research/scripts/research_id_registry.sh where PER-0003
./phosphene/domains/research/scripts/research_id_registry.sh where PROP-0002
./phosphene/domains/research/scripts/research_id_registry.sh where E-0009
```

If an ID doesn’t resolve, you must either:
- fix the reference, or
- create the authoritative upstream artifact first (in its correct domain).

## DONE signal (required for PR-ready work)

Write a DONE signal named after the SPEC you produced:
- `phosphene/domains/product-management/signals/<SPEC-###>-DONE.json`

Include (minimum) listing:

- inputs (ROADMAP + persona/proposition + RA pointers)
- outputs (SPEC doc)
- checks run (format/header compliance; any domain validators if/when added)
