# AGENTS.md (domain stub) — <product-marketing>

Primary domain: `<product-marketing>`

This domain uses the canonical VIRRIC handoff at `virric/AGENTS.md`.

## What you produce

- `persona` (PER-*) artifacts
- `proposition` (PROP-*) artifacts

## Workflow policy (script-first; no manual edits)

To maximize repeatable performance and reduce formatting faults:

- **Do not hand-edit** `<product-marketing>` artifacts.
- Use the domain scripts under `virric/domains/product-marketing/scripts/` to create and modify artifacts.
- Always run validators after mutations (most scripts do this automatically).

## In-doc script hints (`[V-SCRIPT]`)

Persona/proposition templates may include fenced code blocks that begin with `[V-SCRIPT]:`.
Search for `[V-SCRIPT]` when scanning an artifact to quickly discover the relevant script entrypoints.

## Operating boundary

- Use the `<product-marketing>` tag to indicate scope/boundaries in handoffs.
- Avoid “go to this directory” pointers inside handoff/spec docs; those can hijack an agent early.
- Artifacts for this domain live in canonical `docs/`, `templates/`, `scripts/`, and `signals/` areas within the repo.


