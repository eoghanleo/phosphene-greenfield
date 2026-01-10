---
name: product-marketing
description: Produce <product-marketing> artifacts (PER-* personas, PROP-* propositions) from research hypotheses and evidence IDs.
metadata:
  short-description: Personas + propositions
---

## Domain

Primary domain: `<product-marketing>`

## What you produce

- Personas: `virric/domains/product-marketing/docs/personas/PER-*.md`
- Propositions: `virric/domains/product-marketing/docs/propositions/PROP-*.md`

## How to work

- Start from `<research>` outputs:
  - Candidate Personas: `CPE-*` docs inside the RA bundle (`60-candidate-personas/`)
  - Segments/persona hypotheses, EvidenceIDs, and the pitch set
- Use templates under `virric/domains/product-marketing/templates/`.
- Treat personas/segments as hypotheses unless validated; include confidence and EvidenceIDs when making claims.
- When creating a canonical Persona (PER-*), treat it as a **promotion** of one or more CPE candidates (cite source CPE IDs).

## In-doc script hints (`[V-SCRIPT]`)

Persona templates include fenced code blocks that begin with `[V-SCRIPT]:` listing the relevant script entrypoints for that section.
Search for `[V-SCRIPT]` when scanning a persona artifact to discover the right control scripts quickly.

JTBD IDs convention (natural keys):
- Jobs/Pains/Gains use IDs of the form: `JTBD-<TYPE>-####-<PersonaID>`
  - `<TYPE>` is `JOB|PAIN|GAIN`
  - `<PersonaID>` is the persona `PER-####` from the file header

## Validation (recommended)

- Validate a persona:
  - `./virric/domains/product-marketing/scripts/validate_persona.sh virric/domains/product-marketing/docs/personas/PER-0001.md`
- Validate a proposition:
  - `./virric/domains/product-marketing/scripts/validate_proposition.sh virric/domains/product-marketing/docs/propositions/PROP-0001.md`
- Validate all personas:
  - `./virric/domains/product-marketing/scripts/validate_persona.sh --all`
- Validate all propositions:
  - `./virric/domains/product-marketing/scripts/validate_proposition.sh --all`

## Scripts (entrypoints and purpose)

All scripts are **control scripts** (script-first; avoid hand-editing). Most scripts re-run validators after applying changes.

### Personas (PER-*)

- `create_new_persona.sh`: Create a new persona doc from the template; allocates the next `PER-####`.
- `validate_persona.sh`: Validate persona headers/sections/JTBD tables and ID conventions.
- `update_persona_summary.sh`: Replace the `## Snapshot summary` section.
- `add_persona_jtbd_item.sh`: Append a new JOB/PAIN/GAIN row with the next `JTBD-<TYPE>-####-<PersonaID>`.
- `update_persona_jtbd_item.sh`: Update an existing JTBD row by JTBD ID.
- `add_persona_evidence_link.sh`: Add a supporting ID into EvidenceIDs / CandidatePersonaIDs / DocumentIDs (routes by prefix).
- `remove_persona_evidence_link.sh`: Remove a supporting ID from those buckets.
- `add_persona_related_link.sh`: Add a link under `### Links`.
- `remove_persona_related_link.sh`: Remove a link under `### Links`.
- `add_persona_note.sh`: Append a timestamped note entry under `## Notes`.
- `overwrite_persona_notes.sh`: Replace the entire `## Notes` section.

### Propositions (PROP-*)

- `create_new_proposition.sh`: Create a new proposition doc from the template; allocates the next `PROP-####`.
- `validate_proposition.sh`: Validate proposition headers/sections/tables and ID conventions.
- `update_proposition_formal_pitch.sh`: Replace the `## Formal Pitch` section (keeps the `[V-SCRIPT]` block).
- `add_proposition_target_persona.sh`: Add a `PER-####` bullet under `## Target Persona(s)`.
- `remove_proposition_target_persona.sh`: Remove a `PER-####` bullet from that list.
- `add_proposition_related_segment.sh`: Add a `SEG-####` bullet under `## Related Segment(s)`.
- `remove_proposition_related_segment.sh`: Remove a `SEG-####` bullet from that list.
- `add_proposition_gain_booster.sh`: Add a `BOOST-####-PROP-####` row and mapped `JTBD-GAIN-####-PER-####` list.
- `update_proposition_gain_booster.sh`: Update a booster row by BoosterID.
- `add_proposition_pain_reliever.sh`: Add a `REL-####-PROP-####` row and mapped `JTBD-PAIN-####-PER-####` list.
- `update_proposition_pain_reliever.sh`: Update a reliever row by RelieverID.
- `add_proposition_capability.sh`: Add a `CAP-####-PROP-####` row with type `feature|function|standard|experience`.
- `update_proposition_capability.sh`: Update a capability row by CapabilityID.
- `add_proposition_note.sh`: Append a timestamped note entry under `## Notes`.
- `overwrite_proposition_notes.sh`: Replace the entire `## Notes` section.

