## PHOSPHENE Reactor (overview and instrument taxonomy)

**Scope:** This is a human-readable map of the PHOSPHENE Reactor: the in-universe physics (how a git repo behaves inside the reactor), the control surfaces humans see, and the instrument taxonomy that manipulates beams and signals. It does not define new runtime behavior. It exists to make operational truth legible: what each instrument does, what it touches, and what it emits downstream.

---

#### Reactor physics (why a “reactor”, not a “factory”)

A PHOSPHENE Reactor is a weird-science conceit for explaining why git-based operations have different physics to most work systems. Inside the reactor, “phosphene” (or **phos**) is the plasma-like state of an uncompiled repository: information-dense, highly deformable, reversible, and cheap to duplicate.

Phos behaves less like material on a conveyor and more like a confined beam in a collider or a toroid of plasma in a tokamak. You can split it into parallel beams, explore many shapes, and then coherently couple successful changes back into the stable beam. The reactor metaphor is chosen to make a single point feel obvious: when the “substance” is code, duplication is effectively free, branching is natural, and recombination is a controlled act of resonance rather than physical assembly.

**Core properties you should assume inside the reactor:**

* **Near-free duplication:** branch beams can be created in large numbers with minimal cost.
* **Reversible morphing:** phos can be reshaped into almost any configuration and reshaped again; prior shapes remain accessible.
* **Resonant coupling:** validated changes can be reintroduced to the main beam, shifting the reactor’s stable frequency.
* **Stable equilibrium:** a quiet repo is an unperturbed, stable containment state, not “inert”.
* **Perturbations are events:** any commit perturbs a beam (main or branch) and becomes part of the reactor’s observable history.

#### Reactor anatomy (beams, logs, and perturbations)

Inside a phosphene reactor, the **main beam** corresponds to the repository’s `main` branch. **Branch beams** are git branches spun off the main beam for isolated work and experimentation.

The reactor’s historical record is the **reactor log**, which corresponds to git history: commits are the durable trace of perturbations over time. The current state of the reactor is the current state of each beam. From a schematic perspective, you treat equilibrium as “stable containment” and treat commits as perturbations that instruments detect, route, validate, and optionally couple back into the main beam.

---

### Gantries (orchestration instruments)

**Everything in PHOSPHENE is an instrument**, but instruments fall into two operational classes. **Gantries** manipulate beams and signals: they read state, route work, gate coupling, and record footprints. They do not directly change phos. **Apparatus** are the instruments that actually shape phos: they edit the reactor, generate artifacts, and emit receipts that gantries can verify and couple.

Gantries are the traffic controllers. They read signals, interpret state, and move work forward by emitting new signals, but they are not the place where domain work is performed. Operationally, a gantry’s “write” is usually a footprint rather than a payload: it appends a signal line to the bus and leaves a trace in the work’s control surface, rather than directly authoring phos-shaping artifacts. In PHOSFLOW diagrams they are circles (`((...))`), because they are “reactors” rather than “workers”: they listen, decide, and coordinate.

#### DETECTOR

The `DETECTOR` is the ruling corridor: you hand it a ref (a branch beam or the main beam) and it deterministically evaluates predicates against what it finds there. A detector is how PHOSPHENE turns “someone says it’s done” into “the system agrees it’s done,” because it can validate IDs, run domain validators, and compute “done scores” in a consistent way. Detectors treat receipts as invitations to verify, and treat verification as beam physics, not social trust. When it finishes, it emits a ruling signal (approve or trap) that downstream gantries can treat as a reliable gate rather than a conversation.

#### PRISM

The `PRISM` is the dispatcher: it splits and aims branch beams, fanning work out into an execution context without doing the work itself. In practice, that means it issues the minimal execution anchor inside the reactor (for example, a prism-owned branch beam reference and a prism-issued ID), and it issues the summons that starts the apparatus running. If the detector is the judge, the prism is the stage manager: it sets the scene, points the spotlight, and then gets out of the way.

#### CONDENSER

