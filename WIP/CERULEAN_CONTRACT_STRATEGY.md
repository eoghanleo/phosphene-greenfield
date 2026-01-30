ID: CERULEAN-CONTRACT-STRATEGY
Title: Cerulean Contract Strategy
DocType: Strategy (Cerulean lane compilation contract)
Version: v0.1
Status: Draft
Updated: 2026-01-29
Owner:
EditPolicy: HUMAN_EDIT_OK (not script-managed)

## Purpose

This document defines the **Cerulean lane contract** required to reliably compile from “product intent” into **ticketable work** (FR dossiers → issue inventories → sprint scope) without forcing downstream agents to **invent**:

- architecture
- data models and state transitions
- interface schemas
- security posture
- observability semantics
- test/eval harnesses
- delivery/rollout scaffolding

The aim is to make “atomiser → Jira tickets → sprints” a **mostly mechanical compilation step**, not a creative leap.

## The core diagnosis (why PRDs still don’t compile cleanly)

PHOSPHENE already has the right pipeline instinct:

- `<research>` (RA bundles) can produce evidence + unknowns
- `<product-marketing>` (VPD bundles) can produce persona/value framing
- `<product-management>` (PRD bundles) can produce traceable requirements and acceptance-criteria-shaped statements

But the current PRD (even when strong) still leaves gaps that are fatal for mechanical ticket generation:

- **Undefined nouns** (“trust vault”, “return recap”, “snapshot”) force invention.
- **Missing state models** force invention (entities, transitions, versioning, invariants).
- **Missing interface contracts** force invention (payloads, errors, auth, guarantees).
- **Missing telemetry contracts** force invention (event names, required properties, privacy).
- **Missing security controls** force invention (threats → mitigations → controls).
- **Missing eval harness** force invention (what proves AC? what fails a build?).

PHOSPHENE’s detector/trap loop already supports “bounce back until ready”; the missing piece is **what the detector should verify** beyond “bundle exists and has lots of text”.

## Cerulean contract principle: intermediate representations (IRs), not a single mega-document

Cerulean needs a small set of **intermediate representations** that bridge PRD intent to implementation determinism.

Each IR (“pane”) MUST have:

1) **Human-readable** form (bash-parseable Markdown; stable headings/IDs)
2) **Machine-checkable** form when feasible (schemas/contracts/manifests)

When a pane is missing, the correct behavior is **not guessing**; it is compiling the *missing pane itself* into first-class work (FRs/tickets) and blocking downstream feature tickets until the pane exists.

## How this fits PHOSPHENE today (existing Cerulean gates)

Cerulean already has a working “bounce until verified” mechanism:

- `<product-management>` is **active** and emits DONE receipts; detectors gate it.
- `<feature-management>` and `<scrum-management>` are **TODO** (not in live flows until they have DONE receipts + detectors).

Today’s Cerulean verification surface for PRDs:

- PRD structural + reference validation: `./.github/scripts/validate_prd_bundle.sh`
- PRD done score gate (anti-token-dump hardened): `./.github/scripts/product-management-domain-done-score.sh`
- Domain threshold: `phosphene/config/cerulean.yml` (`product-management.done_score_min`)

This strategy extends *what counts as “done enough to compile”* by making pane readiness a first-class verification target (implemented as future validator checks and/or detector scoring extensions).

## The Cerulean Contract Stack (panes to add / harden)

The panes below are ordered to maximize determinism early and prevent “vibes-to-implementation”.

### Pane 1 — Definitions and Invariants (spec language)

- **Purpose**: remove ambiguity; make acceptance criteria executable.
- **Human output**: glossary upgraded into *normative* definitions + invariants.
- **Machine output (later)**: a small, validated “terms + invariants” manifest (format TBD).
- **Readiness gates**
  - Any P0/P1 requirement MUST NOT introduce an undefined term.
  - Each invariant MUST map to at least one enforcement point (validation rule, test, telemetry, or UI evidence).
  - Use RFC-2119 style requirement keywords (**MUST/SHOULD/MAY**) consistently.

### Pane 2 — Domain Model and State (entities, transitions, events)

- **Purpose**: define the “things” and the allowed state transitions.
- **Human output**: entity list + state machines + versioning/migration rules + invariants mapped here.
- **Machine output (later)**: JSON Schema for core entities; optional state-machine export.
- **Readiness gates**
  - Every requirement touching persistence/sync/identity MUST reference an entity + state transition.
  - Every state transition MUST declare triggering conditions + emitted domain events (names only at minimum).

### Pane 3 — Architecture Options and Decisions (options matrix + ADRs)

- **Purpose**: convert “we should use X” into explicit decisions with constraints and reversibility.
- **Human output**: options matrix + decision log (ADRs or ADR-like entries).
- **Machine output (later)**: lightweight ADR index manifest (format TBD).
- **Readiness gates**
  - Every “key boundary” claim MUST be backed by a decision entry or explicitly marked “un-decided”.
  - Decisions MUST include constraints, trade-offs, and re-evaluation triggers.

### Pane 4 — Interface Contracts (system boundaries as contracts)

