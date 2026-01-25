## `<product-marketing>` subflow — bus-only orchestration (lane: `beryl`)

Scope: **only** the `<product-marketing>` orchestration subflow (Autoscribe → Hopper → Prism → Codex DONE receipt), driven entirely by **bus commits**.

- **Signals bus**: `phosphene/signals/bus.jsonl`
- **Canonical lane**: `beryl` (product-marketing must not run in other lanes)
- **Routing rule**: gantries **listen on bus push** and **emit follow-on signals to the bus** (no workflow-to-workflow routing via `workflow_dispatch`).

---

### Subflow diagram (Mermaid)

```mermaid
sequenceDiagram
  autonumber
  participant BUS as bus.jsonl (main)
  participant AS as gantry.autoscribe.product-marketing
  participant H as gantry.hopper.product-marketing
  participant P as gantry.prism.product-marketing
  participant I as GitHub Issue
  participant CX as Codex (apparatus)

  Note over BUS: Each append is commit+push to main (PAT-authored)

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
  P->>BUS: append phosphene.prism.product-marketing.branch_invoked.v1\nphos_id issued; parents=[start]
  P->>I: comment @codex summon + instructions\n(includes DONE receipt command)

  Note over CX: Work happens on a PR branch
  CX->>BUS: append phosphene.done.product-marketing.receipt.v1\n(in PR branch; parents=[branch_invoked])
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