The `CONDENSER` is the coupler: it turns a green ruling into a coupling action, bringing a validated branch beam back into resonance with the main beam. In implementation terms, that typically means “open a PR, wait for checks, merge when clean, and leave a durable footprint that coupling completed.” Condensers exist so the reactor can be strict about verification without being precious about process: if the work is verified, the condenser does the mechanical merge work and records it in the reactor log; if the work isn’t mergeable, it emits a trap reason that routes back into remediation rather than silently failing.

#### AUTOSCRIBE

The `AUTOSCRIBE` is the cleric that creates the public record. It turns explicit triggers into flimsies (GitHub Issues) with a canonical, machine-readable `[PHOSPHENE] ... [/PHOSPHENE]` block that other instruments can safely interpret. Operationally, autoscribe is special because it is the only instrument allowed to create or mutate flimsies (title/body/labels/assignees/state); that strictness keeps the “case file” coherent even when many other instruments are active and beams are splitting and recombining.

#### HOPPER

The `HOPPER` is the gate at the flimsie boundary. It watches flimsie updates, checks whether a flimsie is eligible to start (domain label, lane, ready/not-blocked, and whether it can parse the canonical PHOSPHENE block), and then emits the “start” signal that wakes a prism. The hopper’s personality is intentionally strict and boring: if it can’t parse, it asks autoscribe to fix; if it’s not eligible, it says why; if it is eligible, it starts the machine and gets out of the way.

#### TRAP

The `TRAP` is the error-loop switchboard. It listens for trap signals (for example, “verification failed” or “checks failed”) and converts them into a targeted remediation prompt attached to the work’s public record (typically as a flimsie comment that includes the worker summon). The trap’s value is that it keeps failure handling dynamic without smearing ad-hoc error logic across every other instrument: detectors and condensers simply emit reasons; trap turns those reasons into a next action that routes the loop back toward stable containment, and a clear instruction to re-emit a fresh completion receipt when fixed.

#### TEST.EMITTER / TEST.LISTENER

`TEST.EMITTER` and `TEST.LISTENER` are gantries that exist to make the signal pathways observable and regression-testable. They are not part of the “business loop,” but they behave like real instruments in miniature: one emits a probe signal, the other listens for it and reacts, so you can prove the bus-triggered orchestration is still alive.

---

### Apparatus (work execution instruments)

Apparatus are the workers. Where a gantry manipulates beams and records footprints, an apparatus changes phos: it edits the reactor, generates artifacts, and produces the domain outputs that verification can later judge. In PHOSFLOW diagrams apparatus are squares (`[...]`), because they are “doers” rather than “deciders.”

#### MODULATOR

The `MODULATOR` is the canonical apparatus shape: the work-configured executor that performs domain tasks under the constraints of the lane and the dossier. It is deliberately described as an instrument rather than a brand-name runtime: the runtime supplier is not hard-wired, and PHOSFLOW conventions explicitly avoid baking a specific supplier into diagrams. The expectation you should carry is simple: modulators shape phos from within; collectors import and refine phos from outside. In both cases, the apparatus emits a completion receipt signal; the receipt is the durable perturbation trace detectors use for verification.

#### COLLECTOR

The `COLLECTOR` is an apparatus that acquires raw phos from outside the reactor and refines it into a usable form. Operationally, it is how the reactor gains new information: ingesting external sources (research, docs, datasets, transcripts, reference repos) and transforming them into repo-native artifacts that can be verified, versioned, and coupled back into the main beam. A collector emits the same kind of durable completion receipt as other apparatus, so downstream detectors can treat ingestion as verifiable work rather than a narrative claim.

---

### Flimsies (work orders and human control surface)

Flimsies are the reactor’s work-order system: the public case files that humans can read, steer, and audit while the instruments do the beam work. The name is borrowed from carbon-copy flimsies used in manufacturing and reactor operations: lightweight, duplicable paperwork that still functions as the canonical record.

