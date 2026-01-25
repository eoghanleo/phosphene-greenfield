## `<product-management>` subflow — bus-only orchestration (lane: `cerulean`)

Scope: **only** the `<product-management>` orchestration subflow, driven entirely by **bus commits**:

- Autoscribe → Hopper → Prism → `@codex` summon
- Codex emits a **DONE receipt signal** (bus line) after work completes
- Detector verifies and emits **APPROVE** or **TRAP**
- Condenser opens a PR when it sees **APPROVE** on the branch, then merges once checks are green

- **Signals bus**: `phosphene/signals/bus.jsonl`
- **Canonical lane**: `cerulean` (product-management must not run in other lanes)
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
  participant BUS as bus.jsonl
  participant AS as gantry.autoscribe.product_management
  participant H as gantry.hopper.product_management
  participant P as gantry.prism.product_management
  participant D as gantry.detector.product_management
  participant K as gantry.condenser.product_management
  participant T as gantry.trap.product_management
  participant I as GitHubIssue
  participant PR as GitHubPR
  participant CI as CIChecks
  participant CX as Codex

  Note over BUS: Each append is commit+push using PAT auth (GITHUB_TOKEN pushes do not trigger downstream workflows)

  rect rgb(245,245,245)
    Note over BUS: Upstream signal arrives
    BUS->>BUS: "append phosphene.merge_complete.product-marketing.v1 (work_id=RA-001)"
  end

  BUS-->>AS: push trigger (new merge_complete line)
  AS->>I: create issue (labels + [PHOSPHENE] block)
  AS->>BUS: "append phosphene.autoscribe.product-management.issue_created.v1 (parents=[merge_complete])"

  BUS-->>H: push trigger (new issue_created line)
  H->>I: validate eligibility (domain label, lane=cerulean, ready, not blocked)
  H->>BUS: "append phosphene.hopper.product-management.start.v1 (parents=[issue_created])"

  BUS-->>P: push trigger (new start line)
  P->>BUS: "append phosphene.prism.product-management.branch_invoked.v1 (parents=[start])"
  P->>I: comment "@codex summon + DONE receipt command"
  I-->>CX: @codex mention

  Note over CX: Work happens on a branch (Codex does not open PRs)
  CX->>BUS: "append phosphene.done.product-management.receipt.v1 (parents=[branch_invoked])" 

  Note over BUS,D: Detector watches branch pushes for DONE receipts
  BUS-->>D: push trigger (new DONE receipt line on branch)
  D->>D: verify work (id validate + PRD bundle validator + done score)

  Note over D,BUS: Detector emits either APPROVE (pass) or TRAP (verification_failed)
  D->>BUS: "append phosphene.detector.product-management.approve.v1 (parents=[done_receipt])"
  D->>BUS: "append phosphene.detector.product-management.trap.v1 (parents=[done_receipt], reason=verification_failed)"

  Note over BUS,K: Condenser watches branch pushes for APPROVE
  BUS-->>K: push trigger (new APPROVE line on branch)
  K->>PR: open PR (branch -> main)
  PR-->>CI: run checks
  Note over CI,K: When checks complete, condenser re-evaluates and merges if clean
  K->>PR: merge (only if mergeable_state=clean)
  K->>BUS: "append phosphene.merge_complete.product-management.v1 (parents=[approve])"
  K->>I: comment completion + links (PR, merge)

  Note over K,BUS: If checks fail, condenser emits TRAP (checks_failed)
  K->>BUS: "append phosphene.detector.product-management.trap.v1 (parents=[approve], reason=checks_failed)"

  BUS-->>T: push trigger (new TRAP line)
  T->>I: comment "@codex TRAP remediation (fix + re-emit DONE receipt)"
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

#### `phosphene.autoscribe.product-management.issue_created.v1`

