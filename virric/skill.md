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
    - FRs live under `feature-management/frs/` and status updates edit headers (no file moves)
- Generate project overviews and reports
  - `feature-management/backlog_tree.md`
  - `feature-management/fr_dependencies.md`
  - `feature-management/fr_report.*`
- Emit CI “signals” under `virric/signals/**` for GitHub Actions workflows
- (Optional) Sync FRs to GitHub Issues via `gh` CLI

## Primary commands

- `./virric/install.sh --project-dir . [--fr-layout status_dirs|single_dir]`
- `./virric/scripts/fr/create_fr.sh`
- `./virric/scripts/fr/validate_fr.sh`
- `./virric/scripts/fr/update_fr_status.sh`
- `./virric/scripts/fr/approve_fr.sh`
- `./virric/scripts/fr/update_backlog_tree.sh`
- `./virric/scripts/fr/fr_dependency_tracker.sh`
- `./virric/scripts/reporting/fr_report_generator.sh`
- `./virric/scripts/ci/install_github_actions.sh`
- `./virric/scripts/gh/issue_upsert_from_fr.sh`


