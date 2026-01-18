# AGENTS.md (domain stub) — <research>

Primary domain: `<research>`

This domain uses the canonical PHOSPHENE handoff at `phosphene/AGENTS.md`.

## What you produce

- `research-assessment` (RA bundles: coversheet + annexes + evidence + pitches)

## Operating boundary

- Use the `<research>` tag to indicate scope/boundaries in handoffs.
- Avoid “go to this directory” pointers inside handoff/spec docs; those can hijack an agent early.
- Artifacts for this domain live in canonical `output/`, `tools/`, and `signals/` areas within the repo.

## In-doc script hints (`[V-SCRIPT]`)

Some artifacts include fenced code blocks that begin with `[V-SCRIPT]:`.
Search for `[V-SCRIPT]` to quickly discover relevant control scripts for the nearby section.

## Practical workflow (script-driven RA bundles)

When producing a research assessment, prefer using the domain tools to enforce the bundle contract:

- Create a new RA bundle folder (allocates RA IDs if needed):
  - `./phosphene/domains/research/tools/create_research_assessment_bundle.sh ...`
- Validate bundle structure + cross-references:
  - `./phosphene/domains/research/tools/validate_research_assessment_bundle.sh <bundle_dir>`
- Assemble a single-file view (for human reading):
  - `./phosphene/domains/research/tools/assemble_research_assessment_bundle.sh <bundle_dir>`
- Rebuild + validate global ID uniqueness:
  - `./phosphene/phosphene-core/bin/phosphene id build`
  - `./phosphene/phosphene-core/bin/phosphene id validate`

If an agent produces a large raw narrative first, preserve it as `99-raw-agent-output.md` inside the bundle, then distill it into the canonical bundle files and re-run validation until green.


