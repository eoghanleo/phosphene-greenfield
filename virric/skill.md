# VIRRIC — Skills (supplemental)

Not all agents support `skill.md`. Treat this as **optional** context that complements `virric/AGENTS.md`.

## Capabilities

- Navigate and operate within a **nine-domain product execution scaffold**:
  - ideation, research, product-marketing, product-strategy, product-management,
    feature-management, scrum-management, test-management, retrospective
- Create structured **Feature Requests (FRs)** as bash-parseable Markdown “feature dossiers”
- Validate FR structure deterministically (bash-only header checks)
- Manage FR lifecycle via status transitions
  - **Single layout (machine-optimized)**:
    - FRs live under `virric/domains/feature-management/docs/frs/` and status updates edit headers (no file moves)
- Generate project overviews and reports
  - `virric/domains/feature-management/docs/backlog_tree.md`
  - `virric/domains/feature-management/docs/fr_dependencies.md`
  - `virric/domains/feature-management/docs/fr_report.*`
- Emit CI “signals” under `virric/domains/<domain>/signals/**` for GitHub Actions workflows

## Primary commands

- `./virric/domains/feature-management/scripts/create_fr.sh`
- `./virric/domains/feature-management/scripts/validate_fr.sh`
- `./virric/domains/feature-management/scripts/update_fr_status.sh`
- `./virric/domains/feature-management/scripts/approve_fr.sh`
- `./virric/domains/feature-management/scripts/update_backlog_tree.sh`
- `./virric/domains/feature-management/scripts/fr_dependency_tracker.sh`


