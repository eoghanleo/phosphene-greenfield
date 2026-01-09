---
name: virric-skill-index
description: VIRRIC skills index (mandatory). Canonical Codex skill definitions live under .codex/skills/**.
metadata:
  short-description: VIRRIC skills (index)
---

## Skills are mandatory in this repo

Canonical Codex skill definitions live under:

- `.codex/skills/**`

This file is a human-readable index and reminder of what the skills cover.

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

- `./virric/domains/feature-management/scripts/create_feature_request.sh`
- `./virric/domains/feature-management/scripts/validate_feature_request.sh`
- `./virric/domains/feature-management/scripts/update_feature_request_status.sh`
- `./virric/domains/feature-management/scripts/approve_feature_request.sh`
- `./virric/domains/feature-management/scripts/update_backlog_tree.sh`
- `./virric/domains/feature-management/scripts/feature_request_dependency_tracker.sh`

## Available Codex skills (canonical)

- Core harness: `.codex/skills/virric-core/SKILL.md`
- `<ideation>`: `.codex/skills/virric-ideation/SKILL.md`
- `<research>`: `.codex/skills/virric-research/SKILL.md`
- `<product-marketing>`: `.codex/skills/virric-product-marketing/SKILL.md`
- `<product-strategy>`: `.codex/skills/virric-product-strategy/SKILL.md`
- `<product-management>`: `.codex/skills/virric-product-management/SKILL.md`
- `<feature-management>`: `.codex/skills/virric-feature-management/SKILL.md`
- `<scrum-management>`: `.codex/skills/virric-scrum-management/SKILL.md`
- `<test-management>`: `.codex/skills/virric-test-management/SKILL.md`
- `<retrospective>`: `.codex/skills/virric-retrospective/SKILL.md`

Codex skill standard reference: [Codex skills standard](https://developers.openai.com/codex/skills/).


