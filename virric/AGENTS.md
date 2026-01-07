# VIRRIC — Agent Handoff (drop-in)

This repository contains a drop-in **`virric/`** folder that provides deterministic SDLC workflows via bash scripts and structured FR artifacts.

## Read this first

- **Primary workflow doc**: this file (`virric/AGENTS.md`)
- **Optional skills inventory**: `virric/skill.md` (not all agents support it; treat as supplemental)

## What VIRRIC is (in one sentence)

VIRRIC is a **bash-first SDLC control plane**: it creates and manages **Feature Requests (FRs)** as canonical XML “feature dossiers”, and provides deterministic commands for validation, status transitions, dependency analysis, and reporting.

## Canonical work items

- **Source of truth**: `FR_management/**/*.md` (FR dossiers; bash-parseable Markdown)
- **Auto-generated** (do not edit):
  - `FR_management/backlog_tree.md`
  - `FR_management/fr_dependencies.md`

## Install / init (required per repo)

Run from the repo root:

```bash
./virric/install.sh --project-dir .
```

Notes:
- This creates `.virric/config.env` so scripts can auto-discover project paths from anywhere.
- VIRRIC is **single-dir only**: FRs live under `FR_management/frs/` and status is tracked in the FR header.

## Day-to-day commands (bash)

### Create an FR

```bash
./virric/scripts/fr/create_fr.sh --title "..." --description "..." --priority "High"
```

### Validate FRs

```bash
./virric/scripts/fr/validate_fr.sh
```

### Approve an FR

```bash
./virric/scripts/fr/approve_fr.sh --id FR-001
```

### Update FR status

```bash
./virric/scripts/fr/update_fr_status.sh /path/to/FR-001-some-title.md "In Progress"
```

### Refresh project overviews

```bash
./virric/scripts/fr/update_backlog_tree.sh
./virric/scripts/fr/fr_dependency_tracker.sh
```

## GitHub Actions alignment (optional)

VIRRIC can emit **signals** under `virric/signals/**` to trigger CI workflows (templates live under `virric/workflows/`).

Install the workflow templates into `.github/workflows/`:

```bash
./virric/scripts/ci/install_github_actions.sh
```

## GitHub Issues alignment (optional)

If the GitHub CLI is available (`gh`) and `GH_TOKEN` is set, VIRRIC can create/update issues from FR metadata (optional, not required for core operation):

```bash
./virric/scripts/gh/issue_upsert_from_fr.sh /path/to/FR-001-some-title.md --dry-run false
```


