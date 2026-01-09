# VIRRIC — Agent Handoff (drop-in)

This repository contains a drop-in **`virric/`** folder that provides deterministic SDLC workflows via bash scripts and structured FR artifacts.

## Read this first

- **Primary workflow doc**: this file (`virric/AGENTS.md`)
- **Optional skills inventory**: `virric/skill.md` (not all agents support it; treat as supplemental)

## What VIRRIC is (in one sentence)

VIRRIC is a **bash-first SDLC control plane**: it provides a **multi-domain product execution scaffold** (documents + contracts) and deterministic bash tooling for the **feature-management** domain (FR lifecycle, validation, status transitions, dependency reporting).

## Domain assignment (primary operating mode)

Incoming agents should be told a single string:

- **Primary domain**: one of the nine domains listed below (referenced as `<domain>`).

If you have that domain, do this:

- Read **this file** (`virric/AGENTS.md`) for the contract and default handoffs.
- If you support `skill.md`, also read `virric/skill.md`.

Domain reference convention:

- Use angle brackets when referring to domains: `<ideation>`, `<research>`, `<product-marketing>`, etc.
- Avoid embedding “go to this directory” pointers in handoff/spec docs; use the domain tag and let the agent decide navigation.

### Nine domains (canonical)

- `<ideation>` → artifacts: `idea`
- `<research>` → artifacts: `research-assessment`
- `<product-marketing>` → artifacts: `persona`, `proposition`
- `<product-strategy>` → artifacts: `product-roadmap`
- `<product-management>` → artifacts: `product-spec`
- `<feature-management>` → artifacts: `feature-request`
- `<scrum-management>` → artifacts: `issue`
- `<test-management>` → artifacts: `test-plan`
- `<retrospective>` → artifacts: `postmortem`, `playbook`

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
./virric/domains/feature-management/scripts/create_feature_request.sh --title "..." --description "..." --priority "High"
```

### Validate FRs

```bash
./virric/domains/feature-management/scripts/validate_feature_request.sh
```

### Approve an FR

```bash
./virric/domains/feature-management/scripts/approve_feature_request.sh --id FR-001
```

### Update FR status

```bash
./virric/domains/feature-management/scripts/update_feature_request_status.sh /path/to/FR-001-some-title.md "In Progress"
```

### Refresh project overviews

```bash
./virric/domains/feature-management/scripts/update_backlog_tree.sh
./virric/domains/feature-management/scripts/feature_request_dependency_tracker.sh
```

## Automation (GitHub Actions)

Routing and validation are intended to be implemented as GitHub Actions that:

- infer domain scope from changed paths under `virric/domains/**`
- consume explicit signals under `virric/domains/<domain>/signals/**`
- gate “official” doc changes on PR events (merge to the default branch)


