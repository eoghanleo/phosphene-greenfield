---
name: feature-management
description: Produce and manage <feature-management> Feature Requests (FR dossiers) using bash-only PHOSPHENE scripts (create/validate/approve/status/deps).
metadata:
  short-description: Feature Requests (FR dossiers)
---

## Domain

Primary domain: `<feature-management>`

## What you produce

- Feature Requests as bash-parseable Markdown dossiers:
  - `phosphene/domains/feature-management/output/frs/FR-###-*.md`

Auto-generated (do not edit by hand):
- `phosphene/domains/feature-management/output/backlog_tree.md`
- `phosphene/domains/feature-management/output/fr_dependencies.md`

## Script-first workflow (preferred)

- Create an FR:
  - `./.codex/skills/phosphene/cerulean/feature-management/modulator/scripts/create_feature_request.sh --title "..." --description "..." --priority "High"`
- Validate:
  - `./.github/scripts/validate_feature_request.sh`
- Approve (by ID):
  - `./.codex/skills/phosphene/cerulean/feature-management/modulator/scripts/approve_feature_request.sh --id FR-001`
- Update status:
  - `./.codex/skills/phosphene/cerulean/feature-management/modulator/scripts/update_feature_request_status.sh <path-to-fr.md> "In Progress"`
- Refresh reports:
  - `./.codex/skills/phosphene/cerulean/feature-management/modulator/scripts/update_backlog_tree.sh`
  - `./.codex/skills/phosphene/cerulean/feature-management/modulator/scripts/feature_request_dependency_tracker.sh`

## In-doc script hints (`[V-SCRIPT]`)

Some templates/artifacts include fenced code blocks that begin with `[V-SCRIPT]:`.
Search for `[V-SCRIPT]` when scanning an artifact to discover relevant control scripts for that section.

## Scripts (entrypoints and purpose)

- `create_feature_request.sh`: Create a new FR dossier from the template (allocates folder + file).
- `validate_feature_request.sh`: Validate FR dossier structure and repo-level FR invariants.
- `approve_feature_request.sh`: Approve an FR by ID (status transition).
- `update_feature_request_status.sh`: Update the status field in an FR dossier.
- `update_backlog_tree.sh`: Regenerate `output/backlog_tree.md` (auto-generated view).
- `feature_request_dependency_tracker.sh`: Regenerate `output/fr_dependencies.md` (auto-generated dependency report).

## DONE signal (required)

When completing an FR change, add a DONE signal named after the FR you updated/approved:
- `phosphene/signals/<FR-###>-DONE.json`

Include (minimum) enumerating:

- inputs (links/constraints)
- outputs (FR dossier + refreshed reports)
- checks run (validate + report refresh)

## Constraints

- Keep FR dossiers machine-parseable (strict header block; required headings).
- Prefer updating headers over moving files (single-layout stability).
