## `<product-marketing>` subflow — bus-only orchestration (lane: `beryl`)

Scope: **only** the `<product-marketing>` orchestration subflow, driven entirely by **bus commits**:

- Autoscribe → Hopper → Prism → `@codex` summon
- Codex emits a **DONE receipt signal** (bus line) after work completes
- Detector verifies and emits **APPROVE** or **TRAP**
- Condenser listens for **APPROVE**, opens PR, waits for checks, and merges if green

- **Signals bus**: `phosphene/signals/bus.jsonl`
- **Canonical lane**: `beryl` (product-marketing must not run in other lanes)
- **Routing rule**: gantries **listen on bus push** and **emit follow-on signals to the bus** (no workflow-to-workflow routing via `workflow_dispatch`).

---

### Trap (gantry-type error switchboard)

**Trap is a gantry type** whose only job is **error-loop orchestration**:

- It **listens for trap signals** in the bus (domain-tuned).
- It posts a **targeted remediation prompt** as a **comment on the work issue**, explicitly `@codex`-mentioning the worker.
- The comment carries:
  - an **error mode** (what failed and where),
  - the **expected remediation actions** (what to change, what scripts to rerun),
  - and the **required re-emission** of a fresh DONE receipt signal after fixes.

This gives us a single “switchboard” per domain for dynamic error loops without building bespoke logic into every gantry.

---

### Subflow diagram (Mermaid)

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

  Note over CX: Work happens on the prism branch beam (no PR yet)
  CX->>BUS: append phosphene.done.product-marketing.receipt.v1\n(on branch beam, parents=[branch_invoked])

  BUS-->>D: push trigger (new DONE receipt line)
  D->>D: verify work\nphosphene id validate\nvalidate_persona --all\nvalidate_proposition --all\nproduct-marketing done score

  Note over D,BUS: Detector emits either APPROVE (pass) or TRAP (verification_failed)
  D->>BUS: append phosphene.detector.product-marketing.approve.v1\nparents=[done_receipt]
  D->>BUS: append phosphene.detector.product-marketing.trap.v1\nparents=[done_receipt]\nreason=verification_failed

  BUS-->>K: push trigger (new APPROVE line)
  K->>PR: open PR (branch beam -> main)
  PR-->>CI: run checks

  Note over K,PR: If checks are green, condenser approves+merges
  K->>PR: approve
  K->>PR: merge
  K->>BUS: append phosphene.merge_complete.product-marketing.v1\nparents=[approve]
  K->>I: comment completion + links (PR, merge)

  Note over K,BUS: If checks fail, condenser emits TRAP (checks_failed)
  K->>BUS: append phosphene.detector.product-marketing.trap.v1\nparents=[approve]\nreason=checks_failed

  BUS-->>T: push trigger (new TRAP line)
  T->>I: comment @codex TRAP remediation\nerror_mode from trap.reason\nfix and re-emit DONE receipt
```

---

### Trigger surface (what makes the machinery move)

Everything is activated by **pushes to `phosphene/signals/bus.jsonl`**.

- If a gantry needs to create a “footprint” that triggers the next stage, it **must**:
  - append a signal line to `bus.jsonl`, then
  - **commit + push** the bus change using `PHOSPHENE_HUMAN_TOKEN` (PAT-authored), and
  - ensure checkout does **not** persist `GITHUB_TOKEN` credentials (so the PAT is actually used).

---

### Signal contracts (minimal fields; v1)

#### `phosphene.autoscribe.product-marketing.issue_created.v1`

- **Purpose**: record the issue creation as a durable bus footprint.
- **Must include**
  - `work_id`
  - `domain:"product-marketing"`
  - `issue_number`
  - `lane:"beryl"`
  - `parents:[<merge_signal_id>]`

#### `phosphene.hopper.product-marketing.start.v1`

- **Purpose**: declare that the issue is eligible and work should begin.
- **Must include**
  - `work_id`
  - `issue_number`
  - `lane:"beryl"`
  - `parents:[<issue_created_signal_id>]`

#### `phosphene.prism.product-marketing.branch_invoked.v1`

- **Purpose**: prism “beam” event + Codex summon anchor.
- **Must include**
  - `work_id`
  - `issue_number`
  - `lane:"beryl"`
  - `phos_id` (prism-issued)
  - `parents:[<start_signal_id>]`

#### `phosphene.done.product-marketing.receipt.v1`

- **Purpose**: Codex completion receipt. This is the *only* required completion footprint.
- **Must include**
  - `work_id`
  - `issue_number`
  - `lane:"beryl"`
  - `parents:[<branch_invoked_signal_id>]`

#### `phosphene.detector.product-marketing.approve.v1`

- **Purpose**: detector says the work is verified and eligible for condensation.
- **Must include**
  - `work_id`
  - `issue_number`
  - `lane:"beryl"`
  - `parents:[<done_receipt_signal_id>]`

#### `phosphene.detector.product-marketing.trap.v1`

- **Purpose**: failure signal for trap loops (verification failure, CI failure, etc).
- **Must include**
  - `work_id`
  - `issue_number`
  - `lane:"beryl"`
  - `parents:[<done_receipt_signal_id>]` *(or `[<approve_signal_id>]` if CI fails after approval)*
  - `reason` (e.g. `verification_failed`, `checks_failed`)

#### `gantry.trap.<domain>` behavior (applies here as `gantry.trap.product-marketing`)

- **Purpose**: take a `*.trap.v1` signal and convert it into a domain-tuned `@codex` remediation loop on the issue.
- **Inputs**
  - `phosphene.detector.product-marketing.trap.v1`
- **Outputs**
  - a **comment on the issue** that:
    - includes `@codex`,
    - declares `error_mode` derived from `reason`,
    - provides a minimal “fix plan” (what to rerun / where to look),
    - requires a **fresh DONE receipt** to be appended after fixes.
- **Idempotency (recommended)**
  - include a marker in the trap comment like `PHOSPHENE-TRAP:signal_id:<trap_signal_id>` and no-op if it already exists.

#### `phosphene.merge_complete.product-marketing.v1`

- **Purpose**: registers that the condenser merged the PR successfully.
- **Must include**
  - `work_id`
  - `issue_number`
  - `lane:"beryl"`
  - `parents:[<approve_signal_id>]`

---

### Issue contract (what hopper expects)

The issue must contain a **FORMAL** `[PHOSPHENE]` block (not `INFORMAL`) that includes:

- `lane: beryl`
- `work_type: product-marketing`
- `work_id: <ID>` (e.g. `RA-001` or `VPD-###` depending on your convention)
- `intent: ...`
- `upstream_signal_id: <signal_id>` (optional but strongly preferred)

Labels must include:

- `phosphene`
- `phosphene:domain:product-marketing`
- `phosphene:lane:beryl`
- `phosphene:ready` (and must *not* include blocked/hold labels)

---

### Idempotency rules (how we prevent duplicates)

These checks should hold (and are implemented in the current gantries):

- **Autoscribe idempotency**: if a bus `issue_created` already exists with `parents` containing the triggering merge signal ID, autoscribe no-ops.
- **Hopper idempotency**: if a bus `start` already exists for the `issue_number`, hopper no-ops.
- **Prism idempotency**: if a bus `branch_invoked` already exists whose `parents` contains the `start` signal ID, prism no-ops.
- **Detector idempotency**: if an `approve` or `trap` already exists whose `parents` contains the `done_receipt` signal ID, detector no-ops.
- **Condenser idempotency**: if `merge_complete` already exists whose `parents` contains the `approve` signal ID, condenser no-ops.

