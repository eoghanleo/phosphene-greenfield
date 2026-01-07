# Feature Management (Domain)

Primary artifacts:
- `feature-request` (FR) — bash-parseable Markdown dossier created/managed by VIRRIC.

Canonical locations:
- FR dossiers: `feature-management/frs/FR-*.md`
- Auto-generated:
  - `feature-management/backlog_tree.md`
  - `feature-management/fr_dependencies.md`
- Templates: `feature-management/templates/`

Primary commands:
- `./virric/scripts/fr/create_fr.sh`
- `./virric/scripts/fr/validate_fr.sh`
- `./virric/scripts/fr/approve_fr.sh --id FR-001`
- `./virric/scripts/fr/update_fr_status.sh feature-management/frs/FR-001-... \"In Progress\"`


