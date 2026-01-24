
![FLORA-Text Modification Request-52d07bab](https://github.com/user-attachments/assets/be6dbfd9-bd1c-4f10-ae55-b30029da9349)



## PHOSPHENE

PHOSPHENE is a **git-native harness for continuous product development**: a way to keep ideas, decisions, artifacts, and handoffs legible over time—without needing a heavyweight platform.

At its core:
- **GitHub (PRs + Actions) is the scheduler**
- **Codex is the worker** (often via `@codex` mentions)
- **The repo is shared memory**
- **PR merge is the officialization point**

## What Phosphene nails (and most “vibe context management” repos don’t)

- **Total autonomous operations**: Humans don’t have to be in the loop unless they *want* to be. You can run end-to-end cycles that create artifacts, validate them, open PRs, and route the next step automatically. The system is cylical and non-linear by design. Ralph-Wiggum to your hearts content, or speed run the whole cycle. Or both.

- **Fully cloud powered operations**: The harness is designed so the *work* can run in the cloud. You can steer it from anywhere—yes, including from your phone.

- **Consumer license friendly**: If you’ve got a paid ChatGPT subscription, you’re good. No API keys required for the core `@codex`-driven workflow.

- **Repo-first architecture**: If it lands in GitHub, it’s immediately schedulable and testable. This fits modern repo-first stacks (e.g. Vercel Next.js, database-as-a-service like PlanetScale): push → build → test → play in a little over a minute.

- **More than just vibe coding**: The “coding” modules are optional. Compose what you need: build a deep research farm, clip an ontology-mining memory module onto your existing vibe rig, or scale serious testing management without changing your whole workflow.


## The six colours (modular lifecycle + memory system)

Phosphene is modular: you can run one colour in isolation, or combine them into whatever lifecycle fits your team.

In practice, each colour is a **lens** with a simple contract:
- **Inputs**: artifacts and signals produced by whichever colours came before (or by humans).
- **Outputs**: new artifacts (and sometimes new signals) that make the *next* colour easier, faster, and more deterministic.

---

![FLORA-VIRIDIAN Design-340e14c5](https://github.com/user-attachments/assets/1b281dde-45b6-4022-ac52-4439878c46c0)

## **Viridian** — the colour of new ideas and fertile beginnings

- **Domains**: Ideation; Moonshot (to be developed)
- **Takes as inputs**:
  - Raw sparks (notes, user pain, customer quotes, founder intuition)
  - Constraints (time, budget, technical realities, market context)
  - Continuous improvement, refinement and opportunity expansion from lifecycle memory (Chartreuse)
- **Produces outputs**:
  - Clear idea artifacts with names and intent (enough to hand off)
  - Signals that invite structure: “turn this into positioning”, “test this claim”, “spec this idea”

---

![FLORA-Background Modification-75c6589b](https://github.com/user-attachments/assets/50ebc45c-1e3f-425a-a87a-83ad67013135)

## **Beryl** — creative clarity, the emergence of structure

- **Domains**: Product-marketing; Product-strategy
- **Takes as inputs**:
  - A Viridian idea that’s “real enough” to shape
  - Early research (optional but powerful) and any known competitors/alternatives
- **Produces outputs**:
  - Who it’s for + why it matters (personas, propositions, positioning)
  - Strategic shape (narrative, roadmap intent, tradeoffs)
  - Signals that invite detail: “spec this”, “turn into features”, “make acceptance criteria”


---

![FLORA-Text Background Change-55feb0cc](https://github.com/user-attachments/assets/bc0f025c-59ee-4364-9c9a-fb544b94857d)

## **Cerulean** — going deep, diving into detail

- **Domains**: Product-management; Feature-management
- **Takes as inputs**:
  - Beryl outputs (positioning, roadmap intent, proposition constraints)
  - Operational constraints (scope, sequencing, dependencies)
- **Produces outputs**:
  - Specs and feature requests that engineers can execute
  - Backlog structure and dependency clarity
  - Signals that invite execution: “plan sprint”, “break into issues”, “write tests”


---

![FLORA-Image 2-bf32b532](https://github.com/user-attachments/assets/462451e1-e33b-48b3-b4cd-14065b541e34)

## **Amaranth** — new stars formed, new elements made manifest

- **Domains**: Scrum-management
- **Takes as inputs**:
  - Cerulean features/specs + priority decisions
  - Team reality (capacity, risks, sequencing)
- **Produces outputs**:
  - Work breakdown, issue mirrors, and execution rhythm
  - Signals that invite validation: “prove it works”, “verify edge cases”, “ship-ready?”


---

![FLORA-Cadmium Background Design-8c09b9b1](https://github.com/user-attachments/assets/a9d82395-df8b-46d8-bdbc-a9f0cad11cae)

## **Cadmium** — reactions and fiery testing, tempering to strength

- **Domains**: Test-management
- **Takes as inputs**:
  - Amaranth execution artifacts (issues, acceptance criteria) and the current build state
  - Risk areas and “what must not break”
- **Produces outputs**:
  - Test plans and verification evidence
  - Signals that invite learning: “what surprised us?”, “what should we change next time?”


---

![FLORA-Image Editing Request-dc7cd840](https://github.com/user-attachments/assets/05c385a1-cd7d-4d66-8580-0014c2f6b16a)

## **Chartreuse** — continuous ingenuity, surprising distillations

- **Domains**: Retrospective; Ontology (to be developed)
- **Takes as inputs**:
  - Outcomes (what shipped), evidence (what happened), and friction (what hurt)
  - Cadmium findings and constraints discovered under real pressure
- **Produces outputs**:
  - Retrospectives and playbooks that prevent repeat mistakes
  - Evolving shared language (ontology) that makes the next cycle cleaner
  - Can close the loop back to Viridian to continuously generate new ideas, new value and entire new products autonomously.


---

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
- `phosphene/domains/<domain>/{docs,templates,scripts}/`
- Central signal bus: `phosphene/signals/`

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

## Completion signals: JSONL bus record (required)

A DONE signal is a **completion record**: a compact “I believe I’m done” handshake + audit manifest **and** the registration event for automation.

Put the DONE record in the **central signal bus**:
- `phosphene/signals/bus.jsonl` (append-only; one JSON object per line)

`work_id` must be the **parent/top-level artifact ID** (e.g. `RA-001`, `VPD-001`, `SPEC-012`).

Minimal baseline shape (suggested):

```json
{
  "signal_version": 1,
  "signal_type": "DONE",
  "work_id": "RA-001",
  "domain": "research",
  "artifact_type": "research-assessment",
  "ok": true,
  "inputs": ["..."],
  "outputs": ["..."],
  "checks": ["..."],
  "inputs_hash": "sha256:...",
  "timestamp_utc": "2026-01-09T00:00:00Z",
  "tamper_hash": "sha256:..."
}
```

## Signals (optional add-ons to the core flow)

Signals are **explicit JSONL records** placed into:
- `phosphene/signals/bus.jsonl`

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

## Setup & Configuration

This repo is designed to work **without OpenAI API keys**, by using the **consumer Codex GitHub integration** via `@codex` mentions.

### Prerequisites

- **GitHub Actions enabled** for your repo
- **Codex GitHub integration installed** and authorized for the repo/org

### GitHub Actions permissions

Phosphene workflows create Issues and apply Labels, so set:
- Repo → **Settings** → **Actions** → **General** → **Workflow permissions**
  - **Read and write permissions** for `GITHUB_TOKEN`

### Optional: PAT fallback if Codex ignores bot comments

Some Codex configurations may ignore `github-actions[bot]` comments. If you see that behavior, set a repo secret so Phosphene can post the `@codex` summon comment **as a human identity**.

#### 1) Create a Personal Access Token (PAT)

- **Fine-grained PAT** (recommended):
  - Repository access: **only** this repo
  - Permissions: **Issues: Read and write** (minimum)

#### 2) Add the PAT to repo secrets

- Repo → **Settings** → **Secrets and variables** → **Actions** → **New repository secret**
  - **Name**: `PHOSPHENE_HUMAN_TOKEN`
  - **Value**: the PAT you generated

### How to test the first handoff

1. Create a PR that adds a v1 handoff signal under:
   - `phosphene/signals/`
2. Merge the PR into `main`.
3. Confirm the workflow runs and creates a `<product-marketing>` issue:
   - `.github/workflows/phosphene_handoff_research_to_product_marketing.yml`
