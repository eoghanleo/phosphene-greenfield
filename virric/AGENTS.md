# VIRRIC — Agent Handoff (drop-in)

This repository contains a drop-in **`virric/`** folder that provides deterministic SDLC workflows via bash scripts and structured FR artifacts.

## Read this first

- **Primary workflow doc**: this file (`virric/AGENTS.md`)
- **Optional skills inventory**: `virric/skill.md` (not all agents support it; treat as supplemental)

## What VIRRIC is (in one sentence)

VIRRIC is a **bash-first SDLC control plane**: it provides a **multi-domain product execution scaffold** (documents + contracts) and deterministic bash tooling for the **feature-management** domain (FR lifecycle, validation, status transitions, dependency reporting).

## Domain assignment (primary operating mode)

Incoming agents should be told a single string:

- **Primary domain**: one of the nine domains listed below.

If you have that domain, do this:

- Read **this file** (`virric/AGENTS.md`) for the contract and default handoffs.
- If you support `skill.md`, also read `virric/skill.md`.
- Go to the domain folder at repo root and use its templates:
  - Example: domain = `research` → open `research/README.md` and `research/templates/`.

### Nine domains (canonical)

- **ideation** → artifacts: `idea` → `ideation/`
- **research** → artifacts: `research-assessment` → `research/`
- **product-marketing** → artifacts: `persona`, `proposition` → `product-marketing/`
- **product-strategy** → artifacts: `product-roadmap` → `product-strategy/`
- **product-management** → artifacts: `product-spec` → `product-management/`
- **feature-management** → artifacts: `feature-request` → `feature-management/`
- **scrum-management** → artifacts: `issue` → `scrum-management/`
- **test-management** → artifacts: `test-plan` → `test-management/`
- **retrospective** → artifacts: `postmortem`, `playbook` → `retrospective/`

## Canonical work items

- **Source of truth**: repo-native SDLC docs across the nine domains (see domain folders at repo root).
- **Feature-management source of truth**: `feature-management/**/*.md` (FR dossiers; bash-parseable Markdown)
- **Auto-generated** (do not edit):
  - `feature-management/backlog_tree.md`
  - `feature-management/fr_dependencies.md`

## Install / init (required per repo)

Run from the repo root:

```bash
./virric/install.sh --project-dir .
```

Notes:
- This creates `.virric/config.env` so scripts can auto-discover project paths from anywhere.
- VIRRIC is **single-dir only**: FRs live under `feature-management/frs/` and status is tracked in the FR header.

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


