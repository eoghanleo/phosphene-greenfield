# VIRRIC

Virric is a lightweight agentic harness framework built on a brutally simple premise:

- **GitHub Actions is the scheduler.**
- **Codex is the worker.**
- **The repo is shared memory.**

Virric is a **convention, not a platform**. It achieves determinism and auditability by making the repo itself the state machine.

## Core idea (repo as signal bus)

Agents do not message each other. They write artifacts.

GitHub Actions observes repo changes, runs validation/routing logic, and invokes the next agent.

In one line:

**Signals broadcast through the repo to Actions, which (via deterministic routing + a central planner) calls the next agent, and PR merge is the officialization point.**

## Non-negotiable workflow rule: PR-gated officialization

Artifacts effectively have three states:

- **Open** (work in progress)
- **In PR** (candidate changes under review/automation)
- **Closed** (merged to the default branch)

Any change only becomes “official” when it merges via a PR event.

## Repo layout (drop-in harness)

Hard requirement:

- `virric/` must exist at the **repo root**

Canonical scaffold:

- `virric/domains/<domain>/{docs,templates,scripts,signals}/`

Domain reference convention:

- Refer to domains using angle brackets: `<ideation>`, `<research>`, `<product-marketing>`, etc.
- Avoid “go to this directory” pointers inside handoff/spec docs; use the domain tag.

Script naming convention:

- Scripts should use **fully spelled-out, self-describing names** (avoid abbreviations in filenames).
  - Example: `add_reference_solution.sh` (not `add_refsol.sh`).

## The contract lives in `AGENTS.md`

Virric expects a single source of truth for agent behavior:

- Root shim: `AGENTS.md`
- Canonical handoff: `virric/AGENTS.md`
- Design note: `VIRRIC_STATE_MACHINE_WORKING.md`
- Skills (mandatory): `.codex/skills/virric/**`

To browse skills, open the relevant `SKILL.md` under `.codex/skills/virric/**`.

Codex skill reference: [Codex skills standard](https://developers.openai.com/codex/skills/).

## Completion receipts: `DONE.json` (recommended, not a signal)

`DONE.json` is a **completion receipt** written by the assigned agent at the end of work as:

- a final checklist (hallucination check)
- a machine-checkable “I believe I’m done” handshake
- a compact audit manifest (inputs/outputs/checks)

Important:

- `DONE.json` is **not** part of the signals system.
- Signals are **additional** to the core PR-gated flow: get work → do work → finish work → PR work.

### Where to put it

Put the receipt next to the artifact it’s attesting to:

- For bundles (e.g. `<research>` RAs): in the bundle root (same folder as `00-coversheet.md`)
- For single-doc artifacts: adjacent to the doc

### Minimal shape (baseline)

```json
{
  "receipt_version": 1,
  "work_id": "RA-001",
  "domain": "research",
  "artifact_type": "research-assessment",
  "ok": true,
  "inputs": ["..."],
  "outputs": ["..."],
  "checks": ["..."],
  "inputs_hash": "sha256:...",
  "timestamp_utc": "2026-01-09T00:00:00Z",
  "commit_sha": "..."
}
```

### Domain payload expectations (recommended)

These are conventions intended to make receipts predictable for automation and review.

#### `<research>` — `research-assessment` (RA bundle)

- **work_id**: `RA-###`
- **outputs** (typical):
  - `00-coversheet.md`, `10-reference-solutions.md`, `20-competitive-landscape.md`
  - `30-pitches/PITCH-*.md`, `40-hypotheses.md`, `50-evidence-bank.md`, `90-methods.md`
  - `RA-###.md` (assembled view; generated)
- **checks** (typical):
  - `./virric/domains/research/scripts/validate_research_assessment_bundle.sh <bundle_dir>`
  - `./virric/domains/research/scripts/assemble_research_assessment_bundle.sh <bundle_dir>`
  - `./virric/domains/research/scripts/research_id_registry.sh validate`

#### `<feature-management>` — `feature-request` (FR dossier)

- **work_id**: `FR-###`
- **outputs** (typical):
  - `virric/domains/feature-management/docs/frs/FR-###-*.md`
  - `virric/domains/feature-management/docs/backlog_tree.md` (generated)
  - `virric/domains/feature-management/docs/fr_dependencies.md` (generated)
- **checks** (typical):
  - `./virric/domains/feature-management/scripts/validate_feature_request.sh`
  - `./virric/domains/feature-management/scripts/update_backlog_tree.sh`
  - `./virric/domains/feature-management/scripts/feature_request_dependency_tracker.sh`

#### Other domains (templates-first)

For domains that are currently templates-first (no validators yet), `DONE.json` still helps:

- keep outputs scoped and enumerated
- record what was and wasn’t verified
- make follow-on automation easier when validators are added later

## Signals (optional add-ons to the core flow)

Signals are **explicit, small files** placed under:

- `virric/domains/<domain>/signals/`

They exist to support automation and routing, not to define canonical completion state.

Good properties of a signal:

- **intent-bearing**: says what someone wants to happen
- **scoped**: references a `work_id` and `<domain>`
- **ephemeral**: can be consumed and then removed/archived
- **machine-checkable**: JSON/YAML with stable fields, not prose

Example signal payload (shape is a convention, not enforced yet):

```json
{
  "signal_version": 1,
  "work_id": "RA-001",
  "domain": "research",
  "intent": "request-next-agent",
  "notes": "Please generate propositions from the pitch set.",
  "pointers": [
    "virric/domains/research/docs/research-assessments/RA-001-.../00-coversheet.md"
  ],
  "timestamp_utc": "2026-01-09T00:00:00Z"
}
```

## Quick start (run from repo root)

```bash
./virric/bin/virric banner
```

Create an FR:

```bash
./virric/domains/feature-management/scripts/create_feature_request.sh --title "..." --description "..." --priority "High"
```

Validate FRs:

```bash
./virric/domains/feature-management/scripts/validate_feature_request.sh
```

Create and validate an RA bundle:

```bash
./virric/domains/research/scripts/create_research_assessment_bundle.sh --title "..." --priority Medium
./virric/domains/research/scripts/validate_research_assessment_bundle.sh virric/domains/research/docs/research-assessments/RA-001-...
```

## Notes

- This build assumes **bash-only** + baseline Unix tools (`awk`, `sed`, `grep`, `find`, `date`).


