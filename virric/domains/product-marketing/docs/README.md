# Product Marketing (Domain)

Primary artifacts:
- `persona` — who we serve and what they care about.
- `proposition` — what we promise and why it’s compelling.

Canonical locations:
- Templates: `virric/domains/product-marketing/templates/`
- Working artifacts:
  - `virric/domains/product-marketing/docs/personas/`
  - `virric/domains/product-marketing/docs/propositions/`

Validation (recommended):
- `./virric/domains/product-marketing/scripts/validate_persona.sh --all`

JTBD IDs convention (natural keys):
- In persona Jobs/Pains/Gains tables, use: `JTBD-<TYPE>-####-<PersonaID>`
  - `<TYPE>` is `JOB|PAIN|GAIN`
  - `<PersonaID>` is the persona `PER-####` from the file header

Helper (optional):
- `./virric/domains/product-marketing/scripts/add_persona_jtbd_item.sh --persona virric/domains/product-marketing/docs/personas/PER-0001.md --type JOB --text "..." --importance 3`

Handoff (default):
- **To Product Strategy** with market framing and messaging constraints.
- **To Product Management** with positioning that must be reflected in the spec.

Upstream input (common):
- `<research>` bundles may include **Candidate Personas** (`CPE-####`) under `60-candidate-personas/`.
  - Treat creating `PER-####` as a promotion step from one or more CPE candidates.


