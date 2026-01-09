# AGENTS.md (domain stub) — <research>

Primary domain: `<research>`

This domain uses the canonical VIRRIC handoff at `virric/AGENTS.md`.

## What you produce

- `research-assessment` (RA bundles: coversheet + annexes + evidence + pitches)

## Operating boundary

- Use the `<research>` tag to indicate scope/boundaries in handoffs.
- Avoid “go to this directory” pointers inside handoff/spec docs; those can hijack an agent early.
- Artifacts for this domain live in canonical `docs/`, `templates/`, `scripts/`, and `signals/` areas within the repo.

## Practical workflow (script-driven RA bundles)

When producing a research assessment, prefer using the domain scripts to enforce the bundle contract:

- Create a new RA bundle folder (allocates RA IDs if needed):
  - `./virric/domains/research/scripts/create_research_assessment_bundle.sh ...`
- Validate bundle structure + cross-references:
  - `./virric/domains/research/scripts/validate_research_assessment_bundle.sh <bundle_dir>`
- Assemble a single-file view (for human reading):
  - `./virric/domains/research/scripts/assemble_research_assessment_bundle.sh <bundle_dir>`
- Rebuild + validate global ID uniqueness:
  - `./virric/domains/research/scripts/research_id_registry.sh build`
  - `./virric/domains/research/scripts/research_id_registry.sh validate`

If an agent produces a large raw narrative first, preserve it as `99-raw-agent-output.md` inside the bundle, then distill it into the canonical bundle files and re-run validation until green.