- **Purpose**: make boundaries machine-readable.
- **Human output**: boundary descriptions (what/why), plus links to contract artifacts.
- **Machine output (later)**:
  - OpenAPI (HTTP APIs)
  - AsyncAPI (event APIs)
  - JSON Schema (payloads reused across both)
- **Readiness gates**
  - Every integration requirement MUST reference a contract artifact (or generate a “missing contract” task first).
  - Every contract MUST declare auth/error semantics and idempotency expectations.

### Pane 5 — Telemetry and Observability (measurement is a contract)

- **Purpose**: make measurement enforceable and privacy-aware.
- **Human output**: canonical event dictionary + correlation rules + dashboards/alerts list.
- **Machine output (later)**: telemetry manifest with required fields + privacy classification.
- **Readiness gates**
  - Every success metric MUST map to concrete event(s) with required fields.
  - Every event MUST have a privacy classification for its properties and a retention intent.

### Pane 6 — Security, Privacy, and Compliance (threats → controls)

- **Purpose**: produce implementable security tickets, not “be secure”.
- **Human output**: threat model summary + mitigations + control requirements.
- **Machine output (later)**: control checklist manifest (format TBD).
- **Readiness gates**
  - Any requirement involving identity/payment/PII MUST link to explicit control requirements.
  - Threats and mitigations MUST be traceable (STRIDE-style is acceptable as a minimum).

### Pane 7 — Test and Eval (eval-driven development)

- **Purpose**: turn acceptance criteria into executable checks.
- **Human output**: scenario set (Given/When/Then), plus non-functional harness plans.
- **Machine output (later)**: test-plan manifest (what exists, what is required, what blocks release).
- **Readiness gates**
  - Every P0 requirement MUST have at least one executable acceptance scenario defined.
  - Non-functional requirements MUST have a measurement method + environment.

### Pane 8 — Delivery, Rollout, and Operability (ship safely)

- **Purpose**: prevent “built but unshippable”.
- **Human output**: rollout strategy, flags, migrations, reversibility, SLOs, runbooks.
- **Machine output (later)**: release checklist manifest (format TBD).
- **Readiness gates**
  - Any migration MUST specify forward + rollback strategy.
  - Any feature with blast radius MUST specify degradation mode + kill switch.

### Pane 9 — System Catalog and Repo Reality (stay grounded)

- **Purpose**: stop planning artifacts from ignoring the real codebase.
- **Human output**: component inventory + ownership + constraints summary + dependency surface.
- **Machine output (later)**: catalog metadata harvested from repo (format TBD).
- **Readiness gates**
  - PRD/FRs MUST reference existing components when they exist; otherwise explicitly declare “new component”.
  - Build/test constraints MUST be visible to the atomiser before it emits tickets.

## Mapping to current PRD bundle (what already exists vs what must be hardened)

Current PRD bundles already contain many “pane-shaped” sections (architecture, security, testing, ops, release readiness), but they are primarily **prose**.

Cerulean’s strategy is to:

- **Harden** existing sections into pane outputs (add IDs, invariants, structured tables).
- **Add** missing panes explicitly (domain model/state, interface contracts, telemetry dictionary, system catalog).
- **Introduce** machine-checkable companions for the most “ticket-compiler-critical” panes (contracts, schemas, telemetry, tests) when the validator surface is ready.

### Pane → current PRD file mapping (baseline)

This is the minimal “where it lives now” map for PRD bundles (example structure: `phosphene/domains/product-management/output/prds/PRD-###-*/`):

| Pane | Current PRD surface(s) | Status |
|---|---|---|
| 1) Definitions/Invariants | `180-appendix/glossary.md` (needs normative upgrade) | Partially present |
| 2) Domain Model/State | *(no dedicated file; sometimes implied in `80-architecture.md`)* | Missing / implicit |
| 3) Architecture Decisions | `80-architecture.md`, `180-appendix/decision-log.md` | Present (needs ADR rigor) |
| 4) Interface Contracts | `100-data-integrations.md` (links/contracts typically missing) | Partially present |
| 5) Telemetry/Observability | `50-success-metrics.md`, telemetry columns in `60-requirements/*` | Partially present |
| 6) Security/Privacy | `110-security-compliance.md` | Present (needs control traceability) |
| 7) Test/Eval | `140-testing-quality.md` | Present (needs executable scenario set) |
| 8) Delivery/Operability | `130-delivery-roadmap.md`, `150-operations-support.md`, `170-release-readiness.md` | Present (needs rollback/flags rigor) |
| 9) System Catalog/Repo Reality | *(no dedicated file; implicit via links/knowledge)* | Missing / implicit |

## Readiness evaluation: how Cerulean “bounces” until deterministic

PHOSPHENE already provides the apparatus to bounce work until it meets a rubric:

- **Modulator** produces artifacts and emits a DONE receipt.
- **Detector** verifies the receipt via validators + done-score thresholds.
- **Trap** posts remediation instructions and requires a fresh DONE receipt after fixes.

Cerulean’s missing piece is a **readiness rubric** aligned to the panes above.

