# Feature Management (Domain)

Primary artifacts:
- `feature-request` (FR) — bash-parseable Markdown dossier created/managed by PHOSPHENE.

Canonical locations:
- FR dossiers: `phosphene/domains/feature-management/docs/frs/FR-*.md`
- Auto-generated:
  - `phosphene/domains/feature-management/docs/backlog_tree.md`
  - `phosphene/domains/feature-management/docs/fr_dependencies.md`

Primary commands:
- `./phosphene/domains/feature-management/scripts/create_feature_request.sh`
- `./phosphene/domains/feature-management/scripts/validate_feature_request.sh`
- `./phosphene/domains/feature-management/scripts/approve_feature_request.sh --id FR-001`
- `./phosphene/domains/feature-management/scripts/update_feature_request_status.sh phosphene/domains/feature-management/docs/frs/FR-001-... \"In Progress\"`


