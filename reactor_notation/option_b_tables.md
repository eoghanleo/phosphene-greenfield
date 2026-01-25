## Option B — Markdown tables + flow lines (most accessible)

This option is designed for “read it in GitHub, diff it in PRs” usability.

It uses:

- Markdown tables for **components** and **signals**
- a plain code block for **flow**
- a plain list for **annotations**

### Key idea: “signal is wireless”

A flow line like:

```text
autoscribe -> issue_created -> hopper
```

means “autoscribe emitted a bus record of type `issue_created`, and hopper reacted”.

No explicit bus mechanics are required in the notation.

---

## Template

```markdown
<!-- PHOS-REACTOR: <id> -->
<!-- domain: <domain> -->
<!-- lane: <lane> -->
<!-- version: <semver> -->

## Components

| id | kind | type | domain | notes |
|---|---|---|---|---|
| autoscribe | gantry | autoscribe | product-marketing | creates issue + emits issue_created |
| codex | apparatus | codex | product-marketing | does work; emits done_receipt |
| issue | external | github.issue | - | issue thread + @codex summon target |

## Signals

| id | signal_type | from | to | required | optional |
|---|---|---|---|---|---|
| merge_research | phosphene.merge.research.v1 | upstream | autoscribe | work_id, signal_id | - |

## Flow

```text
upstream -> merge_research -> autoscribe
autoscribe -> issue_created -> hopper
```

## Annotations

- gate hopper: requires lane=beryl, ready=true, blocked=false
- idempotency autoscribe: key=parent_signal_id
```

---

## Worked example: `<product-marketing>` bus subflow (beryl)

```markdown
<!-- PHOS-REACTOR: pm.beryl.subflow.v1 -->
<!-- domain: product-marketing -->
<!-- lane: beryl -->
<!-- version: 0.1 -->

## Components

| id | kind | type | domain | notes |
|---|---|---|---|---|
| upstream | external | upstream | - | any upstream domain or human |
| autoscribe | gantry | autoscribe | product-marketing | creates issue; emits issue_created |
| hopper | gantry | hopper | product-marketing | validates issue; emits start |
| prism | gantry | prism | product-marketing | issues phos_id + branch beam; summons codex; emits branch_invoked |
| codex | apparatus | codex | product-marketing | works on branch beam; emits done_receipt |
| detector | gantry | detector | product-marketing | verifies; emits approve or trap |
| condenser | gantry | condenser | product-marketing | opens PR; waits for checks; merges if green; emits merge_complete or trap |
| trap | gantry | trap | product-marketing | error switchboard; @codex remediation comment |
| issue | external | github.issue | - | contains [PHOSPHENE] block + labels |
| pr | external | github.pr | - | created by condenser |
| ci | external | ci | - | checks for PR |

## Signals

| id | signal_type | from | to | required | optional |
|---|---|---|---|---|---|
| merge_research | phosphene.merge.research.v1 | upstream | autoscribe | work_id, signal_id | - |
| issue_created | phosphene.autoscribe.product-marketing.issue_created.v1 | autoscribe | hopper | work_id, issue_number, lane, parents | intent |
| start | phosphene.hopper.product-marketing.start.v1 | hopper | prism | work_id, issue_number, lane, parents | intent |
| branch_invoked | phosphene.prism.product-marketing.branch_invoked.v1 | prism | codex | work_id, issue_number, lane, phos_id, parents | branch_beam_ref |
| done_receipt | phosphene.done.product-marketing.receipt.v1 | codex | detector | work_id, issue_number, lane, parents | - |
| approve | phosphene.detector.product-marketing.approve.v1 | detector | condenser | work_id, issue_number, lane, parents | - |
| trap | phosphene.detector.product-marketing.trap.v1 | detector|condenser | trap | work_id, issue_number, lane, parents, reason | details |
| merge_complete | phosphene.merge_complete.product-marketing.v1 | condenser | upstream | work_id, issue_number, lane, parents | pr_url, merge_sha |

## Flow

```text
upstream -> merge_research -> autoscribe
autoscribe -> issue_created -> hopper
hopper -> start -> prism
prism -> branch_invoked -> codex
codex -> done_receipt -> detector
detector -> approve -> condenser
detector -> trap -> trap
condenser -> merge_complete -> upstream
condenser -> trap -> trap
trap -> (comment @codex remediation) -> issue
```

## Annotations

- lane: product-marketing is always beryl
- issue contract: must be FORMAL [PHOSPHENE] block and include `lane: beryl`, `work_type: product-marketing`, `work_id`
- detector verification: run `phosphene id validate`, `validate_persona --all`, `validate_proposition --all`, and the domain done-score
- detector outcome: emits either `approve` or `trap` (mutually exclusive) for a given `done_receipt`
- condenser behavior: on `approve`, open PR from branch beam -> main; if checks green approve+merge else emit `trap(reason=checks_failed)`
- trap behavior: on `trap`, post a comment on the issue with `@codex`, include `error_mode` derived from `reason`, require fresh `done_receipt` after fixes
- idempotency keys:
  - autoscribe: parent merge signal id
  - hopper: issue_number
  - prism: parent start signal id
  - detector: parent done_receipt signal id
  - condenser: parent approve signal id
```

---

## Parsing notes (for future visualizer)

- The “header” is in HTML comments (`<!-- PHOS-REACTOR: … -->`) so it’s invisible in rendered docs but parseable.
- Tables provide stable, typed data.
- Flow lines are `source -> signal_id -> target` (optional free-text suffix for conditions).
- Annotations are free-form, but should reference component IDs and signal IDs by name.

