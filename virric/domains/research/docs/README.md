# Research (Domain)

Primary artifacts:
- `research-assessment` — reference-solution scan + competitive landscape + hypotheses + candidate product pitches (web-only).

Domain tag: `<research>`

## Research assessments (RA) are bundles

Deep research output should be stored as a **bundle folder** (not a single giant markdown file). This enables:

- deterministic validation (format compliance)
- lightweight database-style cross-linking (EvidenceIDs, RS-IDs, PITCH-IDs)
- fast downstream consumption (coversheet first; dive into annexes as needed)

## Global ID uniqueness (for grep + automation)

All object IDs (EvidenceIDs `E-####`, RefSolIDs `RS-####`, PitchIDs `PITCH-####`, etc.) must be **globally unique** across repo artifacts under `virric/domains/**/docs/**`.

This repo enforces that via an index + allocator script:

- Build/refresh index: `./virric/domains/research/scripts/research_id_registry.sh build`
- Validate uniqueness: `./virric/domains/research/scripts/research_id_registry.sh validate`
- Allocate next ID: `./virric/domains/research/scripts/research_id_registry.sh next --type evidence|pitch|refsol|ra`

Creation scripts call the allocator so new artifacts start compliant.

Bundle shape (required):
- `00-coversheet.md` (short cover letter)
- `10-reference-solutions.md` (RS table)
- `20-competitive-landscape.md` (competitor matrix)
- `30-pitches/` (`PITCH-*.md` files)
- `40-hypotheses.md` (segments/personas/jobs/pains/gains)
- `50-evidence-bank.md` (EvidenceID table)
- `90-methods.md` (method/log/bias/assumptions/etc.)

Naming convention (recommended):
- Bundle folder: `RA-001-<slug>/`
- RA ID format: `RA-001` (stable)

Handoff (default):
- **To `<product-strategy>`** when the research yields a recommendation and constraints (and a pitch set).


