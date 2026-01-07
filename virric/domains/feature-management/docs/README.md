# Feature Management (Domain)

Primary artifacts:
- `feature-request` (FR) — bash-parseable Markdown dossier created/managed by VIRRIC.

Canonical locations:
- FR dossiers: `virric/domains/feature-management/docs/frs/FR-*.md`
- Auto-generated:
  - `virric/domains/feature-management/docs/backlog_tree.md`
  - `virric/domains/feature-management/docs/fr_dependencies.md`
- Templates: `virric/domains/feature-management/templates/`

Primary commands:
- `./virric/domains/feature-management/scripts/create_fr.sh`
- `./virric/domains/feature-management/scripts/validate_fr.sh`
- `./virric/domains/feature-management/scripts/approve_fr.sh --id FR-001`
- `./virric/domains/feature-management/scripts/update_fr_status.sh virric/domains/feature-management/docs/frs/FR-001-... \"In Progress\"`