### Macro rule: “missing pane → missing-artifact work first”

Detectors MUST treat missing panes as **hard verification failures** when they block deterministic compilation.

That produces a clean loop:

- If “Interface contracts” are missing: emit trap and compile “produce OpenAPI/AsyncAPI + schemas” as first work.
- If “Domain model” is missing: compile “produce entity/state pane” as first work.
- If “Telemetry dictionary” is missing: compile “produce telemetry pane” as first work.

This is how Cerulean avoids a chaos engine: **never guess when the missing thing is itself definable work.**

### Routing rule: missing input → route to the owning domain (no invention)

When a pane fails because an upstream constraint is missing, the remediation MUST route to the correct owner domain:

- Missing/weak evidence → `<research>` (viridian)
- Missing persona/proposition constraint → `<product-marketing>` (beryl)
- Missing bet/sequencing constraints → `<product-vision>` / `<product-strategy>` (beryl; TODO)
- Missing contract/model/telemetry/eval scaffolding → Cerulean panes (inside `<product-management>` until split)

This preserves the `<product-management>` hard rule: do not invent personas/propositions/evidence; treat upstream artifacts as constraints.

## Domain restructuring proposal (minimal-first, domains-later)

This section translates the “add panes / add domains” debate into a PHOSPHENE-native plan.

### Minimal-first (recommended): keep domains, add Cerulean panes as first-class outputs

- Keep `<product-management>` as the primary “contract bundle” domain.
- Treat the panes above as required PRD bundle surfaces (human-readable first, then machine-checkable).
- Use the existing detector/trap loop as the readiness evaluator.

This gets you compilation determinism without waiting for new domain scaffolding (DONE receipts, validators, bus subflows).

### Domains-later (optional, when scaling): split “product team” functions into compiler stages

When you need scale and specialization, add explicit domains *after* the pane contracts stabilize:

- **`<product-vision>`** (replace/rename `<product-strategy>`): produces vision/bet constraints and sequencing primitives.
- **`<product-architecture>`** (new, likely Cerulean): produces architecture options/decisions + interface contracts as machine artifacts.
- **`<product-evaluation>`** (new, likely Cadmium-adjacent): produces eval harnesses, readiness gates, and regression requirements.

Key constraint: PHOSPHENE domains are not “real” until they have:

- control scripts
- validators
- DONE receipt emit scripts
- detector gates / done score thresholds

Until then, keep the work inside `<product-management>` as panes.

## Compilation rules: PRD → FR dossiers → ticket inventory

### PRD → FR (Feature Requests) compilation (Cerulean target)

An FR dossier should be compilable from a PRD requirement cluster when:

- the terms used are defined (Pane 1)
- the relevant entities/states exist (Pane 2)
- the boundary contracts are specified (Pane 4)
- telemetry + eval hooks are specified (Panes 5 + 7)

Mapping rules (normative):

- Each FR MUST cite its parent `PRD-###` in a stable place (header or first section).
- Each FR MUST include:
  - **Acceptance Tests**: derived from PRD acceptance criteria (Given/When/Then)
  - **Requirements**: the MUST/SHALL statements relevant to this feature slice
  - **Implementation Plan**: checkable task list (can be generated, but must be deterministic)

### FR → Jira-style tickets (downstream; out of scope for this doc)

Once FRs exist, “atomiser → Jira tickets” becomes a decomposition problem over:

- contracts (endpoints/events)
- schemas (entity payloads)
- controls (security items)
- eval hooks (tests)
- rollout scaffolding (flags/migrations/runbooks)

Cerulean’s job is to ensure these inputs exist so the atomiser doesn’t guess.

## Implementation note (non-code): schematics-first remains mandatory

This document is a strategy contract. When you convert it into new workflows, validators, or output structures, PHOSPHENE’s rule still applies:

- write/update schematics under `WIP/schematics/` first (Markdown + Mermaid),
- then implement scripts/validators/instruments.

## Structural deltas (vs the colleague critique)

- This strategy binds the “panes/IRs” idea to **PHOSPHENE instruments** (modulator/detector/trap) so bounce/refinement is already mechanized.
- It specifies a **macro gate** (“missing pane → missing-artifact work first”) to prevent guessed tickets.
- It proposes a **minimal-first** path: harden panes inside PRDs before creating new domains (so we don’t create empty domain shells).

## Selection rationale (why this structure)

- It aligns to existing PRD bundle topology and validators, avoiding a wholesale rewrite.
- It uses the detector/trap loop as the “readiness evaluator” rather than inventing a new orchestration mechanism.
- It makes compilation failure modes explicit and productive (missing panes become first work).

## Open questions (what would most change this)

- Which panes should become **machine-checkable first** (OpenAPI/JSON Schema vs telemetry manifest vs test manifest)?
- Do we want global IDs for new constructs (TERM/INV/ENTITY/EVENT/ADR), or keep them PRD-local until stable?
- Should “system catalog/repo reality” live as a cross-domain artifact under `phosphene/`, or inside each PRD bundle?
- Where does “product evaluation” end and `<test-management>` begin once Cadmium is active?

