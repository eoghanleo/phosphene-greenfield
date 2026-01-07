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
- Go to the domain folder under the drop-in:
  - Inventory: `virric/domains/<domain>/docs/`
  - Templates: `virric/domains/<domain>/templates/`
  - Scripts: `virric/domains/<domain>/scripts/`
  - Signals: `virric/domains/<domain>/signals/`
  - Example: domain = `research` → open `virric/domains/research/docs/README.md` and `virric/domains/research/templates/`.

### Nine domains (canonical)

- **ideation** → artifacts: `idea` → `virric/domains/ideation/`
- **research** → artifacts: `research-assessment` → `virric/domains/research/`
- **product-marketing** → artifacts: `persona`, `proposition` → `virric/domains/product-marketing/`
- **product-strategy** → artifacts: `product-roadmap` → `virric/domains/product-strategy/`
- **product-management** → artifacts: `product-spec` → `virric/domains/product-management/`
- **feature-management** → artifacts: `feature-request` → `virric/domains/feature-management/`
- **scrum-management** → artifacts: `issue` → `virric/domains/scrum-management/`
- **test-management** → artifacts: `test-plan` → `virric/domains/test-management/`
- **retrospective** → artifacts: `postmortem`, `playbook` → `virric/domains/retrospective/`

## Canonical work items

- **Source of truth**: repo-native SDLC docs across the nine domains (see domain folders at repo root).
- **Feature-management source of truth**: `virric/domains/feature-management/docs/**/*.md` (FR dossiers; bash-parseable Markdown)
- **Auto-generated** (do not edit):
  - `virric/domains/feature-management/docs/backlog_tree.md`
  - `virric/domains/feature-management/docs/fr_dependencies.md`

## Hard requirements (for now)

- `virric/` must exist at the **repo root**.
- Scripts assume canonical paths under `virric/domains/**`.

## Day-to-day commands (bash)

### Create an FR

```bash
./virric/domains/feature-management/scripts/fr/create_fr.sh --title "..." --description "..." --priority "High"
```

### Validate FRs

```bash
./virric/domains/feature-management/scripts/fr/validate_fr.sh
```

### Approve an FR

```bash
./virric/domains/feature-management/scripts/fr/approve_fr.sh --id FR-001
```

### Update FR status

```bash
./virric/domains/feature-management/scripts/fr/update_fr_status.sh /path/to/FR-001-some-title.md "In Progress"
```

### Refresh project overviews

```bash
./virric/domains/feature-management/scripts/fr/update_backlog_tree.sh
./virric/domains/feature-management/scripts/fr/fr_dependency_tracker.sh
```

## Automation (GitHub Actions)

Routing and validation are intended to be implemented as GitHub Actions that:

- infer domain scope from changed paths under `virric/domains/**`
- consume explicit signals under `virric/domains/<domain>/signals/**`
- gate “official” doc changes on PR events (merge to the default branch)


