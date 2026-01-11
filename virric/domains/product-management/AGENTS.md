# AGENTS.md (domain stub) — <product-management>

Primary domain: `<product-management>`

This domain uses the canonical VIRRIC handoff at `virric/AGENTS.md`.

## What you produce

- `product-spec` artifacts (requirements, flows, acceptance criteria, validation plan, evidence/rationale)

Canonical location:
- `virric/domains/product-management/docs/product-specs/SPEC-*.md`

## Workflow intent (tight)

`<product-management>` turns upstream intent into **testable requirements**:

- Inputs (constraints, not suggestions):
  - `<product-strategy>`: bet + scope boundaries + sequencing constraints (ROADMAP-*)
  - `<product-marketing>`: persona + proposition constraints (PER-*, PROP-*)
  - `<research>`: evidence + unknowns (RA bundles, EvidenceIDs)
- Output:
  - A SPEC that can be decomposed into FRs with clear acceptance tests.

## Hard rules (to prevent drift)

- **Do not invent** new personas, propositions, or research claims here.
  - If you need a new persona/proposition, route it back to `<product-marketing>`.
  - If you need new evidence, route it back to `<research>`.
- **Keep traceability tight**:
  - Any `RA-*`, `PER-*`, `PROP-*`, `PITCH-*`, `RS-*`, `E-*`, `CPE-*` you reference must exist in the global registry.
  - `Dependencies:` header must include the upstream artifacts you relied on (at minimum: `RA-*` plus any `PER-*`/`PROP-*`/`ROADMAP-*` referenced).
- **Prefer constraints over creativity**:
  - If the proposition says “we must not claim X”, the SPEC must not encode X.
  - If research confidence is C1/C2, the SPEC must treat it as hypothesis and propose validation.

## ID hygiene (required)

Before finalizing a SPEC for PR, run:

```bash
./virric/virric-core/bin/virric id validate
./virric/virric-core/bin/virric id where RA-001
```

And run `where <ID>` for any ID you cite in the SPEC.

## Receipts (required for PR-ready work)

Write `DONE.json` adjacent to the SPEC listing:
- inputs (RA/ROADMAP/PER/PROP pointers; EvidenceIDs used)
- outputs (SPEC path)
- checks run (ID registry validate; any domain validators)

## Operating boundary

- Use the `<product-management>` tag to indicate scope/boundaries in handoffs.
- Avoid “go to this directory” pointers inside handoff/spec docs; those can hijack an agent early.
- Artifacts for this domain live in canonical `docs/`, `templates/`, `scripts/`, and `signals/` areas within the repo.

## In-doc script hints (`[V-SCRIPT]`)

Some templates/artifacts include fenced code blocks that begin with `[V-SCRIPT]:`.
Search for `[V-SCRIPT]` to quickly discover relevant control scripts for the nearby section.


