
![FLORA-Text Modification Request-52d07bab](https://github.com/user-attachments/assets/be6dbfd9-bd1c-4f10-ae55-b30029da9349)





PHOSPHENE is a **git-native harness for continuous product development**: a way to keep ideas, decisions, artifacts, and handoffs legible over time—without needing a heavyweight platform.

At its core:
- **GitHub (PRs + Actions) is the scheduler**
- **Codex is the worker** (often via `@codex` mentions)
- **The repo is shared memory**
- **PR merge is the officialization point**

## The six colours (modular lifecycle + memory system)

Phosphene is modular: you can run one colour in isolation, or combine them into whatever lifecycle fits your team.

![FLORA-VIRIDIAN Design-340e14c5](https://github.com/user-attachments/assets/1b281dde-45b6-4022-ac52-4439878c46c0)

Viridian:

- **the colour of new ideas and fertile beginnings**
- **Ideation domain**
- **Moonshot domain (to be developed)**

![FLORA-Background Modification-75c6589b](https://github.com/user-attachments/assets/50ebc45c-1e3f-425a-a87a-83ad67013135)

Beryl:

- **creative clarity, the emergence of structure**
- **Product-marketing domain**
- **Product-strategy domain**

![FLORA-Text Background Change-55feb0cc](https://github.com/user-attachments/assets/bc0f025c-59ee-4364-9c9a-fb544b94857d)

Cerulean:

- **going deep, diving into detail**
- **Product-management domain**
- **Feature-management domain**

![FLORA-Image 2-bf32b532](https://github.com/user-attachments/assets/462451e1-e33b-48b3-b4cd-14065b541e34)

Amaranth:

- **new stars formed, new elements made manifest**
- **scrum-management domain**

![FLORA-Cadmium Background Design-8c09b9b1](https://github.com/user-attachments/assets/a9d82395-df8b-46d8-bdbc-a9f0cad11cae)

Cadmium:

- **reactions and fiery testing, tempering to strength**
- **test-management domain**

![FLORA-Image Editing Request-dc7cd840](https://github.com/user-attachments/assets/05c385a1-cd7d-4d66-8580-0014c2f6b16a)

Chartreuse:

- **continuous ingenuity, surprising distillations**
- **retrospective domain**
- **ontology domain (to be developed)**

> Note: the repo may include additional domains as the framework evolves; the colour system is intended to be **composable**, not restrictive.

## Core idea (repo as a signal bus)

Agents don’t message each other. They **write artifacts**.

GitHub Actions observes repo changes (especially **signals**), runs validation/routing logic, and invokes the next step. In one line:

**Signals broadcast through the repo to Actions, which routes work, and PR merge is the officialization point.**

## Non‑negotiable rule: PR‑gated officialization

Artifacts effectively have three states:
- **Open** (work in progress)
- **In PR** (candidate changes under review/automation)
- **Closed** (merged to the default branch)

If it’s not merged, it’s not canonical.

## Repo layout (drop‑in harness)

Hard requirement:
- `phosphene/` must exist at the **repo root**

Canonical scaffold:
- `phosphene/domains/<domain>/{docs,templates,scripts,signals}/`

Domain reference convention:
- Refer to domains using angle brackets: `<ideation>`, `<product-marketing>`, `<feature-management>`, etc.

## Contracts and “how to work”

The contract lives in:
- Root shim: `AGENTS.md`
- Canonical agent entrypoint: `phosphene/AGENTS.md`

Common expectations:
- Prefer **control scripts** (don’t hand-edit script-managed artifacts)
- Run validators when available
- Keep IDs stable and consistent

## Completion receipts: `DONE.json` (recommended, not a signal)

`DONE.json` is a completion receipt: a compact “I believe I’m done” handshake + audit manifest.

Put the receipt at the **domain root**:
- `phosphene/domains/<domain>/DONE.json`

Do **not** put receipts inside `docs/**` or deeper subdirectories.

Minimal baseline shape:

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
  "timestamp_utc": "2026-01-09T00:00:00Z"
}
```

## Signals (optional add-ons to the core flow)

Signals are **explicit, small files** placed under:
- `phosphene/domains/<domain>/signals/`

Good signals are:
- **intent-bearing**
- **scoped** (references a `work_id` and `<domain>`)
- **ephemeral** (can be consumed, then removed/archived)
- **machine-checkable** (JSON/YAML with stable fields)

## Identity and uniqueness (central tenet)

Phosphene prefers **long, stable, human-readable natural keys** for identifiers (e.g. `PER-0003`, `FR-012`).

## Quick start (run from repo root)

```bash
./phosphene/phosphene-core/bin/phosphene banner
./phosphene/phosphene-core/bin/phosphene id validate
```

