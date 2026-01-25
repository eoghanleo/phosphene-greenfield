## Option C — YAML schema (most machine-friendly)

This option is intended to be the easiest to parse for a future visualizer.

- Highly structured
- Supports both **graph view** (nodes + signal edges) and **sequence view** (ordered scenes)
- Keeps **annotations separate** and attachable by IDs

### Key idea: “signal is wireless”

Signals are modeled as edges between nodes, without requiring explicit “bus commit” steps in the data model.

If desired, a visualizer can render a **bus-centric view** by treating all signals as implicitly flowing through the bus.

---

## Schema (v0.1)

```yaml
metadata:
  reactor_id: string
  domain: string
  lane: string
  version: string
  description: string

nodes:
  - id: string
    kind: bus|gantry|apparatus|external
    type: string
    domain: string|null
    label: string

signals:
  - id: string
    signal_type: string
    from: string     # node id
    to: string       # node id
    parents: [string]  # signal ids (not node ids)
    required_fields: [string]
    optional_fields: [string]

sequence:
  - id: string
    label: string
    steps:
      - signal: string   # signal id
        note: string|null

annotations:
  - id: string
    target_kind: node|signal|sequence
    target_id: string
    annotation_type: contract|gate|idempotency|error_mode|note
    content: string
```

---

## Worked example: `<product-marketing>` subflow (beryl)

```yaml
metadata:
  reactor_id: pm.beryl.subflow.v1
  domain: product-marketing
  lane: beryl
  version: "0.1"
  description: "Product-marketing subflow with approve/trap + condenser + trap loop"

nodes:
  - { id: bus, kind: bus, type: bus.jsonl, domain: null, label: "bus.jsonl" }
  - { id: upstream, kind: external, type: upstream, domain: null, label: "Upstream" }
  - { id: autoscribe, kind: gantry, type: autoscribe, domain: product-marketing, label: "Autoscribe" }
  - { id: hopper, kind: gantry, type: hopper, domain: product-marketing, label: "Hopper" }
  - { id: prism, kind: gantry, type: prism, domain: product-marketing, label: "Prism" }
  - { id: codex, kind: apparatus, type: codex, domain: product-marketing, label: "Codex" }
  - { id: detector, kind: gantry, type: detector, domain: product-marketing, label: "Detector" }
  - { id: condenser, kind: gantry, type: condenser, domain: product-marketing, label: "Condenser" }
  - { id: trap, kind: gantry, type: trap, domain: product-marketing, label: "Trap" }
  - { id: issue, kind: external, type: github.issue, domain: null, label: "GitHub Issue" }
  - { id: pr, kind: external, type: github.pr, domain: null, label: "GitHub PR" }
  - { id: ci, kind: external, type: ci, domain: null, label: "CI" }

signals:
  - id: merge_research
    signal_type: phosphene.merge.research.v1
    from: upstream
    to: autoscribe
    parents: []
    required_fields: [work_id, signal_id]
    optional_fields: []

  - id: issue_created
    signal_type: phosphene.autoscribe.product-marketing.issue_created.v1
    from: autoscribe
    to: hopper
    parents: [merge_research]
    required_fields: [work_id, issue_number, lane, parents]
    optional_fields: [intent]

  - id: start
    signal_type: phosphene.hopper.product-marketing.start.v1
    from: hopper
    to: prism
    parents: [issue_created]
    required_fields: [work_id, issue_number, lane, parents]
    optional_fields: [intent]

  - id: branch_invoked
    signal_type: phosphene.prism.product-marketing.branch_invoked.v1
    from: prism
    to: codex
    parents: [start]
    required_fields: [work_id, issue_number, lane, phos_id, parents]
    optional_fields: [branch_beam_ref]

  - id: done_receipt
    signal_type: phosphene.done.product-marketing.receipt.v1
    from: codex
    to: detector
    parents: [branch_invoked]
    required_fields: [work_id, issue_number, lane, parents]
    optional_fields: []

  - id: approve
    signal_type: phosphene.detector.product-marketing.approve.v1
    from: detector
    to: condenser
    parents: [done_receipt]
    required_fields: [work_id, issue_number, lane, parents]
    optional_fields: []

  - id: trap_verification
    signal_type: phosphene.detector.product-marketing.trap.v1
    from: detector
    to: trap
    parents: [done_receipt]
    required_fields: [work_id, issue_number, lane, parents, reason]
    optional_fields: [details]

  - id: merge_complete
    signal_type: phosphene.merge_complete.product-marketing.v1
    from: condenser
    to: upstream
    parents: [approve]
    required_fields: [work_id, issue_number, lane, parents]
    optional_fields: [pr_url, merge_sha]

  - id: trap_checks
    signal_type: phosphene.detector.product-marketing.trap.v1
    from: condenser
    to: trap
    parents: [approve]
    required_fields: [work_id, issue_number, lane, parents, reason]
    optional_fields: [details]

sequence:
  - id: happy_path
    label: "Happy path (approve → PR → merge)"
    steps:
      - { signal: merge_research, note: "Upstream signal arrives" }
      - { signal: issue_created, note: "Autoscribe creates issue + emits issue_created" }
      - { signal: start, note: "Hopper validates issue and emits start" }
      - { signal: branch_invoked, note: "Prism issues phos_id, summons codex" }
      - { signal: done_receipt, note: "Codex completes work and emits DONE receipt" }
      - { signal: approve, note: "Detector verifies and emits APPROVE" }
      - { signal: merge_complete, note: "Condenser opens PR, checks green, merges" }

annotations:
  - id: lane_rule
    target_kind: node
    target_id: hopper
    annotation_type: gate
    content: "Requires lane=beryl for product-marketing."

  - id: detector_verification
    target_kind: node
    target_id: detector
    annotation_type: note
    content: "Runs: phosphene id validate; validate_persona --all; validate_proposition --all; product-marketing done score."

  - id: detector_outcome
    target_kind: node
    target_id: detector
    annotation_type: constraint
    content: "Emits either approve or trap_verification per done_receipt."

  - id: trap_contract
    target_kind: node
    target_id: trap
    annotation_type: contract
    content: "On trap signal, post @codex remediation comment on issue; require fresh done_receipt after fixes. Idempotency marker: PHOSPHENE-TRAP:signal_id:<trap_signal_id>."
```

