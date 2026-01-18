---
name: phosphene-core
description: PHOSPHENE core harness: PR-gated officialization, repo-as-shared-memory, domains (<domain>), DONE signals (<WORK_ID>-DONE.json), and signals conventions.
metadata:
  short-description: PHOSPHENE core harness conventions
---

## Goal

Operate inside the PHOSPHENE harness using repo-native artifacts as the system’s shared memory.

## Core invariants

- **GitHub Actions is the scheduler.**
- **Agents are workers.**
- **The repo is shared memory.**
- **PR merge is the officialization point** (changes are only canonical when merged).

## Repo structure (canonical)

- `phosphene/` is a required drop-in folder at repo root.
- Domains live under: `phosphene/domains/<domain>/{docs,scripts,signals}/`
- Some domains may still include `templates/` as transitional scaffolding.
- Refer to domains using angle brackets: `<research>`, `<feature-management>`, etc.

## Scripts convention

- Scripts live under: `phosphene/domains/<domain>/scripts/`
- Scripts should have **fully spelled-out, self-describing names** (avoid abbreviations).

## In-doc script hints (`[V-SCRIPT]`)

Some artifacts include fenced code blocks that begin with:

```text
[V-SCRIPT]:
<script_name.sh>
```

Search for `[V-SCRIPT]` when scanning an artifact to discover the relevant control scripts for that section.

## Scripts (entrypoints and purpose)

This core skill does not define a large control-script surface itself; it defines **conventions** and points you to domain skills.

Useful core entrypoint:
- `phosphene/phosphene-core/bin/phosphene`: small CLI helper (banner/help) for orientation in the harness.

## Skills are mandatory in this repo

This repo treats skills as a **required execution contract**, not optional context.

- Skills are stored under: `.codex/skills/**`
- Each skill is a folder containing a required `SKILL.md` (this file format), plus optional `scripts/`, `references/`, and `assets/`.

Reference: [Codex skills standard](https://developers.openai.com/codex/skills/).

## DONE signals (completion + registration) — `<WORK_ID>-DONE.json` (required)

`<WORK_ID>-DONE.json` is a completion signal written by the assigned agent at the end of work as:

- a final checklist / hallucination check
- a machine-checkable “I believe I’m done” handshake
- a compact audit manifest (inputs, outputs, checks run)
- the **registration event** for automation (signal bus)

Required:

- Location: `phosphene/domains/<domain>/signals/<WORK_ID>-DONE.json`
- Naming: `<WORK_ID>` is the parent/top-level artifact ID (e.g. `RA-001`, `VPD-001`, `SPEC-012`).

## Signals (optional add-ons)

Signals are explicit, parseable events used to route automation; they are **additional** to the PR-gated core flow.

- Location: `phosphene/domains/<domain>/signals/**`
- Use for explicit intent that cannot be reliably inferred from diffs alone.

## What to read first

- Canonical handoff: `phosphene/AGENTS.md`
- Root overview: `README.md`