PHOSPHENE treats flimsies as a controlled interface. Tool permissions are deliberately strict so the case file stays coherent under swarm conditions. As a baseline rule: **AUTOSCRIBE is the only instrument allowed to create or mutate flimsies** (title, body, labels, assignees, state, canonical `[PHOSPHENE] ... [/PHOSPHENE]` blocks). Other instruments may leave footprints (comments or links) only where explicitly permitted by policy. This keeps human observability stable even while beams fork, loop, and recombine at high frequency.

---

### Spooling and safety (auxiliary workflows)

Spooling and safety workflows are not the mainline orchestration loop, but they occupy the same ecosystem: they exist for controlled instantiation, release, deployment, and guardrail actions where you want deterministic, auditable automation.

Spools are how the reactor produces durable products. To “spool phos” is to extract a beam state from the reactor and solidify it into a compiled, packaged release. In-world, that is the phase change from plasma-like phos to a stable artifact that can be shipped, installed, sold, and audited. Economically, spool control is the profit engine: whoever can run reactors safely, verify coupling, and spool reliably can generate many products quickly by exploiting the unique physics of information work. The reactor makes exploration cheap; the spool makes outcomes valuable.

“Safety” is where you’d expect emergency actions like ejecting a branch beam to live. They are part of the taxonomy because they represent distinct operational intent, even when implemented as separate workflow families.

---

### The loop mindset (reactor loops, not process lines)

PHOSPHENE schematics are built around loops because the reactor is a living toroid of phos under containment. The steady state is equilibrium. Signals and commits are perturbations. Instruments form closed loops that converge on stable coupling: summon work, shape a beam, emit a receipt, verify, couple, and record. When verification fails, failure becomes a first-class signal that routes into remediation and re-verification until the beam returns to an acceptable containment state.

---

### Worked example: a real loop, end-to-end, with expectations

The easiest way to “get” PHOSPHENE is to see the loop twice: first as a compact PHOSFLOW sketch that names only the instruments and signals, and then as a concrete bus-only instantiation that shows the real-world externals (flimsie, PR, CI) and the error loop in motion.

#### At-a-glance PHOSFLOW loop

This compact loop is the mental model you should keep even as domains vary: gantries coordinate by emitting signals, the apparatus does the work, detector decides, condenser couples, and trap routes remediation back into the apparatus. In this style of diagram, the apparatus is always `MODULATOR` (the runtime supplier is not the point).

```mermaid
flowchart LR
  %% Reactor anatomy notes (metaphor mode)
  NOTE_MAIN["main beam = `main` branch"]
  NOTE_BRANCH["branch beam = a git branch (often prism-owned)"]
  NOTE_LOOP["containment loop: perturb → verify → couple → record"]

  %% Gantries (circles)
  AS((AUTOSCRIBE))
  H((HOPPER))
  P((PRISM))
  D((DETECTOR))
  K((CONDENSER))
  T((TRAP))

  %% Apparatus (square)
  MOD[MODULATOR]

  %% Decision (diamond)
  DEC{Approve?}

  %% Core loop
  AS -->|issue_created| H
  H -->|start| P
  P -->|branch_beam_invoked| MOD
  MOD -->|receipt| D
  D --> DEC

  %% Detector split
  DEC -->|approve| K
  DEC -->|trap| T

  %% Reactor loops
  K -->|merge_complete| AS
  T -->|remediate| MOD

  %% Notes (dotted anchors)
  NOTE_MAIN -.-> AS
  NOTE_BRANCH -.-> P
  NOTE_LOOP -.-> D
```

#### Concrete bus-only sequence loop

The diagram below is copied from the existing schematic `schematics/product-marketing/product-marketing_bus_subflow.md`. It is intentionally “bus-only”: every stage is triggered by pushes to the signals bus, and every stage leaves a durable footprint by appending a new line and pushing again. This specific instance names the current runtime supplier in its participant label (`Codex (apparatus)`), but functionally you can read that participant as “the modulator” in the abstract model above.

