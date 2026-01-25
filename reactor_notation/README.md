## PHOSPHENE reactor section notation (draft proposals)

Goal: define a **human-friendly, machine-parseable** notation for “reactor sections”:

- **Components** (gantries / apparatus / externals)
- **Signals** (directed edges; *a signal implies bus append + downstream trigger*)
- **Annotations** (constraints, idempotency, gates, error modes) kept **out of the flow**

Non-goals:

- Not a diagram language (no Mermaid). This is **markup** that a future visualizer can render.
- Not a full schema for every PHOSPHENE concern; only what’s needed to make orchestration legible and parseable.

Core design rules:

- **Signal is wireless**: we do not require explicit “commit bus” / “detect bus” steps. Writing `A -[signal]-> B` implies “A emitted a bus record that causes B to react”.
- **Flow stays clean**: the main flow is just components + signals. All gates/constraints live in an annotations section.
- **Stable IDs**: every component and every signal edge gets an ID so annotations can reference them.

### Gantry types (reactor roles)

We treat these as **types** for routing + visualization (not necessarily directory structure):

- `autoscribe` — creates/normalizes issues, emits bus signals
- `hopper` — interprets issues and emits start signals
- `prism` — issues `phos_id`, creates branch beam, summons Codex
- `prop` — propagation/relay gantry (optional; explicit “signal forwarder” role)
- `detector` — verification/validation; emits `approve`/`trap`
- `condenser` — opens PR, waits for checks, approves + merges if green
- `trap` — error switchboard; listens for trap signals and `@codex` remediation loops

### Options

- **Option A — PHOSFLOW DSL** (`option_a_phosflow.md`)
  - Most compact and expressive; moderate parsing complexity.
- **Option B — Markdown tables + flow lines** (`option_b_tables.md`)
  - Most accessible; easiest to read/review in PRs; easiest to adopt.
- **Option C — YAML schema** (`option_c_yaml.md`)
  - Most machine-friendly; easiest for tooling; more verbose for humans.
- **Option D — Mermaid loop diagram (system view)** (`option_d_mermaid_loop.md`)
  - A “humour me” looping diagram view: gantries as circles, apparatus as squares, detector decisions as diamonds.

Each option includes a worked example for the `<product-marketing>` bus subflow.

