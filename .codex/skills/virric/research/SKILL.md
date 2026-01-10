---
name: research
description: Produce <research> artifacts (RA bundles) using VIRRIC scripts and global unique IDs (E-/RS-/PITCH-/SEG-/CPE-/PER-).
metadata:
  short-description: Research assessments (RA bundles)
---

## Domain

Primary domain: `<research>`

## What you produce

- Research Assessments as **bundle folders** under `virric/domains/research/docs/research-assessments/RA-###-<slug>/`.

Bundle files (required):
- `00-coversheet.md`
- `10-reference-solutions.md`
- `20-competitive-landscape.md`
- `30-pitches/PITCH-*.md`
- `40-hypotheses.md`
- `50-evidence-bank.md`
- `90-methods.md`

Optional:
- `99-raw-agent-output.md` (verbatim raw dump; **non-authoritative**)

Generated (view only):
- `RA-###.md` (assembled; do not treat as authoritative definitions)

## Global ID uniqueness (hard requirement)

All object IDs must be globally unique across `virric/domains/**/docs/**`:

- EvidenceIDs: `E-####`
- RefSolIDs: `RS-####`
- PitchIDs: `PITCH-####`
- SegmentIDs: `SEG-####`
- CandidatePersonaIDs (research → marketing candidates): `CPE-####`
- PersonaIDs (canonical; <product-marketing> only): `PER-####`

Use the registry:

- Build: `./virric/domains/research/scripts/research_id_registry.sh build`
- Validate: `./virric/domains/research/scripts/research_id_registry.sh validate`
- Allocate: `./virric/domains/research/scripts/research_id_registry.sh next --type ra|pitch|evidence|refsol|segment|cpe|persona`

## Script-first workflow (preferred)

- Create RA bundle:
  - `./virric/domains/research/scripts/create_research_assessment_bundle.sh --title "..." --priority Medium`
- Validate bundle:
  - `./virric/domains/research/scripts/validate_research_assessment_bundle.sh <bundle_dir>`
- Assemble single-file view:
  - `./virric/domains/research/scripts/assemble_research_assessment_bundle.sh <bundle_dir>`
- Create pitches / add evidence / add reference solutions:
  - `./virric/domains/research/scripts/create_product_pitch.sh <bundle_dir>`
  - `./virric/domains/research/scripts/add_evidence_record.sh <bundle_dir>`
  - `./virric/domains/research/scripts/add_reference_solution.sh <bundle_dir>`
- Create candidate personas (1:1 proposals for <product-marketing> personas):
  - `./virric/domains/research/scripts/create_candidate_persona.sh --bundle <bundle_dir> --name "..." --segment SEG-0001`

## In-doc script hints (`[V-SCRIPT]`)

Some templates/artifacts include fenced code blocks that begin with `[V-SCRIPT]:`.
Search for `[V-SCRIPT]` when scanning an artifact to discover relevant control scripts for that section.

## Scripts (entrypoints and purpose)

- `create_research_assessment_bundle.sh`: Create a new RA bundle folder from templates; allocates the next `RA-###` if omitted.
- `validate_research_assessment_bundle.sh`: Validate RA bundle structure, headings, cross-references, and required folders.
- `assemble_research_assessment_bundle.sh`: Generate the assembled `RA-###.md` view from bundle parts (non-authoritative).
- `research_id_registry.sh`: Build/validate/query the global `id_index.tsv`, and allocate the next IDs (`ra|pitch|evidence|refsol|segment|cpe|persona|proposition`).
- `create_product_pitch.sh`: Create a new `PITCH-####` file in an RA bundle (allocates ID).
- `add_evidence_record.sh`: Append a new EvidenceID row (`E-####`) to `50-evidence-bank.md` (allocates ID).
- `add_reference_solution.sh`: Append a new RefSol row (`RS-####`) to `10-reference-solutions.md` (allocates ID).
- `create_candidate_persona.sh`: Create a new Candidate Persona (`CPE-####`) doc inside an RA bundle (allocates ID).

## Receipts (recommended)

When done, write `DONE.json` in the bundle root (receipt, not signal) enumerating:

- inputs (idea stub, constraints, etc.)
- outputs (bundle files)
- checks run (validate bundle, assemble, ID registry validate)

## Constraints

- Web-only research (no interviews) unless explicitly authorized.
- Keep product definition light; prioritize reference solutions, competition, segment/persona hypotheses, and candidate pitches.