```mermaid
sequenceDiagram
  autonumber
  participant BUS as bus.jsonl (git refs)
  participant AS as gantry.autoscribe.product-marketing
  participant H as gantry.hopper.product-marketing
  participant P as gantry.prism.product-marketing
  participant D as gantry.detector.product-marketing
  participant K as gantry.condenser.product-marketing
  participant T as gantry.trap.product-marketing
  participant I as GitHub Issue
  participant PR as GitHub PR
  participant CI as CI checks
  participant CX as Codex (apparatus)

  Note over BUS: Main beam: main branch. Branch beam: prism-owned branch ref. Reactor log: git history.
  Note over BUS: Each append is commit+push using PAT auth (GITHUB_TOKEN pushes do not trigger downstream workflows)

  rect rgb(245,245,245)
    Note over BUS: Upstream signal arrives
    BUS->>BUS: append phosphene.merge.research.v1 (work_id=RA-001)
  end

  BUS-->>AS: push trigger (new merge.research line)
  AS->>I: create issue (labels + [PHOSPHENE] block)\nlane=beryl
  AS->>BUS: append phosphene.autoscribe.product-marketing.issue_created.v1\nparents=[merge]

  BUS-->>H: push trigger (new issue_created line)
  H->>I: validate eligibility\n(domain label, lane=beryl, ready, not blocked)
  H->>BUS: append phosphene.hopper.product-marketing.start.v1\nparents=[issue_created]

  BUS-->>P: push trigger (new start line)
  P->>BUS: append phosphene.prism.product-marketing.branch_invoked.v1\nphos_id issued, parents=[start]\nbranch_beam_ref issued (prism-owned)
  P->>I: comment @codex summon + instructions\n(includes DONE receipt command)
  I-->>CX: @codex mention, start work

  Note over CX: Work happens on a branch (Codex does not open PRs)
  CX->>BUS: append phosphene.done.product-marketing.receipt.v1\n(on branch, parents=[branch_invoked])

  Note over D,BUS: Detector watches branch pushes for DONE receipts
  D->>D: verify work\nphosphene id validate\nvalidate_persona --all\nvalidate_proposition --all\nproduct-marketing done score

  Note over D,BUS: Detector emits either APPROVE (pass) or TRAP (verification_failed)
  D->>BUS: append phosphene.detector.product-marketing.approve.v1\nparents=[done_receipt]
  D->>BUS: append phosphene.detector.product-marketing.trap.v1\nparents=[done_receipt]\nreason=verification_failed

  Note over K,BUS: Condenser watches branch pushes for APPROVE and opens the PR
  K->>PR: open PR (branch -> main)
  PR-->>CI: run checks

  Note over CI,K: When checks complete, condenser re-evaluates and merges if clean
  K->>PR: merge (only if mergeable_state=clean)
  K->>BUS: append phosphene.merge_complete.product-marketing.v1\nparents=[approve]
  K->>I: comment completion + links (PR, merge)

  Note over K,BUS: If checks fail, condenser emits TRAP (checks_failed)
  K->>BUS: append phosphene.detector.product-marketing.trap.v1\nparents=[approve]\nreason=checks_failed

  BUS-->>T: push trigger (new TRAP line)
  T->>I: comment @codex TRAP remediation\nerror_mode from trap.reason\nfix and re-emit DONE receipt
```

Read this loop as a set of expectations you can lean on. When an upstream signal lands, autoscribe will externalize it into a flimsie with a parseable PHOSPHENE block; hopper will either start the job or refuse it with a clear reason; prism will create the minimal execution anchor and summon the worker; the apparatus will do the work and leave a single, durable “DONE receipt” perturbation trace; detector will treat that receipt as an invitation to verify rather than a claim to trust; condenser will couple verified work back into the main beam (and, in implementation terms, merge it to `main`) and record the result; and trap will convert any failure state into a remediation loop that points back at the worker with enough context to try again. If everything goes well, the loop closes on `merge_complete`; if anything fails, the loop stays alive because failure becomes a first-class signal rather than a silent dead end.

