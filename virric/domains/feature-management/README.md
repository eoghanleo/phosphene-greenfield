# Feature Management (Domain)

Primary artifacts:
- `feature-request` (FR) — bash-parseable Markdown dossier created/managed by VIRRIC.

Canonical locations:
- FR dossiers: `virric/domains/feature-management/frs/FR-*.md`
- Auto-generated:
  - `virric/domains/feature-management/backlog_tree.md`
  - `virric/domains/feature-management/fr_dependencies.md`
- Templates: `virric/domains/feature-management/templates/`

Primary commands:
- `./virric/scripts/fr/create_fr.sh`
- `./virric/scripts/fr/validate_fr.sh`
- `./virric/scripts/fr/approve_fr.sh --id FR-001`
- `./virric/scripts/fr/update_fr_status.sh virric/domains/feature-management/frs/FR-001-... \"In Progress\"`


