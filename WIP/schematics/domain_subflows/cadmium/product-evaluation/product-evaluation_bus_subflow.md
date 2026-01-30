## `<product-evaluation>` subflow — bus-only orchestration (lane: `cadmium`)

Scope: **only** the `<product-evaluation>` orchestration subflow, driven by **bus commits + PR events**:

- Autoscribe → Hopper → Prism → `@codex` summon
- Codex emits a **DONE receipt signal** (bus line) after work completes
- Human opens a PR from the Codex branch to `main` (PR contains the DONE receipt)
- Detector verifies the PR receipt and emits **APPROVE** or **TRAP**
- Condenser waits for checks to pass, then **approves** the PR (no auto-open, no auto-merge)
- Autoscribe may also react to **request signals** addressed to `<product-evaluation>` (bus-native bounce)

- **Signals bus**: `phosphene/signals/bus.jsonl`
- **Canonical lane**: `cadmium`
- **Routing rule**: upstream gantries listen on bus push; detectors/condensers listen on PR events + checks.

---

### Trap (gantry-type error switchboard)

Trap listens for domain trap signals and posts a remediation comment to the issue with a new DONE receipt required after fixes.

---

### Subflow diagram (Mermaid)

```mermaid
sequenceDiagram
  autonumber
  participant BUS as bus.jsonl
  participant AS as gantry.autoscribe.product-evaluation
  participant H as gantry.hopper.product-evaluation
  participant P as gantry.prism.product-evaluation
  participant D as gantry.detector.product-evaluation
  participant K as gantry.condenser.product-evaluation
  participant T as gantry.trap.product-evaluation
  participant I as GitHub Issue
  participant PR as GitHub PR
  participant CX as Codex

  BUS-->>AS: push trigger (request or merge signal)
  AS->>I: create issue ([PHOSPHENE] block)
  AS->>BUS: append issue_created
  BUS-->>H: push trigger (issue_created)
  H->>BUS: append start
  BUS-->>P: push trigger (start)
  P->>BUS: append branch_invoked + @codex summon
  CX->>BUS: append done receipt
  PR-->>D: PR opened (DONE receipt in diff)
  D->>BUS: approve or trap
  PR-->>K: checks complete (approve if green)
  BUS-->>T: trap remediation comment
```

---

### Trigger surface (what makes the machinery move)

Everything is activated by **bus pushes** and **PR events**.

- Autoscribe consumes `phosphene.request.<requesting_domain>.product-evaluation.<work_type>.v1` signals.
- Detectors trigger on PR opened events when the PR contains a DONE receipt in the diff.
- Condensers trigger on checks completed events and approve when checks are green.

---

### Signal contracts (minimal fields; v1)

#### `phosphene.autoscribe.product-evaluation.issue_created.v1`

- **Must include**: `work_id`, `domain:"product-evaluation"`, `issue_number`, `lane:"cadmium"`, `parents:[<request_or_merge_signal_id>]`

#### `phosphene.hopper.product-evaluation.start.v1`

- **Must include**: `work_id`, `issue_number`, `lane:"cadmium"`, `parents:[<issue_created_signal_id>]`

#### `phosphene.prism.product-evaluation.branch_invoked.v1`

- **Must include**: `work_id`, `issue_number`, `lane:"cadmium"`, `phos_id`, `parents:[<start_signal_id>]`

#### `phosphene.done.product-evaluation.receipt.v1`

- **Must include**: `work_id`, `issue_number`, `lane:"cadmium"`, `parents:[<branch_invoked_signal_id>]`

#### `phosphene.detector.product-evaluation.approve.v1`

- **Must include**: `work_id`, `issue_number`, `lane:"cadmium"`, `parents:[<done_receipt_signal_id>]`

#### `phosphene.detector.product-evaluation.trap.v1`

- **Must include**: `work_id`, `issue_number`, `lane:"cadmium"`, `parents:[<done_receipt_signal_id>]`, `reason`

---

### Issue contract (hopper eligibility)

The issue must contain a **FORMAL** `[PHOSPHENE]` block with:

- `lane: cadmium`
- `work_type: product-evaluation`
- `work_id: EVAL-###`
- `intent: ...`
- `upstream_signal_id: <signal_id>`
