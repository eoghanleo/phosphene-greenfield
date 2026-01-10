---
name: feature-management
description: Produce and manage <feature-management> Feature Requests (FR dossiers) using bash-only VIRRIC scripts (create/validate/approve/status/deps).
metadata:
  short-description: Feature Requests (FR dossiers)
---

## Domain

Primary domain: `<feature-management>`

## What you produce

- Feature Requests as bash-parseable Markdown dossiers:
  - `virric/domains/feature-management/docs/frs/FR-###-*.md`

Auto-generated (do not edit by hand):
- `virric/domains/feature-management/docs/backlog_tree.md`
- `virric/domains/feature-management/docs/fr_dependencies.md`

## Script-first workflow (preferred)

- Create an FR:
  - `./virric/domains/feature-management/scripts/create_feature_request.sh --title "..." --description "..." --priority "High"`
- Validate:
  - `./virric/domains/feature-management/scripts/validate_feature_request.sh`
- Approve (by ID):
  - `./virric/domains/feature-management/scripts/approve_feature_request.sh --id FR-001`
- Update status:
  - `./virric/domains/feature-management/scripts/update_feature_request_status.sh <path-to-fr.md> "In Progress"`
- Refresh reports:
  - `./virric/domains/feature-management/scripts/update_backlog_tree.sh`
  - `./virric/domains/feature-management/scripts/feature_request_dependency_tracker.sh`

## In-doc script hints (`[V-SCRIPT]`)

Some templates/artifacts include fenced code blocks that begin with `[V-SCRIPT]:`.
Search for `[V-SCRIPT]` when scanning an artifact to discover relevant control scripts for that section.

## Receipts (recommended)

When completing an FR change, add a `DONE.json` receipt adjacent to the FR dossier enumerating:

- inputs (links/constraints)
- outputs (FR dossier + refreshed reports)
- checks run (validate + report refresh)

## Constraints

- Keep FR dossiers machine-parseable (strict header block; required headings).
- Prefer updating headers over moving files (single-layout stability).