## Script helpers (optional)

- Add a JOB/PAIN/GAIN JTBD row (auto-allocates the next local #### and appends `-PER-####`):
  - `./virric/domains/product-marketing/scripts/add_persona_jtbd_item.sh --persona virric/domains/product-marketing/docs/personas/PER-0001.md --type JOB --text "..." --importance 3`

## Control scripts (preferred; avoid hand-editing)

For repeatability, prefer using these scripts instead of manual edits:

- Create a new persona:
  - `./virric/domains/product-marketing/scripts/create_new_persona.sh --title "..." --dependencies "CPE-0001,RA-001"`
- Update snapshot summary:
  - `./virric/domains/product-marketing/scripts/update_persona_summary.sh --persona virric/domains/product-marketing/docs/personas/PER-0001-*.md --summary-file /path/to/summary.md`
- Add/update JTBD rows:
  - `./virric/domains/product-marketing/scripts/add_persona_jtbd_item.sh --persona ... --type JOB|PAIN|GAIN --text "..." --importance 3`
  - `./virric/domains/product-marketing/scripts/update_persona_jtbd_item.sh --persona ... --jtbd-id JTBD-PAIN-0001-PER-0001 --text "..." --importance 5`
- Add/remove supporting IDs (EvidenceIDs/CPE IDs/other DocumentIDs):
  - `./virric/domains/product-marketing/scripts/add_persona_evidence_link.sh --persona ... --id E-0001`
  - `./virric/domains/product-marketing/scripts/remove_persona_evidence_link.sh --persona ... --id E-0001`
- Add/remove related links:
  - `./virric/domains/product-marketing/scripts/add_persona_related_link.sh --persona ... --link "https://example.com"`
  - `./virric/domains/product-marketing/scripts/remove_persona_related_link.sh --persona ... --link "https://example.com"`
- Notes:
  - `./virric/domains/product-marketing/scripts/add_persona_note.sh --persona ... --note "..." `
  - `./virric/domains/product-marketing/scripts/overwrite_persona_notes.sh --persona ... --notes-file /path/to/notes.md`

### Propositions (PROP-*)

- Create a new proposition:
  - `./virric/domains/product-marketing/scripts/create_new_proposition.sh --title "..." --dependencies "PER-0001,RA-001"`
- Formal pitch:
  - `./virric/domains/product-marketing/scripts/update_proposition_formal_pitch.sh --proposition ... --pitch "Our <capabilities> help ..."`
- Target personas / related segments:
  - `./virric/domains/product-marketing/scripts/add_proposition_target_persona.sh --proposition ... --persona PER-0001`
  - `./virric/domains/product-marketing/scripts/remove_proposition_target_persona.sh --proposition ... --persona PER-0001`
  - `./virric/domains/product-marketing/scripts/add_proposition_related_segment.sh --proposition ... --segment SEG-0001`
  - `./virric/domains/product-marketing/scripts/remove_proposition_related_segment.sh --proposition ... --segment SEG-0001`
- Gain boosters / pain relievers:
  - `./virric/domains/product-marketing/scripts/add_proposition_gain_booster.sh --proposition ... --booster "..." --mapped-gains "JTBD-GAIN-0001-PER-0001"`
  - `./virric/domains/product-marketing/scripts/update_proposition_gain_booster.sh --proposition ... --booster-id BOOST-0001-PROP-0001 --mapped-gains "..."`
  - `./virric/domains/product-marketing/scripts/add_proposition_pain_reliever.sh --proposition ... --reliever "..." --mapped-pains "JTBD-PAIN-0001-PER-0001"`
  - `./virric/domains/product-marketing/scripts/update_proposition_pain_reliever.sh --proposition ... --reliever-id REL-0001-PROP-0001 --mapped-pains "..."`
- Capabilities:
  - `./virric/domains/product-marketing/scripts/add_proposition_capability.sh --proposition ... --type feature --capability "..."`
  - `./virric/domains/product-marketing/scripts/update_proposition_capability.sh --proposition ... --capability-id CAP-0001-PROP-0001 --type experience --capability "..."`
- Notes:
  - `./virric/domains/product-marketing/scripts/add_proposition_note.sh --proposition ... --note "..." `
  - `./virric/domains/product-marketing/scripts/overwrite_proposition_notes.sh --proposition ... --notes-file /path/to/notes.md`

## Receipts (recommended)

Write a `DONE.json` receipt adjacent to each produced artifact listing:

- inputs (pointers to research bundle files / EvidenceIDs)
- outputs (PER/PROP docs)
- checks run (format/header compliance; any domain validators if/when added)