- **Purpose**: record issue creation as a durable bus footprint.
- **Must include**
  - `work_id`
  - `domain:"product-management"`
  - `issue_number`
  - `lane:"cerulean"`
  - `parents:[<merge_complete_signal_id>]`

#### `phosphene.hopper.product-management.start.v1`

- **Purpose**: declare that the issue is eligible and work should begin.
- **Must include**
  - `work_id`
  - `issue_number`
  - `lane:"cerulean"`
  - `parents:[<issue_created_signal_id>]`

#### `phosphene.prism.product-management.branch_invoked.v1`

- **Purpose**: prism “beam” event + Codex summon anchor.
- **Must include**
  - `work_id`
  - `issue_number`
  - `lane:"cerulean"`
  - `phos_id` (prism-issued)
  - `parents:[<start_signal_id>]`

#### `phosphene.done.product-management.receipt.v1`

- **Purpose**: Codex completion receipt. This is the *only* required completion footprint.
- **Must include**
  - `work_id`
  - `issue_number`
  - `lane:"cerulean"`
  - `parents:[<branch_invoked_signal_id>]`

#### `phosphene.detector.product-management.approve.v1`

- **Purpose**: detector says the work is verified and eligible for condensation.
- **Must include**
  - `work_id`
  - `issue_number`
  - `lane:"cerulean"`
  - `parents:[<done_receipt_signal_id>]`

#### `phosphene.detector.product-management.trap.v1`

- **Purpose**: failure signal for trap loops (verification failure, CI failure, etc).
- **Must include**
  - `work_id`
  - `issue_number`
  - `lane:"cerulean"`
  - `parents:[<done_receipt_signal_id>]` *(or `[<approve_signal_id>]` if CI fails after approval)*
  - `reason` (e.g. `verification_failed`, `checks_failed`)

#### `gantry.trap.<domain>` behavior (here: `gantry.trap.product-management`)

- **Purpose**: take a `*.trap.v1` signal and convert it into a domain-tuned `@codex` remediation loop on the issue.
- **Inputs**
  - `phosphene.detector.product-management.trap.v1`
- **Outputs**
  - a **comment on the issue** that:
    - includes `@codex`,
    - declares `error_mode` derived from `reason`,
    - provides a minimal “fix plan” (what to rerun / where to look),
    - requires a **fresh DONE receipt** to be appended after fixes.
- **Idempotency (recommended)**
  - include a marker in the trap comment like `PHOSPHENE-TRAP:signal_id:<trap_signal_id>` and no-op if it already exists.

#### `phosphene.merge_complete.product-management.v1`

- **Purpose**: registers that the condenser merged the PR successfully.
- **Must include**
  - `work_id`
  - `issue_number`
  - `lane:"cerulean"`
  - `parents:[<approve_signal_id>]`

---

### Issue contract (what hopper expects)

The issue must contain a **FORMAL** `[PHOSPHENE]` block (not `INFORMAL`) that includes:

- `lane: cerulean`
- `work_type: product-management`
- `work_id: PRD-###`
- `intent: ...`
- `upstream_signal_id: <signal_id>` (optional but strongly preferred)

Labels must include:

- `phosphene`
- `phosphene:domain:product-management`
- `phosphene:lane:cerulean`
- `phosphene:ready` (and must *not* include blocked/hold labels)

---

### Idempotency rules (how we prevent duplicates)

- **Autoscribe idempotency**: if a bus `issue_created` already exists with `parents` containing the triggering merge signal ID, autoscribe no-ops.
- **Hopper idempotency**: if a bus `start` already exists for the `issue_number`, hopper no-ops.
- **Prism idempotency**: if a bus `branch_invoked` already exists whose `parents` contains the `start` signal ID, prism no-ops.
- **Detector idempotency**: if an `approve` or `trap` already exists whose `parents` contains the `done_receipt` signal ID, detector no-ops.
- **Condenser idempotency**: if `merge_complete` already exists whose `parents` contains the `approve` signal ID, condenser no-ops.
